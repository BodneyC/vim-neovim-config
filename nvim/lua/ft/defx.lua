local vim = vim
local skm = vim.api.nvim_set_keymap

local function str_tree_or_open(if_dir, if_file)
  return "defx#is_directory() ? defx#do_action('open_tree'" ..
      (if_dir and ", '" .. if_dir .. "'" or "") .. ") " ..
    ": defx#do_action('open'" ..
      (if_file and ", '" .. if_file .. "'" or "") .. ")"
end

skm('n', '<CR>',          str_tree_or_open('recursive:10', 'botright vsplit'), { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'gl',            str_tree_or_open('recursive:10', 'botright vsplit'), { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'O',             str_tree_or_open('recursive:10', 'wincmd p \\| e'),  { noremap = true, silent = true, buffer = true, expr = true })
skm('n', '<2-LeftMouse>', str_tree_or_open(nil,            'wincmd p \\| e'),  { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'o',             str_tree_or_open(nil,            'wincmd p \\| e'),  { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'l',             str_tree_or_open(nil,            'wincmd p \\| e'),  { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'h',       "defx#do_action('close_tree')",      { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'q',       "defx#do_action('quit')",            { noremap = true, silent = true, buffer = true, expr = true })
skm('n', '!',       "defx#do_action('execute_command')", { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'a',       "defx#do_action('new_file')",        { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'A',       "defx#do_action('new_directory')",   { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'r',       "defx#do_action('rename')",          { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'R',       "defx#redraw()",                     { noremap = true, silent = true, buffer = true, expr = true })
skm('n', '<Space>', "defx#do_action('toggle_select')",   { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'Y',       "defx#do_action('yank_path')",       { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'c',       "defx#do_action('copy')",            { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'C',       "defx#do_action('move')",            { noremap = true, silent = true, buffer = true, expr = true })
skm('n', 'p',       "defx#do_action('paste')",           { noremap = true, silent = true, buffer = true, expr = true })

let s:defx_rem_prev = []

func! s:defx_rem_rm(ctx) abort
  call add(s:defx_rem_prev, a:ctx.targets)
  let cmd = 'rem rm ' . join(a:ctx.targets, ' ')
  echom cmd
  call system(cmd)
endfunc
nnoremap <silent><buffer><expr> dd defx#do_action('call', '<SID>defx_rem_rm')

func! s:defx_rem_rs(ctx) abort
  if len(s:defx_rem_prev) && len(s:defx_rem_prev[0])
    let cmd = 'rem rs ' . join(s:defx_rem_prev[-1], ' ')
    echom cmd
    call system(cmd)
    let s:defx_rem_prev = s:defx_rem_prev[:-2]
  else
    echom 'Nothing remed yet'
  endif
endfunc

nnoremap <silent><buffer><expr> u defx#do_action('call', '<SID>defx_rem_rs')
