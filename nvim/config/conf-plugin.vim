let g:togool_extras =
      \ [['<', '+'],
      \  ['>', '-']]

let g:virk_tags_enable = 0

let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_enabled = 1
let g:indentLine_char = '·'
let g:indentLine_first_char = '·'
let g:indentLine_fileTypeExclude = [ "markdown" ]

let g:mundo_right = 1

let g:comfortable_motion_air_drag = 1
let g:comfortable_motion_friction = 100

let g:tagbar_auto_close = 1

" let g:gutentags_trace = 1
let g:gutentags_cache_dir = expand('$HOME/.cache/vim/tags')
if ! isdirectory(g:gutentags_cache_dir)
  call mkdir(g:gutentags_cache_dir, 'p')
endif
let g:gutentags_modules = ['ctags']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_ctags_auto_set_tags = 1
let g:gutentags_project_root = ['.git']
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \   '--tag-relative=always',
      \   '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = ['*.json']

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista#renderer#icons = {
      \  "function": "\uf794",
      \  "variable": "\uf71b",
      \ }
let g:vista_executive_for = { 'vim': 'ctags' }

" Startify
let s:header = [
      \ "",
      \ "",
      \ "                                       ,---._",
      \ "    ,---,.                           .-- -.' \\   ,----..",
      \ "  ,'  .'  \\                          |    |   : /   /   \\",
      \ ",---.' .' |               ,---,      :    ;   ||   :     :",
      \ "|   |  |: |           ,-+-. /  |     :    :   |.   |  ;. /",
      \ ":   :  :  /   ,---.  ,--.'|'   |     |    :   :.   ; /--`",
      \ ":   |    ;   /     \\|   |  ,\"' |     :    |    ;   | ;",
      \ "|   :     \\ /    /  |   | /  | |     |    ;   ||   : |",
      \ "|   |   . |.    ' / |   | |  | | ___ l    '    .   | '___",
      \ "'   :  '; |'   ;   /|   | |  |//    /\\    J   :'   ; : .'|",
      \ "|   |  | ; '   |  / |   | |--'/  ../  `..-    ,'   | '/  :",
      \ "|   :   /  |   :    |   |/    \\    \\         ; |   :    /",
      \ "|   | ,'    \\   \\  /'---'      \\    \\      ,'   \\   \\ .'",
      \ "`----'       `----'             \"---....--'      `---`",
      \ ""]
let s:footer = [
      \ "",
      \ "+----------------------------+",
      \ "|                            |",
      \ "|      NeoVim - BodneyC      |",
      \ "|                            |",
      \ "+----------------------------+",
      \ ""]
function! s:center(lines) abort
  let longest_line = max(map(copy(a:lines), 'len(v:val)'))
  let centered_lines = map(
        \   copy(a:lines),
        \   'repeat(" ", (winwidth(0) / 2) - (longest_line / 2)) . v:val'
        \ )
  return centered_lines
endfunction
function! s:set_startify_params() abort
  let g:startify_padding_left = (winwidth(0) / 4)
  let g:startify_custom_header = s:center(s:header)
  let g:startify_custom_footer = s:center(s:footer)
endfunction

autocmd VimEnter *
      \   if argc() == 0
      \ |   setlocal nobuflisted
      \ |   wincmd w
      \ |   call <SID>set_startify_params()
      \ |   Startify
      \ | endif
autocmd VimEnter *
      \   if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
      \ |   call <SID>set_startify_params()
      \ |   Startify
      \ | endif

let g:NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'

function! Flogdiff()
  let first_commit = flog#get_commit_data(line("'<")).short_commit_hash
  let last_commit = flog#get_commit_data(line("'>")).short_commit_hash
  call flog#git('vertical belowright', '!', 'diff ' . first_commit . ' ' . last_commit)
endfunction
augroup flog
  autocmd FileType floggraph vno gd :<C-U>call Flogdiff()<CR>
augroup END

let g:tagbar_iconchars = ["\u00a0", "\u00a0"]
let g:tagbar_compact = 1
let g:tagbar_type_kotlin = {
    \   'ctagstype' : 'kotlin',
    \   'sro'       : '.',
    \   'kinds'     : [
    \     'p:packages',
    \     'i:imports',
    \     'T:types:1',
    \     't:traits',
    \     'o:objects',
    \     'O:case objects',
    \     'c:classes',
    \     'C:case classes',
    \     'm:methods',
    \     'V:constants',
    \     'v:variables',
    \     'M:override_methods'
    \   ]
    \ }

let g:pear_tree_map_special_keys = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
