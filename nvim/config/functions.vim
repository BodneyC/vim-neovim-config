function! SetIndent(n)
  let &l:ts=a:n | let &l:sw=a:n
  if exists('*IndentLinesReset')
    IndentLinesReset
  endif
endfunction
command! -nargs=1 SetIndent call SetIndent(<f-args>)

function! ChangeIndent(n)
  set noet | %retab! | let &l:ts=a:n | set expandtab | %retab!
  call SetIndent(a:n)
endfunction
command! -nargs=1 ChangeIndent call ChangeIndent(<f-args>)

function! SpellChecker()
  let l:spell = &spell
  if ! l:spell | set spell | endif
  normal! mzgg]S
  while spellbadword()[0] != ''
    let l:cnt = 0
    redraw
    let l:ch = ''
    while index(['y', 'n', 'f', 'r', 'a', 'q'], l:ch) == -1
      if l:cnt > 0 | echom "Incorrect input" | endif
      let l:cnt += 1
      echom "Word: " . expand("<cword>")
            \ . " ([y]es/[n]o/[f]irst/[r]epeat/[a]dd/[q]uit) "
      let l:ch = nr2char(getchar())
      redraw
    endwhile
    if l:ch == 'n'
    elseif l:ch == 'y'
      normal! z=
      let l:nu = input("Make you selection: ")
      exec "normal! ". l:nu . "z="
    elseif l:ch == 'r'
      spellrepall
    elseif l:ch == 'f'
      normal! 1z=
    elseif l:ch == 'a'
      normal! zG
    else
      break
    endif
    normal! ]S
  endwhile
  normal! `z
  if ! l:spell | set nospell | endif
  echo "Spell checker complete"
endfunction

function! MatchOver(...)
  let l:gtw = get(a:, 1, &tw)
  exec "match OverLength /\\%" . l:gtw . "v.\\+/"
endfunction
command! -nargs=? MatchOver call MatchOver(<f-args>)

function! s:zoom_toggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call <SID>zoom_toggle()

function! s:close_if_last(ft, cmd)
  if winnr("$") == 1 && a:ft == &ft
    if a:ft == &ft
      if exists('*virkspaces#vonce_write')
        call virkspaces#vonce_write(a:cmd, 1)
      endif
      bw | q
    else
      if exists('*virkspaces#vonce_remove')
        call virkspaces#vonce_remove(a:cmd)
      endif
    endif
  endif
endfunction

augroup vimrc_coc_explorer
  autocmd!
  autocmd BufEnter * call <SID>close_if_last(
        \ 'coc-explorer',
        \ 'CocCommand explorer --toggle')
  autocmd FileType coc-explorer,nerdtree setlocal wrapmargin=0 signcolumn=no
augroup END

augroup vimrc_startify
  autocmd!
  autocmd FileType startify IndentLinesDisable
augroup END

augroup vimrc_language_other
  autocmd!
  " autocmd BufEnter,BufWinEnter,WinEnter Jenkinsfile*,Dockerfile* set ts=2 sw=2
  autocmd BufEnter,BufWinEnter *.kt,*.kts setlocal comments=s1:/*,mb:*,ex:*/,:// formatoptions+=cro
augroup END

augroup vimrc_general
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \ | exe "normal g'\""
        \ | endif
augroup END

command! -nargs=0 ConvLineEndings %s/<CR>//g
command! -nargs=0 RenameWord CocCommand document.renameCurrentWord
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>
