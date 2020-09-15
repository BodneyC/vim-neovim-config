let g:python_highlight_all = 1
let g:vimspectrItalicComment = 'on'
let g:onedark_termcolors = 256

set termguicolors

if $TERMTHEME == "light"
  colo plint-light
else
  colo unicorn
endif

func! s:additional_highlights()
  hi! link HoverMatch MatchParen
  hi! SpelunkerSpellBad gui=undercurl
  hi! OverLength guibg=#995959 guifg=#ffffff
  hi! link JavaIdentifier NONE
  hi! link CleverFChar ErrorMsg
  hi! link CleverFCursor ErrorMsg
  if $TERMTHEME == "light"
    hi! Visual guifg=bg
    hi! VertSplit guibg=NONE
  endif
endfunc
call <SID>additional_highlights()

let s:hover_match_id = -1
func! s:hover_match()
  for match in getmatches()
    if get(match, 'id', '-1') == s:hover_match_id
      call matchdelete(s:hover_match_id)
    end
  endfor
  let w = expand('<cword>')
  if (w =~ '^[0-9]*[#_a-zA-Z][#_a-zA-Z0-9]*$')
    let s:hover_match_id = matchadd(
          \ 'HoverMatch', '\([^a-zA-z]\|^\)\zs' . w . '\ze\([^a-zA-z]\|$\)')
  endif
endfunc

augroup __HIGHLIGHT__
  au!
  au TextYankPost * silent! lua require'vim.highlight'.on_yank()
  au ColorScheme  * call <SID>additional_highlights()
  au CursorHold   * silent call <SID>hover_match()
augroup END

command! -nargs=0 HiTest so $VIMRUNTIME/syntax/hitest.vim

func! s:SetSignTheme(bg)
  exe 'hi SignColumn            guibg=' . a:bg
  exe 'hi GitGutterAdd          guibg=' . a:bg
  exe 'hi GitGutterChange       guibg=' . a:bg
  exe 'hi GitGutterChangeDelete guibg=' . a:bg
  exe 'hi GitGutterDelete       guibg=' . a:bg
  exe 'hi CocErrorSign          guibg=' . a:bg
  exe 'hi CocWarningSign        guibg=' . a:bg
  hi! clear CocGitAddedSign CocGitChangedSign CocGitChangeRemovedSign CocGitRemovedSign
  hi link CocGitAddedSign GitGutterAdd
  hi link CocGitChangedSign GitGutterChange
  hi link CocGitChangeRemovedSign GitGutterChangeDelete
  hi link CocGitRemovedSign GitGutterDelete
endfunc
