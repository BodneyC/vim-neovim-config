let g:loaded_netrwPlugin = 1
nnoremap <silent> gx :call netrw#BrowseX(expand('<cfile>'),netrw#CheckIfRemote())<CR>
vnoremap <silent> gx :<C-u>call netrw#BrowseXVis()<CR>
let g:ranger_replace_netrw = 0
let g:ranger_map_keys = 0
nnoremap <silent> <Leader>R :Ranger<CR>
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

augroup vimrc-feature-directory
  autocmd!
  "autocmd BufEnter,BufWinEnter,WinEnter * if &buftype == '' | setlocal nobuflisted nonumber | endif
augroup END

augroup vimrc-feature-terminal
  autocmd!
  autocmd TermOpen * setlocal nospell nobuflisted nonumber textwidth=0 winheight=1
  autocmd BufEnter,BufWinEnter,WinEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END

augroup vimrc-language-other
  autocmd!
  autocmd BufEnter,BufWinEnter,WinEnter Jenkinsfile,Dockerfile set ts=4 | set sw=4
augroup END

augroup vimrc-language-python
  autocmd!
  autocmd FileType python set ts=4 | set sw=4
augroup END

augroup vimrc-language-shell
  autocmd!
  autocmd FileType sh,zsh set noexpandtab
  autocmd FileType sh,zsh set ts=4 | set sw=4
augroup end
