" Color conf
let g:two_firewatch_italics=1
let g:vimspectrItalicComment = 'on'

" Colorscheme
let g:onedark_termcolors = 256
set termguicolors
colorscheme two-firewatch

" Lightline
set laststatus=2
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

let g:lightline = {
      \   'colorscheme': 'twofirewatch',
      \   'active': {
      \     'right': [ [ 'lineinfo' ],
      \                [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \     'left': [ [ 'filename' ],
      \               [ 'git', 'paste', 'cocstatus', 'readonly', 'Fugitive', 'modified' ] ]
      \   },
      \   'component' : {
      \            'WordCount' : 'wc: %{wordCount#WordCount()}',
      \     'Fugitive': '%{FugitiveStatusline()}',
      \   },
      \   'component_function': {
      \     'cocstatus': 'coc#status'
      \   }
      \ }
 
" hi SpellBad cterm=bold ctermfg=red
" hi SpellCap cterm=bold ctermfg=red
" hi SpellRare cterm=bold ctermfg=red
" hi SpellLocal cterm=bold ctermfg=red

hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

func! s:SetSignTheme(bg)
  exec 'hi SignColumn        guibg=' . a:bg
  exec 'hi SignifySignAdd    guibg=' . a:bg
  exec 'hi SignifySignChange guibg=' . a:bg
  exec 'hi SignifySignDelete guibg=' . a:bg
  exec 'hi CocErrorSign      guibg=' . a:bg
endfunc

if g:colors_name == 'two-firewatch'
  call s:SetSignTheme('#45505d')
  hi MatchParenCur guibg=#777777 guifg=#ffbfe4
  hi MatchParen    guibg=#777777 guifg=#551144
  autocmd! TermOpen,TermEnter * hi Pmenu guibg=#151515
  autocmd! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guibg=#3e4452
endif

if g:colors_name == 'vimspectr150-light'
  call s:SetSignTheme('#d8ebe1')
  hi Pmenu guibg=#d8ebe1
  autocmd! TermOpen,TermEnter * hi Pmenu guibg=#d8ebe1
  autocmd! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guifg=#1f2e26 guibg=#d8ebe1
endif

if g:colors_name == 'vimspectr180-light'
  call s:SetSignTheme('#d8ebeb')
  hi Pmenu guibg=#d8ebeb
  autocmd! TermOpen,TermEnter * hi Pmenu guibg=#d8ebeb
  autocmd! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guifg=#1f2e26 guibg=#d8ebeb
endif

hi link GitGutterAdd          SignifySignAdd
hi link GitGutterChange       SignifySignChange
hi link GitGutterChangeDelete SignifySignChange
hi link GitGutterDelete       SignifySignDelete
