" hi clear SpellBad
" hi SpellBad cterm=bold ctermfg=red
" hi SpellCap cterm=bold ctermfg=red
" hi SpellRare cterm=bold ctermfg=red
" hi SpellLocal cterm=bold ctermfg=red

hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

if g:colors_name == 'two-firewatch'
  hi SignColumn           guibg=#45505d
  hi SignifySignAdd       guibg=#45505d guifg=#43d08a
  hi SignifySignChange    guibg=#45505d guifg=#e0c285
  hi SignifySignDelete    guibg=#45505d guifg=#e05252
  hi CocErrorSign         guibg=#45505d guifg=#ff8888

  hi link GitGutterAdd    SignifySignAdd
  hi link GitGutterChange SignifySignChange
  hi link GitGutterChangeDelete SignifySignChange
  hi link GitGutterDelete SignifySignDelete

  hi MatchParenCur guibg=#777777 guifg=#ffbfe4
  hi MatchParen guibg=#777777 guifg=#551144
endif

" hi StatusLine ctermfg=blue
" hi TabLineSel ctermfg=blue
" hi TabLine ctermfg=blue
" hi PmenuSel ctermfg=blue

" hi Normal guibg=NONE ctermbg=NONE
" hi NonText guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE ctermfg=red
" hi StatusLine guibg=NONE ctermbg=NONE
" hi StatusLineTerm guibg=NONE ctermbg=NONE
" hi VertSplit guibg=NONE ctermbg=NONE

" hi TabLine guibg=NONE ctermbg=NONE
" hi TabLineFill guibg=NONE ctermbg=NONE

" hi Pmenu guibg=NONE ctermbg=NONE
" hi PmenuSel guibg=NONE ctermbg=NONE
" hi PmenuSbar guibg=NONE ctermbg=NONE
" hi PmenuThumb guibg=NONE ctermbg=NONE

" hi SignColumn guibg='#55606d'
" hi CursorLineNr guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE
" hi Search ctermbg=white ctermfg=black
" hi GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
" hi GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
" hi GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
" hi GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE

" let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
" let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
" let g:lightline.component_type   = {'buffers': 'tabsel'}
" let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette

" let s:palette.normal.middle   = [ [ 'NONE', 'NONE', 'NONE', '235' ] ]
" let s:palette.normal.left     = [ [ 'black', '#98c379', 'black', 'green' ] ]
" let s:palette.normal.right    = s:palette.normal.left

" let s:palette.inactive.middle = [ [ 'NONE', 'NONE', 'NONE', '235' ] ]
" let s:palette.inactive.left   = s:palette.inactive.middle
" let s:palette.inactive.right  = s:palette.inactive.middle

" let s:palette.insert.left     = [ [ 'black', '#61afef', 'black', 'blue' ] ]
" let s:palette.insert.right    = s:palette.insert.left

" let s:palette.visual.left     = [ [ 'black', '#c678dd', 'black', '140' ] ]
" let s:palette.visual.right    = s:palette.visual.left

" let s:palette.replace.middle  = [ [ 'NONE', 'NONE', 'NONE', '235' ] ]
" let s:palette.replace.left    = [ [ 'black', '#98c379', 'black', 'red' ] ]
" let s:palette.replace.right   = s:palette.replace.left
