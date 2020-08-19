augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

let g:python_highlight_all = 1
let g:vimspectrItalicComment = 'on'

let g:onedark_termcolors = 256
set termguicolors

if g:term_theme == "dark"
  let s:lightline_theme = "bolorscheme"
  colo subdued
elseif g:term_theme == "light"
  let s:lightline_theme = "VimSpectre300light"
  colorscheme vimspectr300-light
endif

hi! SpelunkerSpellBad gui=undercurl
hi! OverLength guibg=#995959 guifg=#ffffff
hi! link JavaIdentifier NONE

" set fillchars=vert:\|
" hi! VertSplit guibg=NONE

hi! HoverMatch guibg=#382832

func! s:SetSignTheme(bg)
  exec 'hi SignColumn            guibg=' . a:bg
  exec 'hi GitGutterAdd          guibg=' . a:bg
  exec 'hi GitGutterChange       guibg=' . a:bg
  exec 'hi GitGutterChangeDelete guibg=' . a:bg
  exec 'hi GitGutterDelete       guibg=' . a:bg
  exec 'hi CocErrorSign          guibg=' . a:bg
  exec 'hi CocWarningSign        guibg=' . a:bg
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
  autocmd! TermOpen,TermEnter * hi Pmenu guibg=#151515
  autocmd! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guibg=#3e4452
endif

if g:colors_name == 'vimspectr150-light'
  let bg = '#d8ebe1'
  call s:SetSignTheme(bg)
  hi Pmenu guibg=bg
  autocmd! TermOpen,TermEnter * hi Pmenu guibg=bg
  autocmd! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guifg=#1f2e26 guibg=bg
endif

if g:colors_name == 'vimspectr180-light'
  let bg = '#d8ebeb'
  call s:SetSignTheme(bg)
  hi Pmenu guibg=bg
  exec 'autocmd! TermOpen,TermEnter * hi Pmenu guibg='.bg
  exec 'autocmd! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guifg=#1f2e26 guibg='.bg
endif

if g:colors_name == 'vimspectr300-light'
  let bg = '#f0ddf0'
  call s:SetSignTheme(bg)
  hi Pmenu guibg=bg
  exec 'autocmd! TermOpen,TermEnter * hi Pmenu guibg='.bg
  exec 'autocmd! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guifg=#1f2e26 guibg='.bg
endif
