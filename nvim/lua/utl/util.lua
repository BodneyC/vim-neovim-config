local M = {}

function M.replace_termcodes(s)
  return vim.api.nvim_replace_termcodes(s, true, true, true)
end

function M.feedkeys(s, mode)
  vim.api.nvim_feedkeys(M.replace_termcodes(s), mode, true)
end

function M.safe_require(module)
  local ok, err = pcall(require, module)
  if not ok then
    print('Module \'' .. module .. '\' not required: ' .. err)
    err = nil
  end
  return err
end

function M.safe_require_and_init(module)
  local mod = M.safe_require(module)
  if mod then
    mod.init()
  end
end

function M.opt(s, d)
  for k, v in pairs(d) do
    vim[s][k] = v
  end
end

function M.document_formatting()
  local clients = vim.lsp.buf_get_clients()
  if #clients > 0 then
    for _, o in pairs(clients) do
      if o.resolved_capabilities.document_formatting ~= false then
        vim.lsp.buf.formatting()
        return
      end
    end
  end
  vim.cmd('w')
  vim.cmd('FormatWrite')
end

function M.show_documentation()
  if #vim.lsp.buf_get_clients() ~= 0 then
    vim.lsp.buf.hover()
  else
    if vim.bo.ft == 'vim' then
      vim.cmd('H ' .. vim.fn.expand('<cword>'))
    elseif string.match(vim.bo.ft, 'z?sh') then
      vim.cmd('M ' .. vim.fn.expand('<cword>'))
    else
      print('No hover candidate found')
    end
  end
end

function M.go_to_definition()
  if #vim.lsp.buf_get_clients() ~= 0 then
    vim.lsp.buf.definition()
  else
    for _, wrd in ipairs({'<cword>', '<cWORD>', '<cexpr>'}) do
      local word = vim.fn.expand(wrd)
      if #(vim.fn.taglist('^' .. word .. '$')) then
        vim.cmd('tag ' .. word)
        return
      end
    end
    vim.cmd('redraw')
    print('No definition found')
  end
end

--[[
util.augroup {
  name = '',
  autocommands = {
    {
      event = '',
      glob = '',
      cmd = ''
    }
  },
  nobang = true|false,
}
--]]
function M.augroup(opts)
  vim.cmd('augroup ' .. opts.name)
  if opts.nobang == true then
    vim.cmd('au!')
  end
  for _, au in ipairs(opts.autocmds or opts.autocommands) do
    vim.cmd('au ' .. au.event .. ' ' .. au.glob .. ' ' .. au.cmd)
  end
  vim.cmd('augroup END')
end

function M.autogroup(opts)
  M.augroup(opts)
end

function M.make_mappings(mappings)
  local bskm = vim.api.nvim_buf_set_keymap
  local skm = vim.api.nvim_set_keymap
  for _, e in ipairs(mappings) do
    local args = e.args or {}
    if not e.mode or not e.key or not e.cmd then
      print('Skipping: ' .. vim.inspect(e))
    end
    if e.bufnr then
      bskm(e.bufnr, e.mode, e.key, e.cmd, args)
    else
      skm(e.mode, e.key, e.cmd, args)
    end
  end
end

function M.command(lhs, rhs, opts)
  local parts = {
    'command!',
    '-nargs=' .. (opts.nargs or '0'),
    opts.complete and '-complete=' .. opts.complete or '',
    opts.bang and '-bang' or '',
    opts.range and '-range' or '',
    opts.buffer and '-buffer' or '',
    lhs,
    rhs,
  }
  vim.cmd(table.concat(parts, ' '))
end

--[[
util.commands({
  {
    name = '...',
    cmd = ':...<CR>',
    opts = {},
  },
})
--]]
function M.commands(cmds)
  for _, cmd in ipairs(cmds) do
    M.command(cmd.name, cmd.cmd, cmd.opts)
  end
end

vim.cmd(
  [[cnoreabbrev SortLen ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }']])

function M.toggle_bool_option(scope, opt)
  if vim[scope] and vim[scope][opt] ~= nil and type(vim[scope][opt]) ==
    'boolean' then
    vim[scope][opt] = not vim[scope][opt]
  end
end

local function edge_of_screen(d)
  local w = vim.fn.winnr()
  vim.cmd('silent! wincmd ' .. d)
  local n = vim.fn.winnr()
  vim.cmd('silent! ' .. w .. ' wincmd w')
  return w == n
end

function M.resize_window(d)
  local inc = vim.g.resize_increment or 2
  if vim.fn.winnr('$') == 1 then
    return
  end
  local dir = ''
  if d == 'h' or d == 'l' then
    dir = 'vertical'
  end
  local edge = edge_of_screen(d) and '-' or '+'
  if dir == '' and edge == '-' then
    if edge_of_screen((d == 'j') and 'k' or 'j') then
      return
    end
  end
  vim.cmd(dir .. ' resize ' .. edge .. inc)
end

function M.basic_os_info()
  local name, arch = '', ''

  local popen_status, popen_result = pcall(io.popen, '')
  if popen_status then
    popen_result:close()
    name = io.popen('uname -s', 'r'):read('*l')
    arch = io.popen('uname -m', 'r'):read('*l')
  else
    -- Windows
    local env_OS = os.getenv('OS')
    local env_ARCH = os.getenv('PROCESSOR_ARCHITECTURE')
    if env_OS and env_ARCH then
      name, arch = env_OS, env_ARCH
    end
  end

  return name, arch
end

function M.run_cmd(cmd, strip)
  local handle = io.popen(cmd)
  local result = handle:read('*a')
  handle:close()
  if strip then
    result = result:gsub('^%s*(.-)%s*$', '%1')
  end
  return result
end

return M
