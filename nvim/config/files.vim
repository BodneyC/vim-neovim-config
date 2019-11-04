command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

augroup vimrc_nerdtree
  autocmd!
  autocmd FileType nerdtree setlocal signcolumn=no
  autocmd StdinReadPre * let s:std_in=1
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

augroup vimrc_coc_explorer
  autocmd!
  autocmd BufEnter * if (winnr("$") == 1 && expand('%') == '[coc-explorer]') | q | endif
augroup END

augroup vimrc_startify
  autocmd!
  autocmd FileType startify IndentLinesDisable
augroup END

augroup vimrc_language_other
  autocmd!
  autocmd BufEnter,BufWinEnter,WinEnter Jenkinsfile,Dockerfile set ts=4 | set sw=4
augroup END

augroup vimrc_language_web
  autocmd!
  autocmd FileType html,css,js set ts=4 | set sw=4
augroup END

" Four spaces to eight col tabs
function! ChangeIndent(n)
	set noet
	%retab!
  let &l:ts=a:n
  set expandtab
	%retab!
  call SetIndent(a:n)
endfunction
command! -nargs=1 ChangeIndent call ChangeIndent(<f-args>)

function! SetIndent(n)
  let &l:ts=a:n
  let &l:sw=a:n
  IndentLinesDisable
  IndentLinesEnable
endfunction
command! -nargs=1 SetIndent call SetIndent(<f-args>)

function! GetHighlightTerm(group, ele)
  let higroup = execute('hi ' . a:group)
  return matchstr(higroup, a:ele.'=\zs\S*')
endfunction
command! -nargs=+ GetHighlightTerm call GetHighlightTerm(<f-args>)
