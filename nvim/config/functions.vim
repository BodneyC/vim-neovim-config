""""""""""""""" Assisting Functions """""""""""""""
function! SetIndent(n)
  let &l:ts=a:n
  let &l:sw=a:n
  if exists('*IndentLinesReset')
    IndentLinesReset
  endif
endfunction
command! -nargs=1 SetIndent call SetIndent(<f-args>)

function! ChangeIndent(n)
	set noet
	%retab!
  let &l:ts=a:n
  set expandtab
	%retab!
  call SetIndent(a:n)
endfunction
command! -nargs=1 ChangeIndent call ChangeIndent(<f-args>)

function! GetHighlightTerm(group, ele)
  let higroup = execute('hi ' . a:group)
  return matchstr(higroup, a:ele.'=\zs\S*')
endfunction
command! -nargs=+ GetHighlightTerm call GetHighlightTerm(<f-args>)

function! UpdateAll()
  let l:cwd = getcwd()
  PlugUpgrade
  PlugUpdate
  CocUpdateSync
  UpdateRemotePlugins
  exec 'cd ' . l:cwd
endfunction
command! -nargs=0 UpdateAll call UpdateAll()

function! HighlightAfterGlobalTextWidth(...)
  let gtw = get(a:, 1, "")
  if gtw == ""
    let gtw = input("Width: ")
  endif
  echom gtw
  exec "match OverLength /\\%" . gtw . "v.\\+/"
endfunction

function! SpellChecker()
  let l:spell = &spell
  if ! l:spell | set spell | endif
  normal! mzgg]S
  while spellbadword()[0] != ''
    let l:cnt = 0
    redraw
    let l:ch = ''
    while index(['y', 'n', 'f', 'r', 'a', 'q'], l:ch) == -1
      if l:cnt > 0
        echom "Incorrect input"
      endif
      let l:cnt += 1
      echom "Word: " . expand("<cword>") . " ([y]es/[n]o/[f]irst/[r]epeat/[a]dd/[q]uit) "
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

function! s:CocFormat(range, line1, line2) abort
  if a:range == 0
    call CocAction('format')
  else
    call cursor(a:line1, 1)
    normal! V
    call cursor(a:line2, 1)
    call CocAction('formatSelected', 'V')
  endif
endfunction

function! WinMove(k)
  let t:curwin = winnr()
  exec "wincmd " . a:k
  if(a:k == 'h' || expand('%') == '[coc-explorer]')
    return
  endif
  if(t:curwin == winnr())
    if(match(a:k, '[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd " . a:k
  endif
endfunction

function! GoyoEnter() abort
  Goyo
  Goyo!
  Goyo 65%x75%
endfunction

function! GoyoLeave() abort
  Goyo!
  so ~/.config/nvim/config/highlighting.vim
endfunction

function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

function! MakeTagsFile()
  if len(g:virk_root_dir) > 0 && g:virk_tags_enable != 0
    VSMakeTagsFile
  elseif ! exists('g:gutentags_generate_on_write')
    !DIR=$(git rev-parse --show-toplevel) && ctags -Rf $DIR/.git/tags $DIR
  else
    echom "VS tags disabled, gutentags in operation"
  endif
endfunction

function! s:CocExplorerOnClose()
  if (winnr("$") == 1 && expand('%') =~ '\[coc-explorer\].*')
    if exists('*virkspaces#virkvoncewrite')
      call virkspaces#virkvoncewrite('CocCommand explorer --toggle', 1)
    endif
    bw
    q
  endif
endfunction

augroup vimrc_coc_explorer
  autocmd!
  autocmd BufEnter * call s:CocExplorerOnClose()
  autocmd FileType coc-explorer setlocal wrapmargin=0
augroup END

augroup vimrc_startify
  autocmd!
  autocmd FileType startify IndentLinesDisable
augroup END

augroup vimrc_language_other
  autocmd!
  autocmd BufEnter,BufWinEnter,WinEnter Jenkinsfile,Dockerfile set ts=4 | set sw=4
augroup END

augroup vimrc_general
  autocmd!
  autocmd BufWritePre * if search(' \+$', 'n') != 0
        \ | let cursor = getcurpos()
        \ | %s/ \+$//e|''
        \ | call setpos('.', cursor)
        \ | endif
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \ | exe "normal g'\""
        \ | endif
augroup END

command! -nargs=0 ConvLineEndings %s/<CR>//g
command! -nargs=0 RenameWord CocCommand document.renameCurrentWord
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>

" Old

" function NERDTreeResize()
"   let curWin = winnr()
"   NERDTreeFocus
"   silent! normal! gg"byG
"   let maxcol = max(map(split(@b, "\n"), 'strlen(v:val)')) - 3
"   exec 'vertical resize' maxcol
"   exec curWin 'wincmd w'
" endfunction
" command! -nargs=0 NERDTreeResize :call NERDTreeResize()

" augroup vimrc_nerdtree
"   autocmd!
"   autocmd FileType nerdtree setlocal signcolumn=no
"   autocmd StdinReadPre * let s:std_in=1
"   autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" augroup END

" function NERDTreeResize()
"   let curWin = winnr()
"   NERDTreeFocus
"   silent! normal! gg"byG
"   let maxcol = max(map(split(@b, "\n"), 'strlen(v:val)')) - 3
"   exec 'vertical resize' maxcol
"   exec curWin 'wincmd w'
" endfunction
" command! -nargs=0 NERDTreeResize :call NERDTreeResize()

" augroup vimrc_nerdtree
"   autocmd!
"   autocmd FileType nerdtree setlocal signcolumn=no
"   autocmd StdinReadPre * let s:std_in=1
"   autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" augroup END

" function! s:openNerdTreeIfNotAlreadyOpen()
"   if ! (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
"     NERDTreeToggle
"     setlocal nobuflisted
"     wincmd w
"   endif
" endfunction
