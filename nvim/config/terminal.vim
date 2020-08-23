func! s:close_if_terminal_job()
  if exists('b:terminal_job_pid')
    try
      close
    catch /E444.*/
      echom "Could not close terminal"
    endtry
  endif
endfunc

func! TermSplit(bang)
  let term_name = "term://" . s:term_name
  let winnr = bufwinnr(term_name)
  if winnr != -1
    if(a:bang)
      exe winnr . "wincmd q"
    else
      exe winnr . "wincmd w"
    endif
  else
    let bufnr = bufnr(term_name)
    if bufnr != -1
      exe "bd!" . bufnr
    endif
    if(a:bang)
      vsplit
    else
      10 wincmd j
      split
      wincmd j
    endif
    setlocal hidden
    if(a:bang)
      wincmd J
    endif
    terminal
    resize 10
    exe "f " . term_name
    au! TermClose <buffer> call <SID>close_if_terminal_job()
    startinsert
  endif
endfunc
command! -bang TermSplit call TermSplit(<bang>0)

let s:term_name = "term-split"

nnoremap <silent> <F10> :TermSplit!<CR>
inoremap <silent> <F10> <C-o>:TermSplit!<CR>
tnoremap <silent> <F10> <C-\><C-n>:TermSplit!<CR>

nnoremap <silent> <C-q> :TermSplit<CR>
tnoremap <silent> <C-q> <C-\><C-n>:wincmd p<CR>
tnoremap <silent> <LeftRelease> <Nop>

augroup __TERMINAL__
  au!
  au TermOpen,TermEnter,BufNew,BufEnter term://* startinsert
  au TermOpen,TermEnter * setlocal nospell signcolumn=no nobuflisted nonu nornu tw=0 wh=1 winhl=Normal:CursorLine,EndOfBuffer:EndOfBufferWinHl
augroup end

let s:border_buf = -1
func! s:border_box(h, w, c, r)
  let bar = repeat("─", a:w) 
  let top = "╭" . bar . "╮"
  let mid = "│" . repeat(" ", a:w) . "│"
  let bot = "╰" . bar . "╯"
  let lines = [top] + repeat([mid], a:h) + [bot]
  let buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(buf, 0, -1, v:true, lines)
  let opts = {
        \   'relative': 'editor',
        \   'row': a:r - 1,
        \   'col': a:c - 1,
        \   'width': a:w + 2,
        \   'height': a:h + 2,
        \   'style': 'minimal'
        \ }
  call nvim_open_win(buf, v:true, opts)
  let s:border_buf = buf
  return buf
endfunc

let s:terminal_divisor = 0.9

func! FloatingCentred(...)
  let height_divisor = get(a:, 1, s:terminal_divisor)
  let width_divisor = get(a:, 2, s:terminal_divisor)
  let height = float2nr(&lines * height_divisor)
  let width = float2nr(&columns * width_divisor)
  let col = float2nr((&columns - width) / 2)
  let row = float2nr((&lines - height) / 2)
  let buf = s:border_box(height, width, col, row)
  let opts = {
        \   'relative': 'editor',
        \   'row': row,
        \   'col': col,
        \   'width': width,
        \   'height': height,
        \   'style': 'minimal'
        \ }
  let cur_float_win = nvim_create_buf(v:false, v:true)
  call nvim_open_win(cur_float_win, v:true, opts)
  augroup __FLOAT__
    au!
    exe 'au BufWipeout <buffer=' . cur_float_win . '> bd! ' . buf
  augroup end
  setlocal winhl=Normal:NormalFloat
  return cur_float_win
endfunc

func! s:on_term_exit(job_id, code, event) dict
  if a:code == 0 | bd! | endif
endfunc

func! FloatingTerm(...)
  let cmd = get(a:, 1, $SHELL)
  call FloatingCentred()
  call termopen(cmd, { 'on_exit': function('<SID>on_term_exit') })
endfunc

func! FloatingMan(...)
  call FloatingTerm('man ' .join(a:000, ' '))
endfunc
command! -nargs=+ -complete=shellcmd M call FloatingMan(<f-args>)

let s:help_buf = 0
func! FloatingHelp(...)
  if s:help_buf != -1 && bufexists(s:help_buf)
    exe 'bw! ' . s:help_buf
    let s:help_buf = -1
  endif
  let query = get(a:, 1, '')
  let buf = FloatingCentred()
  let s:help_buf = buf
  augroup __FLOAT__
    au!
  augroup end
  setlocal ft=help bt=help
  let not_in_tags = 0
  try
    exe 'help ' . query
  catch E149
    let not_in_tags = 1
  endtry
  if s:border_buf != -1
    augroup __FLOAT__
      exe 'au BufWipeout <buffer=' . buf . '> bd! ' . s:border_buf
    augroup end
  endif
  map <buffer> <Esc> :bw<CR>
  if not_in_tags == 1
    bw
    echoe '"' . query . '" not in helptags'
  endif
endfunc
command! -nargs=? -complete=help H call FloatingHelp(<f-args>)
command! -nargs=? -complete=help Help call FloatingHelp(<f-args>)
