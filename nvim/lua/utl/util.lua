local vim = vim

local M = {}

function M.document_formatting() -- -s-
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
end -- -e-

function M.show_documentation() -- -s-
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
end -- -e-

function M.go_to_definition() -- -s-
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
end -- -e-

-- -s-
--[[
{
  name = '',
  autocommands = {
    {
      event = '',
      glob = '',
      cmd = ''
    }
  }
}
--]]
function M.augroup(opts)
  vim.cmd('augroup ' .. opts.name)
  vim.cmd('au!')
  for _, au in ipairs(opts.autocmds) do
    vim.cmd('au ' .. au.event .. ' ' .. au.glob .. ' ' .. au.cmd)
  end
  vim.cmd('augroup END')
end
-- -e-

function M.command(lhs, rhs, opts) -- -s-
  local parts = {
    'command!', '-nargs=' .. (opts.nargs or '0'),
    opts.complete and '-complete=' .. opts.complete or '', opts.bang and '-bang' or '',
    opts.range and '-range' or '', opts.buffer and '-buffer' or '', lhs, rhs,
  }
  vim.cmd(table.concat(parts, ' '))
end -- -e-

function M.toggle_bool_option(scope, opt) -- -s-
  if vim[scope] and vim[scope][opt] ~= nil and type(vim[scope][opt]) == 'boolean' then
    vim[scope][opt] = not vim[scope][opt]
  end
end -- -e-

local function edge_of_screen(d) -- -s-
  local w = vim.fn.winnr()
  vim.cmd('silent! wincmd ' .. d)
  local n = vim.fn.winnr()
  vim.cmd('silent! ' .. w .. ' wincmd w')
  return w == n
end -- -e-

function M.resize_window(d) -- -s-
  local inc = vim.g.resize_increment or 2
  if vim.fn.winnr('$') == 1 then return end
  local dir = ''
  if d == 'h' or d == 'l' then dir = 'vertical' end
  local edge = edge_of_screen(d) and '-' or '+'
  if dir == '' and edge == '-' then if edge_of_screen((d == 'j') and 'k' or 'j') then return end end
  vim.cmd(dir .. ' resize ' .. edge .. inc)
end -- -e-

function M.basic_os_info() -- -s-
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
    if env_OS and env_ARCH then name, arch = env_OS, env_ARCH end
  end

  return name, arch
end -- -e-

function M.run_cmd(cmd, strip) -- -s-
  local handle = io.popen(cmd)
  local result = handle:read('*a')
  handle:close()
  if strip then result = result:gsub('^%s*(.-)%s*$', '%1') end
  return result
end -- -e-

return M
