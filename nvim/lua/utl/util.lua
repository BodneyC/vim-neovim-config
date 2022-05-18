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

local store = require('utl.fn_store')

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
  }
  if type(rhs) == 'string' then
    table.insert(parts, rhs)
  elseif type(rhs) == 'function' then
    table.insert(parts, store.fn_aug(rhs))
  end
  vim.cmd(table.concat(parts, ' '))
end

--[[
util.commands({
  {
    name = '...',
    cmd = ':...<CR>',        -- or .lua_fn
    lua_fn = function() end, -- or .cmd
    opts = {},
  },
})
--]]
function M.commands(cmds)
  for _, cmd in ipairs(cmds) do
    M.command(cmd.name, cmd.cmd or cmd.lua_fn, cmd.opts)
  end
end

function M.toggle_bool_option(scope, opt)
  if vim[scope] and vim[scope][opt] ~= nil and type(vim[scope][opt]) ==
    'boolean' then
    vim[scope][opt] = not vim[scope][opt]
  end
end

local function last_win_of_screen(d)
  local w = vim.fn.winnr()
  vim.cmd('silent! wincmd ' .. d)
  local n = vim.fn.winnr()
  vim.cmd('silent! ' .. w .. ' wincmd w')
  return w == n
end

function M.resize_window(dir)
  local inc = vim.g.resize_increment or 2
  if vim.fn.winnr('$') == 1 then
    return
  end
  local horz_vert = ''
  if dir == 'h' or dir == 'l' then
    horz_vert = 'vertical'
  end

  local opp_dir = 'h'
  if dir == 'h' then
    opp_dir = 'l'
  elseif dir == 'j' then
    opp_dir = 'k'
  elseif dir == 'k' then
    opp_dir = 'j'
  end

  local last_win_in_d = last_win_of_screen(dir)
  local last_win_in_opp_d = last_win_of_screen(opp_dir)

  local pos_neg_dir = '+'

  if last_win_in_d then
    pos_neg_dir = '-'
  elseif not last_win_in_d and (dir == 'j') then
    pos_neg_dir = '+'
  elseif not last_win_in_d and not last_win_in_opp_d then
    if dir == 'l' then
      pos_neg_dir = '+'
    else
      pos_neg_dir = '-'
    end
  end

  if horz_vert == '' and pos_neg_dir == '-' then
    if last_win_of_screen((dir == 'j') and 'k' or 'j') then
      return
    end
  end
  vim.cmd(horz_vert .. ' resize ' .. pos_neg_dir .. inc)
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

return M
