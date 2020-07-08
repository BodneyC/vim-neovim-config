let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-h>      :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j>      :TmuxNavigateDown<CR>
nnoremap <silent> <M-k>      :TmuxNavigateUp<CR>
nnoremap <silent> <M-l>      :TmuxNavigateRight<CR>
nnoremap <silent> <M-\>      :TmuxNavigatePrevious<CR>
inoremap <silent> <M-h> <C-o>:TmuxNavigateLeft<CR>
inoremap <silent> <M-j> <C-o>:TmuxNavigateDown<CR>
inoremap <silent> <M-k> <C-o>:TmuxNavigateUp<CR>
inoremap <silent> <M-l> <C-o>:TmuxNavigateRight<CR>
inoremap <silent> <M-\> <C-o>:TmuxNavigatePrevious<CR>

let g:test#java#maventest#file_pattern = '\v([Tt]est.*|.*[Tt]est(s|Case)?)\.(java|kt)$'

let g:matchup_matchparen_offscreen = { 'method': 'popup' }

let g:togool_extras =
      \ [['<', '+'],
      \  ['>', '-']]

let g:virk_tags_enable = 0
let g:virk_close_regexes = ["^$", "FAR.*", "MERGE MSG", "git-.*", "COMMIT.*", ".*Plugins.*"]

let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_enabled = 1
let g:indentLine_char = '·'
let g:indentLine_first_char = '·'
let g:indentLine_fileTypeExclude = [ "markdown" ]

let g:mundo_right = 1

if exists('*comfortable_motion#flick')
  let g:comfortable_motion_no_default_key_mappings=1
  let g:comfortable_motion_air_drag = 1
  let g:comfortable_motion_friction = 100
  nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
  nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
endif

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
  let g:startify_padding_left = winwidth(0) / 4
  let g:startify_custom_header = s:center(s:header)
  let g:startify_custom_footer = s:center(s:footer)
endfunction

" Needs to remain here for startify stuff
autocmd! VimEnter *
      \   if argc() == 0 || (argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in"))
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

let g:pear_tree_map_special_keys = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
