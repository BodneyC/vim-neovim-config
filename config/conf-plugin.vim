" Plugin variable settings
  let g:SuperTabDefaultCompletionType = "<c-n>"
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_char = '·'
  let g:indentLine_first_char = '·'
  let g:yats_host_keyword = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:WebDevIconsUnicodeDecorateFolderNodeDefaultSymbol = ''
  let g:mundo_right = 1
  let g:comfortable_motion_air_drag = 1
  let g:comfortable_motion_friction = 100
  let g:indentLine_enabled = 0
  let g:tagbar_auto_close = 1
  let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
  let g:pandoc#filetypes#pandoc_markdown = 0
  let g:pandoc#command#latex_engine = "pdflatex"
  let g:tex_conceal = ""
  let g:tex_flavor = 'latex'
  let g:vimtex_indent_enabled = 0
  let g:vimtex_toc_width = 25
  let g:vimtex_view_general_viewer = 'firefox'
  let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'
  let g:vimtex_view_general_options_latexmk = '--unique'

" Vista
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
  let g:vista_default_executive = 'coc'
  let g:vista#renderer#icons = {
        \  "function": "\uf794",
        \  "variable": "\uf71b",
        \ }
  let g:vista_executive_for = {
        \   'vim': 'ctags'
        \ }

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
    let centered_lines = map(copy(a:lines), 'repeat(" ", (winwidth(0) / 2) - (longest_line / 2)) . v:val')
    return centered_lines
  endfunction
  function! SetStartifyParams() abort
    let g:startify_padding_left = (winwidth(0) / 4)
    let g:startify_custom_header = s:center(s:header)
    let g:startify_custom_footer = s:center(s:footer)
  endfunction
  function! s:openNerdTreeIfNotAlreadyOpen()
    if ! (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
      echom 100921
      exe 'NERDTree' argv()[0]
      setlocal nobuflisted
      wincmd w
    endif
  endfunction

  autocmd VimEnter *
        \   if argc() == 0
        \ |   exe 'NERDTree'
        \ |   setlocal nobuflisted
        \ |   wincmd w
        \ |   call SetStartifyParams()
        \ |   Startify
        \ | endif 
  autocmd VimEnter *
        \   if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
        \ |   call s:openNerdTreeIfNotAlreadyOpen()
        \ |   call SetStartifyParams()
        \ |   Startify
        \ | endif

" NERDCommenter
  let g:NERDSpaceDelims=1
  let g:NERDDefaultAlign = 'left'

" NERDTree
  let NERDTreeWinSize=25
  let NERDTreeMinimalUI=1
  let NERDTreeDirArrows=1
  let NERDTreeShowBookmarks=0
  let NERDTreeShowHidden=1    
  let NERDTreeDirArrowExpandable = "\u00a0"
  let NERDTreeDirArrowCollapsible = "\u00a0"

" Ranger
  let g:loaded_netrwPlugin = 1
  let g:ranger_replace_netrw = 0
  let g:ranger_map_keys = 0

" Tagbar
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
