local vim = vim
local skm = vim.api.nvim_set_keymap

local M = {}

DEFX_REM_STACK = {}

function M.defx_rem_rm(ctx)
  local t = ctx.targets
  if type(t) == 'string' then
    t = { t }
  end
  table.insert(DEFX_REM_STACK, t)
  local cmd = 'rem rm ' .. table.concat(t, ' ')
  print(cmd)
  os.execute(cmd)
end

skm('n', 'dd', "defx#do_action('execute_command', 'lua require\"ft.defx\".defx_rem_rm')", { noremap = true, silent = true, buffer = true, expr = true })

function M.defx_rem_rs(ctx)
  if #DEFX_REM_STACK > 0 and #DEFX_REM_STACK[1] > 0 then
    local cmd = 'rem rs ' .. table.concat(DEFX_REM_STACK[1], ' ')
    print(cmd)
    os.execute(cmd)
    table.remove(DEFX_REM_STACK)
  else
    print('Nothing remed yet')
  end
end

skm('n', 'dd', "defx#do_action('execute_command', 'lua require\"ft.defx\".defx_rem_rs')", { noremap = true, silent = true, buffer = true, expr = true })

local function str_tree_or_open(if_dir, if_file)
  return "defx#is_directory() ? defx#do_action('open_tree'" ..
      (if_dir and ", '" .. if_dir .. "'" or "") .. ") " ..
    ": defx#do_action('open'" ..
      (if_file and ", '" .. if_file .. "'" or "") .. ")"
end

function M.init()
  skm('n', '<CR>',          str_tree_or_open('recursive:10',     'botright vsplit'), { noremap = true, silent = true, buffer = true, expr = true })
  skm('n', 'gl',            str_tree_or_open('recursive:10',     'botright vsplit'), { noremap = true, silent = true, buffer = true, expr = true })
  skm('n', 'O',             str_tree_or_open('recursive:10',     'wincmd p \\| e'),  { noremap = true, silent = true, buffer = true, expr = true })
  skm('n', '<2-LeftMouse>', str_tree_or_open(nil,                'wincmd p \\| e'),  { noremap = true, silent = true, buffer = true, expr = true })
  skm('n', 'o',             str_tree_or_open(nil,                'wincmd p \\| e'),  { noremap = true, silent = true, buffer = true, expr = true })
  skm('n', 'l',             str_tree_or_open(nil,                'wincmd p \\| e'),  { noremap = true, silent = true, buffer = true, expr = true })
  skm('n', 'h',             "defx#do_action('close_tree')",      { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', 'q',             "defx#do_action('quit')",            { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', '!',             "defx#do_action('execute_command')", { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', 'a',             "defx#do_action('new_file')",        { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', 'A',             "defx#do_action('new_directory')",   { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', 'r',             "defx#do_action('rename')",          { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', 'R',             "defx#redraw()",                     { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', '<Space>',       "defx#do_action('toggle_select')",   { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', 'Y',             "defx#do_action('yank_path')",       { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', 'c',             "defx#do_action('copy')",            { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', 'C',             "defx#do_action('move')",            { noremap = true,   silent = true,    buffer = true, expr = true })
  skm('n', 'p',             "defx#do_action('paste')",           { noremap = true,   silent = true,    buffer = true, expr = true })
end

return M
