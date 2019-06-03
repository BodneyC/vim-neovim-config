let g:loaded_netrwPlugin = 1
let g:ranger_replace_netrw = 0
let g:ranger_map_keys = 0
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

autocmd FileType nerdtree IndentLinesDisable
autocmd FileType nerdtree setlocal signcolumn=no

augroup vimrc-plugin-startify
  autocmd!
  autocmd User Startified IndentLinesDisable
augroup END

augroup vimrc-language-json
  autocmd!
  autocmd BufEnter,BufWinEnter,WinEnter *.json,*.JSON IndentLinesDisable
augroup END

augroup vimrc-feature-directory
  autocmd!
  "autocmd BufEnter,BufWinEnter,WinEnter * if &buftype == '' | setlocal nobuflisted nonumber | endif
augroup END

augroup vimrc-feature-terminal
  autocmd!
  autocmd TermOpen * setlocal nospell nobuflisted nonumber textwidth=0 winheight=1
  autocmd TermOpen * IndentLinesDisable
  autocmd BufEnter,BufWinEnter,WinEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END

augroup vimrc-language-other
  autocmd!
  autocmd BufEnter,BufWinEnter,WinEnter Jenkinsfile,Dockerfile set ts=4 | set sw=4
augroup END

augroup vimrc-language-web
  autocmd!
  autocmd FileType html,css,js set ts=4 | set sw=4
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

" Four spaces to eight col tabs
function! ToLin(n)
	set noet
	%retab!
  let &l:ts=a:n
  set expandtab
	%retab!
  call SetIndent(a:n)
endfunction

command! -nargs=1 ChangeIndent call ToLin(<f-args>)

function SetIndent(n)
  let &l:ts=a:n
  let &l:sw=a:n
  IndentLinesDisable
  IndentLinesEnable
endfunction

command! -nargs=1 SetIndent call SetIndent(<f-args>)
