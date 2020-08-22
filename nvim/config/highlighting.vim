let g:python_highlight_all = 1
let g:vimspectrItalicComment = 'on'
let g:onedark_termcolors = 256

set termguicolors

if g:term_theme == "dark"
  let s:lightline_theme = "bolorscheme"
  colo subdued
elseif g:term_theme == "light"
  let s:lightline_theme = "VimSpectre300light"
  colo vimspectr300-light
endif

func! s:additional_highlights()
  hi! SpelunkerSpellBad gui=undercurl
  hi! OverLength guibg=#995959 guifg=#ffffff
  hi! link JavaIdentifier NONE
  hi! HoverMatch guibg=#382832
  " hi! VertSplit guibg=NONE
  " set fillchars=vert:\|
endfunc
call <SID>additional_highlights()

augroup __HIGHLIGHT__
  au!
  au TextYankPost * silent! lua require'vim.highlight'.on_yank()
  au ColorScheme  * call <SID>additional_highlights()
augroup end

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

if g:colors_name == 'two-firewatch'
  let g:two_firewatch_italics = 1
  call s:SetSignTheme('#45505d')
  hi MatchParenCur guibg=#3a3333 guifg=#ffbfe4
  hi MatchParen    guibg=#595555 guifg=#c7c8e6
  hi CocHighlightWrite guibg=#3a3333 guifg=#d8b8df
  au! TermOpen,TermEnter * hi Pmenu guibg=#151515
  au! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guibg=#3e4452
endif

if g:colors_name == 'vimspectr150-light'
  let bg = '#d8ebe1'
  call s:SetSignTheme(bg)
  hi Pmenu guibg=bg
  au! TermOpen,TermEnter * hi Pmenu guibg=bg
  au! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guifg=#1f2e26 guibg=bg
endif

if g:colors_name == 'vimspectr180-light'
  let bg = '#d8ebeb'
  call s:SetSignTheme(bg)
  hi Pmenu guibg=bg
  exe 'au! TermOpen,TermEnter * hi Pmenu guibg='.bg
  exe 'au! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guifg=#1f2e26 guibg=' . bg
endif

if g:colors_name == 'vimspectr300-light'
  let bg = '#f0ddf0'
  call s:SetSignTheme(bg)
  hi Pmenu guibg=bg
  exe 'au! TermOpen,TermEnter * hi Pmenu guibg='.bg
  exe 'au! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guifg=#1f2e26 guibg=' . bg
endif
