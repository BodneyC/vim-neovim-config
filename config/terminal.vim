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
