function! ChooseTerm(termname, slider)
  let pane = bufwinnr(a:termname)
  let buf = bufexists(a:termname)
  if pane > 0
    if a:slider > 0
      :exe pane . "wincmd c"
    else
      :exe "e #"
    endif
  elseif buf > 0
    if a:slider
      :exe "topleft split"
    endif
    :exe "buffer " . a:termname
  else
    if a:slider
      :exe "belowright split"
    endif
    :terminal
    :resize 10
    :exe "f " a:termname
    :startinsert
  endif
endfunction

nnoremap <F10> :call ChooseTerm("term-split", 1)<CR>
inoremap <F10> <esc>:call ChooseTerm("term-split", 1)<CR>a

tnoremap <C-q> <C-\><C-n>
tnoremap <LeftRelease> <Nop>

augroup vimrc_feature_terminal
  autocmd!
  autocmd TermOpen,TermEnter * setlocal nospell nobuflisted nonu nornu tw=0 wh=1 | hi Pmenu guibg=#151515
  autocmd TermClose,TermLeave * hi Pmenu ctermfg=0 ctermbg=17 guibg=#3e4452
  autocmd BufEnter,BufWinEnter,WinEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END
