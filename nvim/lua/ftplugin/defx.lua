local vim = vim
local bskm = vim.api.nvim_buf_set_keymap
local util = require'utl.util'

if not DEFX_REM_STACK then
  DEFX_REM_STACK = {}
end

local M = {}

M.defx_rem_rm = function(targets)
  table.insert(DEFX_REM_STACK, targets)
  local cmd = 'rem rm ' .. table.concat(targets, ' ')
  print(cmd)
  os.execute(cmd)
end

M.defx_rem_rs = function()
  if #DEFX_REM_STACK > 0 and #DEFX_REM_STACK[#DEFX_REM_STACK] > 0 then
    local cmd = 'rem rs ' .. table.concat(DEFX_REM_STACK[#DEFX_REM_STACK], ' ')
    print(cmd)
    os.execute(cmd)
    table.remove(DEFX_REM_STACK)
  else
    print('Nothing remed yet')
  end
end

local str_tree_or_open = function(if_dir, if_file)
  return "defx#is_directory() ? defx#do_action('open_tree'" ..
      (if_dir and ", '" .. if_dir .. "'" or "") .. ") " ..
    ": defx#do_action('open'" ..
      (if_file and ", '" .. if_file .. "'" or "") .. ")"
end

M.init = function()
  util.func([[
    func! __DEFX_REM_RM(ctx) abort
      exe "lua require'ftplugin.defx'.defx_rem_rm({'" . join(a:ctx.targets, "', '") . "'})"
    endfunc
  ]])
  util.func([[
    func! __DEFX_REM_RS(ctx) abort
      lua require'ftplugin.defx'.defx_rem_rs()
    endfunc
  ]])

  vim.wo.number = false
  vim.wo.relativenumber = false

  bskm(0, 'n', 'u',  "defx#do_action('call', '__DEFX_REM_RS')", { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'dd', "defx#do_action('call', '__DEFX_REM_RM')", { noremap = true, silent = true, expr = true })

  bskm(0, 'n', '<CR>',          str_tree_or_open('recursive:10', 'botright vsplit'), { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'gl',            str_tree_or_open('recursive:10', 'botright vsplit'), { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'O',             str_tree_or_open('recursive:10', 'wincmd p | e'),    { noremap = true, silent = true, expr = true })
  bskm(0, 'n', '<2-LeftMouse>', str_tree_or_open(nil,            'wincmd p | e'),    { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'o',             str_tree_or_open(nil,            'wincmd p | e'),    { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'l',             str_tree_or_open(nil,            'wincmd p | e'),    { noremap = true, silent = true, expr = true })

  bskm(0, 'n', 'h',       "defx#do_action('close_tree')",      { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'q',       "defx#do_action('quit')",            { noremap = true, silent = true, expr = true })
  bskm(0, 'n', '!',       "defx#do_action('execute_command')", { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'a',       "defx#do_action('new_file')",        { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'A',       "defx#do_action('new_directory')",   { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'r',       "defx#do_action('rename')",          { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'R',       "defx#redraw()",                     { noremap = true, silent = true, expr = true })
  bskm(0, 'n', '<Space>', "defx#do_action('toggle_select')",   { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'cc',      "defx#do_action('yank_path')",       { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'yy',      "defx#do_action('copy')",            { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'Y',       "defx#do_action('copy')",            { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'x',       "defx#do_action('move')",            { noremap = true, silent = true, expr = true })
  bskm(0, 'n', 'p',       "defx#do_action('paste')",           { noremap = true, silent = true, expr = true })
end

return M
