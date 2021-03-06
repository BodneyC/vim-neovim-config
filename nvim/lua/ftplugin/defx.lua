local vim = vim
local bskm = vim.api.nvim_buf_set_keymap
local util = require 'utl.util'

if not DEFX_REM_STACK then DEFX_REM_STACK = {} end

local M = {}

function M.defx_rem_rm(targets)
  table.insert(DEFX_REM_STACK, targets)
  local cmd = 'rem rm ' .. table.concat(targets, ' ')
  print(cmd)
  os.execute(cmd)
end

function M.defx_rem_rs()
  if #DEFX_REM_STACK > 0 and #DEFX_REM_STACK[#DEFX_REM_STACK] > 0 then
    local cmd = 'rem rs ' .. table.concat(DEFX_REM_STACK[#DEFX_REM_STACK], ' ')
    print(cmd)
    os.execute(cmd)
    table.remove(DEFX_REM_STACK)
  else
    print('Nothing remed yet')
  end
end

function M.defx_find_window_for(fn)
  if vim.fn.buflisted(vim.fn.bufnr('#')) == 1 then
    vim.cmd('wincmd p | e ' .. fn)
    return
  end
  for i = 1, vim.fn.winnr('$') do
    if vim.fn.buflisted(vim.fn.winbufnr(i)) == 1 then
      vim.cmd(i .. 'wincmd w | e ' .. fn)
      return
    end
  end
  print('Couldn\'t find a suitable window')
end

function M.init()
  vim.cmd([[
    func! __DEFX_REM_RM(ctx) abort
      exe "lua require'ftplugin.defx'.defx_rem_rm({'" . join(a:ctx.targets, "', '") . "'})"
    endfunc
    func! __DEFX_REM_RS(ctx) abort
      lua require'ftplugin.defx'.defx_rem_rs()
    endfunc
  ]])

  vim.wo.number = false
  vim.wo.relativenumber = false

  local nse = {noremap = true, silent = true, expr = true}

  bskm(0, 'n', 'u',  [[defx#do_action('call', '__DEFX_REM_RS')]], nse)
  bskm(0, 'n', 'dd', [[defx#do_action('call', '__DEFX_REM_RM')]], nse)
  bskm(0, 'n', '+x', [[defx#do_action('execute_command', 'chmod +x %')]], nse)
  bskm(0, 'n', '-x', [[defx#do_action('execute_command', 'chmod -x %')]], nse)
  bskm(0, 'n', 'G', [[G0]], {noremap = true, silent = true})

  local function str_tree_or_open(if_dir, if_file)
    return 'defx#is_directory() ? defx#do_action(\'open_tree\'' ..
               (if_dir and ', \'' .. if_dir .. '\'' or '') .. ') ' .. ': defx#do_action(\'open\'' ..
               (if_file and ', \'' .. if_file .. '\'' or '') .. ')'
  end

  util.command('DefxFindWindowFor', 'lua require\'ftplugin.defx\'.defx_find_window_for(<f-args>)',
      {nargs = 1})

  bskm(0, 'n', '<leader>r',  "<CMD>lua require'mod.defx'.resize()<CR>", {noremap = true, silent = true})

  bskm(0, 'n', '<CR>', str_tree_or_open('recursive:10', 'botright vsplit'), nse)
  bskm(0, 'n', 'gl', str_tree_or_open('recursive:10', 'botright vsplit'), nse)
  bskm(0, 'n', 'O', str_tree_or_open('recursive:10', 'wincmd p | e'), nse)
  bskm(0, 'n', '<2-LeftMouse>', str_tree_or_open(nil, 'wincmd p | e'), nse)
  bskm(0, 'n', 'o', str_tree_or_open(nil, 'wincmd p | e'), nse)
  bskm(0, 'n', 'l', str_tree_or_open(nil, 'DefxFindWindowFor'), nse)

  bskm(0, 'n', 'h', 'defx#do_action(\'close_tree\')', nse)
  bskm(0, 'n', 'q', 'defx#do_action(\'quit\')', nse)
  bskm(0, 'n', '!', 'defx#do_action(\'execute_command\')', nse)
  bskm(0, 'n', 'a', 'defx#do_action(\'new_file\')', nse)
  bskm(0, 'n', 'A', 'defx#do_action(\'new_directory\')', nse)
  bskm(0, 'n', 'r', 'defx#do_action(\'rename\')', nse)
  bskm(0, 'n', 'R', 'defx#redraw()', nse)
  bskm(0, 'n', '<Space>', 'defx#do_action(\'toggle_select\')', nse)
  bskm(0, 'n', 'cc', 'defx#do_action(\'yank_path\')', nse)
  bskm(0, 'n', 'yy', 'defx#do_action(\'copy\')', nse)
  bskm(0, 'n', 'Y', 'defx#do_action(\'copy\')', nse)
  bskm(0, 'n', 'x', 'defx#do_action(\'move\')', nse)
  bskm(0, 'n', 'p', 'defx#do_action(\'paste\')', nse)
end

return M
