let g:python_highlight_all = 1
let g:vimspectrItalicComment = 'on'

let g:onedark_termcolors = 256
set termguicolors
set background=dark

if g:term_theme == "dark"
  let s:lightline_theme = "bolorscheme"
  colo subdued
  hi OverLength guibg=#995959 guifg=#ffffff
elseif g:term_theme == "light"
  let s:lightline_theme = "VimSpectre300light"
  colorscheme vimspectr300-light
endif

function! SlLightlineFn()
  return (&modified ? ' ' : ' ') . ' ' . (expand('%:t') !=# '' ? expand('%:t') : '[No Name]')
endfunction

function! SlStatusDiagnostic() abort
  if ! IsCocEnabled()
    return ''
  endif
  let l:status = substitute(get(g:, 'coc_status', ''), '^\s*\(.\{-}\)\s*$', '\1', '')
  if ! len(l:status) && IsCocEnabled()
    let l:status = substitute(&ft, '.*', '\u&', '')
  endif
  let l:status = '  ' . l:status
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

function! SlCurrentFunction()
  return get(b:, 'coc_current_function', 'NONE')
endfunction

function! SlVirkLine()
  if ! exists('*virkspaces#status') | return '' | endif
  let l:status = virkspaces#status()
  if ! len(l:status) | return '' | endif
  if l:status =~# '.*(moved)$'
    return '· ·'
  endif
  return '· ·'
endfunction

function! SlFileInfo()
  let l:ff = { 'unix': '', 'mac':  '', 'dos':  '', }
  return l:ff[&ff] . ' ' . &ft . (&ro ? ' ' : '')
endfunction
 
let g:limelight_conceal_guifg = '#777777'
let g:lightline = {
      \   'colorscheme': s:lightline_theme,
      \   'active': {
      \     'left':  [ [ 'fn' ],
      \                [ 'paste', 'cocStatus', 'fugitive' ] ],
      \     'right': [ [ 'lineinfo' ],
      \                [ 'currentFunction', 'fileInfo', 'virkspaces' ] ],
      \   },
      \   'component': {
      \     'fugitive': ' %{fugitive#Head(7)}',
      \   },
      \   'component_function': {
      \     'fileInfo': 'SlFileInfo',
      \     'cocStatus': 'SlStatusDiagnostic',
      \     'currentFunction': 'SlCocCurrentFunction',
      \     'fn': 'SlLightlineFn',
      \     'virkspaces': 'SlVirkLine',
      \   },
      \   'separator': {
      \     'left': '',
      \     'right': ''
      \   },
      \   'subseparator': {
      \     'right': '',
      \     'left': '',
      \   }
      \ }

hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

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
