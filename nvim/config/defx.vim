call defx#custom#column('git', 'indicators', {
      \ 'Modified'  : '~',
      \ 'Staged'    : '+',
      \ 'Untracked' : '✭',
      \ 'Renamed'   : '➜',
      \ 'Unmerged'  : '═',
      \ 'Ignored'   : 'i',
      \ 'Deleted'   : '×',
      \ 'Unknown'   : '?'
      \ })

augroup __DEFX__
  au!
  au BufEnter * if (winnr("$") == 1 && &ft == 'defx') | silent call defx#call_action('add_session') | bd! | q | endif
  au BufLeave * if &ft == 'defx' | silent call defx#call_action('add_session') | endif
augroup END

func! s:defx_open()
  let opts = [
        \ '-columns=indent:git:icons:filename:type',
        \ '-split=vertical',
        \ '-winwidth=32',
        \ '-no-auto-cd',
        \ '-direction=topleft',
        \ '-show-ignored-files',
        \ '-session-file=' . expand('$HOME/.config/defx/sessions/defx-sessions.json')
        \ ]
  exe 'Defx ' . join(opts, ' ')
endfunc
command! DefxOpen call s:defx_open()

nnoremap <silent> <Leader>D :DefxOpen<CR>
