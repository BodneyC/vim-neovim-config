function! ChooseTerm(termname)
  let winnr = bufwinnr(a:termname)
  if winnr != -1
    exec winnr . "wincmd q"
  else
    let bufnr = bufnr(a:termname)
    if bufnr != -1
      exec "bd!" . bufnr
    endif
    vs
    setlocal hidden
    exec "wincmd J"
    terminal
    resize 10
    exec "f " a:termname
    startinsert
  endif
endfunction

nnoremap <F10> :call ChooseTerm("term-split")<CR>
inoremap <F10> <esc>:call ChooseTerm("term-split")<CR>a

tnoremap <C-q> <C-\><C-n>
tnoremap <LeftRelease> <Nop>

augroup vimrc_feature_terminal
  autocmd!
  autocmd TermOpen,TermEnter * setlocal nospell signcolumn=no nobuflisted nonu nornu tw=0 wh=1
  autocmd BufEnter,BufWinEnter,WinEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END
