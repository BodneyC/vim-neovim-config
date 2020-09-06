let g:python_highlight_all = 1
let g:vimspectrItalicComment = 'on'
let g:onedark_termcolors = 256

set termguicolors

if g:term_theme == "light"
  colo solarized-light
else
  colo subdued
endif

func! s:additional_highlights()
  hi! SpelunkerSpellBad gui=undercurl
  hi! OverLength guibg=#995959 guifg=#ffffff
  hi! link JavaIdentifier NONE
  hi! HoverMatch guibg=#382832
  if g:term_theme == "light"
    hi! Visual guifg=bg
    hi! VertSplit guibg=NONE
    set fillchars=vert:\|
  endif
endfunc
call <SID>additional_highlights()

augroup __HIGHLIGHT__
  au!
  au TextYankPost * silent! lua require'vim.highlight'.on_yank()
  au ColorScheme  * call <SID>additional_highlights()
augroup end

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
