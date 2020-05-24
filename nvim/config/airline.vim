if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_theme = 'bolorscheme'

let g:airline_powerline_fonts    = 1
let g:airline_symbols.crypt      = '🔒'
let g:airline_symbols.paste      = 'Þ'
let g:airline_symbols.paste      = '∥'
let g:airline_symbols.spell      = 'Ꞩ'
let g:airline_symbols.notexists  = ' Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_left_sep           = ''
let g:airline_left_alt_sep       = ''
let g:airline_right_sep          = ''
let g:airline_right_alt_sep      = ''
let g:airline_symbols.branch     = ''
let g:airline_symbols.readonly   = ''
let g:airline_symbols.linenr     = '☰'
let g:airline_symbols.maxlinenr  = ''
let g:airline_symbols.dirty=     ' ⚡'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_min_count = 2

let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = ' '
let g:airline#extensions#coc#warning_symbol = ' '

let g:airline#extensions#vista#enabled = 0

function! AlFileInfo()
  let l:ff = { 'unix': '', 'mac':  '', 'dos':  '' }
  return l:ff[&ff] . ' ' . &ft
endfunction

function! AlMode()
  return airline#util#shorten(get(w:, 'airline_current_mode', ''), 79, 1)[0:3]
endfunction

function! AlModified()
  return &modified ? ' ' : ''
endfunction

call airline#parts#define_function('FileInfo', 'AlFileInfo')
call airline#parts#define_function('Mode', 'AlMode')
call airline#parts#define_function('Modified', 'AlModified')
call airline#parts#define_raw('Fn', '%f')
call airline#parts#define_raw('Position', '%l:%v')
call airline#parts#define_raw('MaxLineNr', '%L')

function! AirlineInit() abort
  let spc = g:airline_symbols.space
  let g:airline_section_a = airline#section#create([
        \ 'Mode', 'crypt', 'paste', 'keymap', 'spell', 'capslock', 'xkblayout', 'iminsert'])
  let g:airline_section_c = airline#section#create([
        \ '%<', 'Fn', 'Modified', spc, 'readonly', 'coc_status'])
  let g:airline_section_x = airline#section#create_right([
        \ 'bookmark', 'vista', 'gutentags', 'grepper', 'tagbar'])
  let g:airline_section_y = airline#section#create(['FileInfo'])
  if airline#util#winwidth() > 79
    let g:airline_section_z = airline#section#create([
          \ 'windowswap', 'obsession', '%p%%'.spc, 'Position'])
  else
    let g:airline_section_z = airline#section#create([
          \ '%p%%'.spc, 'LineNr',  ':%v'])
  endif
endfunction

augroup __AIRLINE__
  autocmd!
  autocmd VimEnter * call AirlineInit()
augroup end
