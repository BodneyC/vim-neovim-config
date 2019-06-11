" Plugin variable settings
  let g:SuperTabDefaultCompletionType = "<c-n>"
  let g:indentLine_showFirstIndentLevel = 1
  let g:yats_host_keyword = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:WebDevIconsUnicodeDecorateFolderNodeDefaultSymbol = ''
  let g:mundo_right = 1
  let g:comfortable_motion_air_drag = 1
  let g:comfortable_motion_friction = 100
" Vista
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
  let g:vista_default_executive = 'coc'
  let g:vista#renderer#icons = {
  \  "function": "\uf794",
  \  "variable": "\uf71b",
  \ }
" Startify
  let g:startify_padding_left = (&columns / 2) - (line('$') / 2)
  let s:header = [
        \ "",
        \ "                                       ,---._               ",
        \ "    ,---,.                           .-- -.' \\   ,----..    ",
        \ "  ,'  .'  \\                          |    |   : /   /   \\   ",
        \ ",---.' .' |               ,---,      :    ;   ||   :     :  ",
        \ "|   |  |: |           ,-+-. /  |     :    :   |.   |  ;. /  ",
        \ ":   :  :  /   ,---.  ,--.'|'   |     |    :   :.   ; /--`   ",
        \ ":   |    ;   /     \\|   |  ,\"' |     :    |    ;   | ;      ",
        \ "|   :     \\ /    /  |   | /  | |     |    ;   ||   : |      ",
        \ "|   |   . |.    ' / |   | |  | | ___ l    '    .   | '___   ",
        \ "'   :  '; |'   ;   /|   | |  |//    /\\    J   :'   ; : .'|  ",
        \ "|   |  | ; '   |  / |   | |--'/  ../  `..-    ,'   | '/  :  ",
        \ "|   :   /  |   :    |   |/    \\    \\         ; |   :    /   ",
        \ "|   | ,'    \\   \\  /'---'      \\    \\      ,'   \\   \\ .'    ",
        \ "`----'       `----'             \"---....--'      `---`      ",
        \ ""]
  let s:footer = [
        \ "",
        \ "               +----------------------------+",
        \ "               |                            |",
        \ "               |      NeoVim - BodneyC      |",
        \ "               |                            |",
        \ "               +----------------------------+",
        \ ""]
  function! s:center(lines) abort
    let centered_lines = map(copy(a:lines), 'repeat(" ", (&columns / 2) - (line("$") / 2)) . v:val')
    return centered_lines
  endfunction
  let g:startify_custom_header = s:center(s:header)
  let g:startify_custom_footer = s:center(s:footer)
  
  set completefunc=emoji#complete
