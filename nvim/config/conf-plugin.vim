let g:vsnip_snippet_dir = expand('$HOME/.config/nvim/vsnip')

let g:vimade = {
      \ 'fadelevel': 0.6,
      \ 'enablesigns': 0
      \ }

let g:twiggy_local_branch_sort = 'mru'
let g:twiggy_remote_branch_sort = 'date'

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 14

let g:conjure#mapping#prefix = '\'

let g:fff#split = "call FloatingCentred(0.4, 0.4)"
let g:fff#split_direction = "nosb sbr"

let g:Hexokinase_virtualText = " "
let g:Hexokinase_highlighters = ['virtual']
let g:Hexokinase_optInPatterns = [
      \ 'full_hex',
      \ 'triple_hex',
      \ 'rgb',
      \ 'rgba',
      \ 'hsl',
      \ 'hsla',
      \ ]

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
let g:virk_close_regexes = ["^$", "FAR.*", "MERGE MSG", "git-.*", "COMMIT.*", ".*Plugins.*", "^.defx].*"]

let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_enabled = 1
let g:indentLine_char = '·'
let g:indentLine_first_char = '·'
let g:indentLine_fileTypeExclude = [ "markdown", "nerdtree", "defx", "twiggy" ]

let g:NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'

let g:mundo_right = 1
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
let g:gutentags_ctags_exclude = ['*.json']
let g:gutentags_ctags_extra_args = [
      \   '--tag-relative=always',
      \   '--fields=+ailmnS',
      \ ]

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
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

func! s:center(lines) abort
  let longest_line = max(map(copy(a:lines), 'len(v:val)'))
  let centered_lines = map(
        \   copy(a:lines),
        \   'repeat(" ", (winwidth(0) / 2) - (longest_line / 2)) . v:val'
        \ )
  return centered_lines
endfunc

func! s:set_startify_params() abort
  let g:startify_padding_left = winwidth(0) / 4
  let g:startify_custom_header = s:center(s:header)
  let g:startify_custom_footer = s:center(s:footer)
endfunc

" Needs to remain here for startify stuff
au! VimEnter *
      \   if argc() == 0 || (argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in"))
      \ |   call <SID>set_startify_params()
      \ |   Startify
      \ | endif

" func! Flogdiff()
"   let first_commit = flog#get_commit_data(line("'<")).short_commit_hash
"   let last_commit = flog#get_commit_data(line("'>")).short_commit_hash
"   call flog#git('vertical belowright', '!', 'diff ' . first_commit . ' ' . last_commit)
" endfunc

" augroup __PLUGINS__
"   au!
"   au FileType floggraph vno gd :<C-U>call Flogdiff()<CR>
" augroup END

let g:tagbar_iconchars = ["\u00a0", "\u00a0"]
let g:tagbar_compact = 1
