function! ChooseTerm(termname)
  let winnr = bufwinnr(a:termname)
  if winnr != -1
    exec winnr . "wincmd q"
  else
    let bufnr = bufnr(a:termname)
    if bufnr != -1
      exec "bd!" . bufnr
    endif
    vs
    setlocal hidden
    exec "wincmd J"
    terminal
    resize 10
    exec "f " a:termname
    startinsert
  endif
endfunction

nnoremap <F10> :call ChooseTerm("term-split")<CR>
inoremap <F10> <esc>:call ChooseTerm("term-split")<CR>a

tnoremap <C-q> <C-\><C-n>
tnoremap <LeftRelease> <Nop>

augroup vimrc_feature_terminal
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen,TermEnter * setlocal nospell signcolumn=no nobuflisted nonu nornu tw=0 wh=1
augroup END

function! BorderedFloat(opts)
  let top = "╭" . repeat("─", a:opts.width - 2) . "╮"
  let mid = "│" . repeat(" ", a:opts.width - 2) . "│"
  let bot = "╰" . repeat("─", a:opts.width - 2) . "╯"
  let lines = [top] + repeat([mid], a:opts.height - 2) + [bot]

  let buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(buf, 0, -1, v:true, lines)
  call nvim_open_win(buf, v:true, a:opts)
  set winhl=Normal:Floating

  return buf
endfunction

let s:terminal_divisor = 0.9

function! FloatingCentred(...)
	let height_divisor = get(a:, 1, s:terminal_divisor)
	let width_divisor = get(a:, 2, s:terminal_divisor)

  let height = float2nr(&lines * height_divisor)
  let width = float2nr(&columns * width_divisor)
  let col = float2nr((&columns - width) / 2)
  let row = float2nr((&lines - height) / 2)

  let opts = {
        \   'relative': 'editor',
        \   'row': row,
        \   'col': col,
        \   'width': width,
        \   'height': height,
        \   'style': 'minimal'
        \ }

  let l:buf = BorderedFloat(opts)

  let opts.row    += 1
  let opts.height -= 2
  let opts.col    += 2
  let opts.width  -= 4

  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)

  return l:buf
endfunction

function! OnTermExit(job_id, code, event) dict
  if a:code == 0 | bd! | endif
endfunction

function! FloatingTerm(cmd)
  let s:buf = FloatingCentred()
  call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
  au BufLeave <buffer> exe 'bw ' . s:buf
endfunction

function! FloatingHelp(...)
  let l:not_in_tags = 0
  let l:query = get(a:, 1, '')
  let s:buf = FloatingCentred()
  setlocal ft=help bt=help
  try
    exec 'help ' . l:query
  catch E149
    let l:not_in_tags = 1
  endtry
  map <buffer> <Esc> :q<CR>
  au BufLeave <buffer> ++once exe 'bw ' . s:buf
  if l:not_in_tags == 1
    bw
    echoe '"' . l:query . '" not in helptags'
  endif
endfunction
command! -nargs=? -complete=help H call FloatingHelp(<f-args>)
command! -nargs=? -complete=help Help call FloatingHelp(<f-args>)

function! FloatingFzf()
  let s:buf = FloatingCentred()
  au BufLeave <buffer> exe 'bw ' . s:buf
endfunction

command! -nargs=0 ToggleLazyGit w | call FloatingTerm('lazygit')
nnoremap <silent> <leader>gl :ToggleLazyGit<CR>

let $FZF_DEFAULT_OPTS='--layout=reverse --margin=1,1'
let g:fzf_layout = { 'window': 'call FloatingFzf()' }
