function! s:set_indent(n)
  let &l:ts=a:n | let &l:sw=a:n
  if exists(":IndentLinesReset")
    IndentLinesReset
  endif
endfunction

function! s:change_indent(n)
  set noet | %retab! | let &l:ts=a:n
  set expandtab | %retab!
  call SetIndent(a:n)
endfunction

function! s:spell_checker()
  let l:spell = &spell
  if ! l:spell | set spell | endif
  normal! mzgg]S
  while spellbadword()[0] != ""
    let l:cnt = 0
    redraw
    let l:ch = ""
    while index(["y", "n", "f", "r", "a", "q"], l:ch) == -1
      if l:cnt > 0 | echom "Incorrect input" | endif
      let l:cnt += 1
      echom "Word: " . expand("<cword>")
            \ . " ([y]es/[n]o/[f]irst/[r]epeat/[a]dd/[q]uit) "
      let l:ch = nr2char(getchar())
      redraw
    endwhile
    if l:ch == "n"
    elseif l:ch == "y"
      normal! z=
      let l:nu = input("Make you selection: ")
      exec "normal! ". l:nu . "z="
    elseif l:ch == "r"
      spellrepall
    elseif l:ch == "f"
      normal! 1z=
    elseif l:ch == "a"
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

function! s:match_over(...)
  let l:gtw = get(a:, 1, &tw)
  exec "match OverLength /\\%" . l:gtw . "v.\\+/"
endfunction

function! s:zoom_toggle() abort
  if exists("t:zoomed") && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction

augroup config_general
  autocmd!
  autocmd BufEnter,BufWinEnter *.kt,*.kts setlocal comments=s1:/*,mb:*,ex:*/,:// formatoptions+=cro
  autocmd BufReadPost          *          if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
  autocmd FileType             startify   if exists(":IndentLinesDisable") | exe "IndentLinesDisable" | endif
augroup END

" Mode -| Args ---| Name ---------| Action ----------------------------------------------------- "
command! -nargs=0  ConvLineEndings %s/<CR>//g
command! -nargs=0  SpellChecker    call <SID>spell_checker()
command! -nargs=0  ZoomToggle      call <SID>zoom_toggle()
command! -nargs=1  ChangeIndent    call <SID>change_indent(<f-args>)
command! -nargs=1  SetIndent       call <SID>set_indent(<f-args>)
command! -nargs=?  MatchOver       call <SID>match_over(<f-args>)
