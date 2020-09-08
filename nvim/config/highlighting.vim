let g:python_highlight_all = 1
let g:vimspectrItalicComment = 'on'
let g:onedark_termcolors = 256

set termguicolors

if g:term_theme == "light"
  colo plint-light
else
  colo subdued
endif

func! s:additional_highlights()
  hi! link HoverMatch MatchParen
  hi! SpelunkerSpellBad gui=undercurl
  hi! OverLength guibg=#995959 guifg=#ffffff
  hi! link JavaIdentifier NONE
  if g:term_theme == "light"
    hi! Visual guifg=bg
    hi! VertSplit guibg=NONE
    set fillchars=vert:\|
  endif
endfunc
call <SID>additional_highlights()

function! s:hover_match()
  let w = expand('<cword>')
  if (w =~ '^[#_a-zA-Z0-9]\+$')
    exe '2match HoverMatch "\([^a-zA-z]\|^\)\zs' . w . '\ze\([^a-zA-z]\|$\)"'
  else
    2match none
  endif
endfunction

augroup __HIGHLIGHT__
  au!
  au TextYankPost * silent! lua require'vim.highlight'.on_yank()
  au ColorScheme  * call <SID>additional_highlights()
  au CursorHold   * silent call <SID>hover_match()
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
