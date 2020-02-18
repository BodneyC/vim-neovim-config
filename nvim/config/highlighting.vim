"*Color conf
let g:two_firewatch_italics=1
let g:vimspectrItalicComment = 'on'

" Colorscheme
let g:onedark_termcolors = 256
set termguicolors
set background=dark

if g:term_theme == "dark"
	" let s:lightline_theme = "twofirewatch"
	" colorscheme two-firewatch
	let s:lightline_theme = "1989"
  colo 1989
  hi OverLength guibg=#995959 guifg=#ffffff
elseif g:term_theme == "light"
	let s:lightline_theme = "VimSpectre300light"
	colorscheme vimspectr300-light
endif

" Lightline
function! LightlineFn()
  return (&modified ? '  ' : '') . (expand('%:t') !=# '' ? expand('%:t') : '[No Name]')
endfunction

function! StatusDiagnostic() abort
  let l:status = substitute(get(g:, 'coc_status', ''), '^\s*\(.\{-}\)\s*$', '\1', '')
  if ! len(l:status) && IsCocEnabled()
    let l:status = '  ' . substitute(&ft, '.*', '\u&', '')
  endif
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return l:status | endif
  let l:msgs = []
  if get(l:info, 'error', 0)
    let l:status .= '  ' . l:info['error']
  endif
  if get(l:info, 'warning', 0)
    let l:status .= '  ' . l:info['warning']
  endif
  return l:status
endfunction
 
function! CurrentFunction()
  return get(b:, 'coc_current_function', 'NONE')
endfunction

function! FileInfo()
  let l:ff = {
        \ 'unix': ' ',
        \ 'mac':  ' ',
        \ 'dos':  ' ',
        \ }
  let l:ro = ''
  return l:ff[&ff] . &ft . ' ' . (&ro ? '  ' : '')
endfunction
 
set laststatus=2
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
 

let g:lightline = {
      \   'colorscheme': s:lightline_theme,
      \   'active': {
      \     'left':  [ [ 'fn' ],
      \                [ 'paste', 'cocStatus', 'Fugitive' ] ],
      \     'right': [ [ 'lineinfo' ],
      \                [ 'currentFunction', 'fileInfo' ] ],
      \   },
      \   'component': {
      \     'Fugitive': ' %{fugitive#Head(7)}',
      \   },
      \   'component_function': {
      \     'fileInfo': 'FileInfo',
      \     'cocStatus': 'StatusDiagnostic',
      \     'currentFunction': 'CocCurrentFunction',
      \     'fn': 'LightlineFn',
      \   },
      \   'subseparator': {
      \     'right': '',
      \     'left': '',
      \   }
      \ }

let lightline#colorscheme#background = 'light'

" hi SpellBad cterm=bold ctermfg=red
" hi SpellCap cterm=bold ctermfg=red
" hi SpellRare cterm=bold ctermfg=red
" hi SpellLocal cterm=bold ctermfg=red

hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

func! s:SetSignTheme(bg)
  exec 'hi SignColumn            guibg=' . a:bg
  exec 'hi GitGutterAdd          guibg=' . a:bg
  exec 'hi GitGutterChange       guibg=' . a:bg
  exec 'hi GitGutterChangeDelete guibg=' . a:bg
  exec 'hi GitGutterDelete       guibg=' . a:bg
  exec 'hi CocErrorSign          guibg=' . a:bg
  exec 'hi CocWarningSign        guibg=' . a:bg

  hi clear CocGitAddedSign CocGitChangedSign CocGitChangeRemovedSign CocGitRemovedSign
  hi link CocGitAddedSign GitGutterAdd
  hi link CocGitChangedSign GitGutterChange
  hi link CocGitChangeRemovedSign GitGutterChangeDelete
  hi link CocGitRemovedSign GitGutterDelete
endfunc

if g:colors_name == 'two-firewatch'
  call s:SetSignTheme('#45505d')
  hi MatchParenCur guibg=#3a3333 guifg=#ffbfe4
  hi MatchParen    guibg=#595555 guifg=#c7c8e6
  hi CocHighlightWrite guibg=#3a3333 guifg=#d8b8df
  autocmd! TermOpen,TermEnter * hi Pmenu guibg=#151515
  autocmd! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guibg=#3e4452
endif

if g:colors_name == '1989'
  let bg = '#303030'
  call s:SetSignTheme(bg)
  hi! Pmenu guibg='#657075'
  exec 'hi PmenuSel guibg=#ffffff guifg='.bg
  hi clear CursorLine CocHighlightText
  hi CursorLine guibg='#272727'
  hi CocHighlightText guibg='#111121'
  " exec 'autocmd! TermOpen,TermEnter * hi Pmenu guibg='.bg
  " exec 'autocmd! TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guifg=#1f2e26 guibg='.bg
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
