func! s:set_indent(n)
  let &l:ts=a:n | let &l:sw=a:n
  if exists(":IndentLinesReset")
    IndentLinesReset
  endif
endfunc

func! s:change_indent(n)
  set et! | %retab!
  let &l:ts=a:n
  set et! | %retab!
  call <SID>set_indent(a:n)
endfunc

func! s:spell_checker()
  let spell = &spell
  if ! spell | set spell | endif
  normal! mzgg]S
  while spellbadword()[0] != ""
    let cnt = 0
    redraw
    let ch = ""
    while index(["y", "n", "f", "r", "a", "q"], ch) == -1
      if cnt > 0 | echom "Incorrect input" | endif
      let cnt += 1
      echom "Word: " . expand("<cword>")
            \ . " ([y]es/[n]o/[f]irst/[r]epeat/[a]dd/[q]uit) "
      let ch = nr2char(getchar())
      redraw
    endwhile
    if ch == "n"
    elseif ch == "y"
      normal! z=
      let nu = input("Make your selection: ")
      exe "normal! ". nu . "z="
    elseif ch == "r"
      spellrepall
    elseif ch == "f"
      normal! 1z=
    elseif ch == "a"
      normal! zG
    else
      break
    endif
    normal! ]S
  endwhile
  normal! `z
  if ! spell | set nospell | endif
  echo "Spell checker complete"
endfunc

func! s:match_over(...)
  let gtw = get(a:, 1, &tw)
  exe "match OverLength /\\%" . gtw . "v.\\+/"
endfunc

func! s:zoom_toggle() abort
  if exists("t:zoomed") && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunc

func! s:highlight_under_cursor()
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:large_file = 10485760 " 10MB
augroup __CONFIG_GENERAL__
  au!
  au BufReadPost *        if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
  au FileType    startify if exists(":IndentLinesDisable") | exe "IndentLinesDisable" | endif
  au WinEnter    *        if &nu && ! &rnu | setlocal rnu   | endif
  au WinLeave    *        if &nu &&   &rnu | setlocal nornu | endif
  au BufReadPre  *
        \ if getfsize(expand("<afile>")) > g:large_file |
        \   set eventignore+=FileType |
        \   setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
        \ endif
  au BufRead,BufNewFile *.MD set ft=markdown
augroup end

" Mode -| Args ---| Name ---------------| Action ----------------------------------------------------- "
command! -nargs=0  ConvLineEndings       %s/<CR>//g
command! -nargs=0  HighlightUnderCursor  call <SID>highlight_under_cursor()
command! -nargs=0  SpellChecker          call <SID>spell_checker()
command! -nargs=0  ZoomToggle            call <SID>zoom_toggle()
command! -nargs=1  ChangeIndent          call <SID>change_indent(<f-args>)
command! -nargs=1  SetIndent             call <SID>set_indent(<f-args>)
command! -nargs=?  MatchOver             call <SID>match_over(<f-args>)
