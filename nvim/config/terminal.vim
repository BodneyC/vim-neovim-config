function! s:close_if_terminal_job()
  if exists('b:terminal_job_pid')
    try
      close
    catch /E444.*/
      echom "Could not close terminal"
    endtry
  endif
endfunction

function! <SID>ctrl_q()
  let l:term_name = "term://" . s:term_name
  let winnr = bufwinnr(l:term_name)
  if winnr != -1
    exec winnr . "wincmd w"
  else
    call TermSplit()
  endif
endfunction

function! TermSplit(bang)
  let l:term_name = "term://" . s:term_name
  let winnr = bufwinnr(l:term_name)
  if winnr != -1
    exec winnr . "wincmd q"
  else
    let bufnr = bufnr(l:term_name)
    if bufnr != -1
      exec "bd!" . bufnr
    endif
    if(a:bang)
      vsplit
    else
      10 wincmd j
      split
    endif
    setlocal hidden
    if(a:bang)
      wincmd J
    endif
    terminal
    resize 10
    exec "f " . l:term_name
    autocmd! TermClose <buffer> call <SID>close_if_terminal_job()
    startinsert
  endif
endfunction
command! -bang TermSplit call TermSplit(<bang>0)

let s:term_name = "term-split"

nnoremap <silent> <F10> :TermSplit!<CR>
inoremap <silent> <F10> <C-o>:TermSplit!<CR>
tnoremap <silent> <F10> <C-\><C-n>:TermSplit!<CR>

nnoremap <silent> <C-q> :TermSplit<CR>
tnoremap <silent> <C-q> <C-\><C-n>:wincmd w<CR>
tnoremap <silent> <LeftRelease> <Nop>

augroup vimrc_feature_terminal
  autocmd!
  autocmd TermOpen,TermEnter,BufNew,BufEnter term://* startinsert
  autocmd TermOpen,TermEnter * setlocal nospell signcolumn=no nobuflisted nonu nornu tw=0 wh=1
augroup END

let s:terminal_divisor = 0.9
function! FloatingCentred(...)
  let height_divisor = get(a:, 1, s:terminal_divisor)
  let width_divisor = get(a:, 2, s:terminal_divisor)

  let height = float2nr(&lines * height_divisor)
  let width = float2nr(&columns * width_divisor)
  let col = float2nr((&columns - width) / 2)
  let row = float2nr((&lines - height) / 2)

  let opts = {
        \   'relative': 'editor',
        \   'row': row,
        \   'col': col,
        \   'width': width,
        \   'height': height,
        \   'style': 'minimal'
        \ }

  let s:cur_float_win = nvim_create_buf(v:false, v:true)
  call nvim_open_win(s:cur_float_win, v:true, opts)

  setlocal winhl=Normal:NormalFloat
endfunction

function! s:on_term_exit(job_id, code, event) dict
  if a:code == 0 | bd! | endif
endfunction

function! FloatingTerm(...)
  let l:cmd = get(a:, 1, $SHELL)
  call FloatingCentred()
  call termopen(l:cmd, { 'on_exit': function('<SID>on_term_exit') })
endfunction

function! FloatingMan(...)
  call FloatingTerm('man ' .join(a:000, ' '))
endfunction
command! -nargs=+ -complete=shellcmd M call FloatingMan(<f-args>)

let s:cur_float_win = -1
function! FloatingHelp(...)
  if bufexists(s:cur_float_win)
    exec 'bw ' . s:cur_float_win
    let s:cur_float_win = -1
  endif
  let l:not_in_tags = 0
  let l:query = get(a:, 1, '')
  call FloatingCentred()
  setlocal ft=help bt=help
  try
    exec 'help ' . l:query
  catch E149
    let l:not_in_tags = 1
  endtry
  map <buffer> <Esc> :q<CR>
  if l:not_in_tags == 1
    bw
    echoe '"' . l:query . '" not in helptags'
  endif
endfunction
command! -nargs=? -complete=help H call FloatingHelp(<f-args>)
command! -nargs=? -complete=help Help call FloatingHelp(<f-args>)
