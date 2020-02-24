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
  if gtw == "" | let gtw = input("Width: ") | endif
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

" https://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
function! s:ZoomToggle() abort
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
command! ZoomToggle call <SID>ZoomToggle()

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
  " Find a way to source these commands better
  autocmd BufEnter * call <SID>close_if_last(
        \ 'nerdtree',
        \ 'tabn 1 | NERDTreeToggle | exec "NERDTreeProjectLoadFromCWD" | normal! <C-w><C-l>')
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


""""" TMP

" function! _UsesOfSymb(symb)
"     let l:space = substitute(getline('.'), '^\( *\).*$', '\1', '')
"     exec "-1r!{echo -e \"" . l:space . "/**\\n" 
"                 \ . l:space . " * Name: " . a:symb . "\\n" 
"                 \ . l:space . " * \\n" 
"                 \ . l:space . " * Desc: \\n" 
"                 \ . l:space . " * \\n" 
"                 \ . l:space . " * Used in:\"; rg -l '[^A-Za-z0-9]" 
"                 \ . a:symb 
"                 \ . "[^A-Za-z0-9]' | rg -v -i test | awk -F'/' '{print \"" 
"                 \ . l:space . " *   \"$(NF-1)\"/\"$NF}' | sort; echo \"" 
"                 \ . l:space . " */\"}"
" endfunction

function! _UsesOfSymb()
    let l:space = substitute(getline('.'), '^\( *\).*$', '\1', '')
    exec "-1r!echo -e \"" 
                \ . l:space . "/**\\n" 
                \ . l:space . " * \\n" 
                \ . l:space . " */"
endfunction

nnoremap <C-e> :call _UsesOfSymb()<CR>
