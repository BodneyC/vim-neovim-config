nnoremap <silent><buffer><expr> <CR>
      \ defx#is_directory() ?
      \   defx#do_action('open_tree', 'recursive:10') :
      \   defx#do_action('open', 'botright vsplit')
nnoremap <silent><buffer> O
      \ defx#is_directory() ?
      \   defx#do_action('open_tree', 'recursive:10') :
      \   defx#do_action('open', 'wincmd p \| e')
nnoremap <silent><buffer><expr> <2-LeftMouse>
      \ defx#is_directory() ?
      \   defx#do_action('open_tree') :
      \   defx#do_action('open', 'wincmd p \| e')
nnoremap <silent><buffer><expr> o
      \ defx#is_directory() ?
      \   defx#do_action('open_tree') :
      \   defx#do_action('open', 'wincmd p \| e')
nnoremap <silent><buffer><expr> l
      \ defx#is_directory() ?
      \   defx#do_action('open_tree') :
      \   defx#do_action('open', 'wincmd p \| e')
nnoremap <silent><buffer><expr> h defx#do_action('close_tree')
nnoremap <silent><buffer><expr> q defx#do_action('quit')
nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
nnoremap <silent><buffer><expr> a defx#do_action('new_file')
nnoremap <silent><buffer><expr> A defx#do_action('new_directory')
nnoremap <silent><buffer><expr> r defx#do_action('rename')
nnoremap <silent><buffer><expr> R defx#redraw()
nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
nnoremap <silent><buffer><expr> Y defx#do_action('yank_path')
nnoremap <silent><buffer><expr> c defx#do_action('copy')
nnoremap <silent><buffer><expr> C defx#do_action('move')
nnoremap <silent><buffer><expr> p defx#do_action('paste')

let s:defx_rem_prev = []

func! s:defx_rem_rm(ctx) abort
  call add(s:defx_rem_prev, a:ctx.targets)
  let cmd = 'rem rm ' . join(a:ctx.targets, ' ')
  echom cmd
  call system(cmd)
endfunc
nnoremap <silent><buffer><expr> dd defx#do_action('call', '<SID>defx_rem_rm')

func! s:defx_rem_rs(ctx) abort
  if len(s:defx_rem_prev) && len(s:defx_rem_prev[0])
    let cmd = 'rem rs ' . join(s:defx_rem_prev[-1], ' ')
    echom cmd
    call system(cmd)
    let s:defx_rem_prev = s:defx_rem_prev[:-2]
  else
    echom 'Nothing remed yet'
  endif
endfunc

nnoremap <silent><buffer><expr> u defx#do_action('call', '<SID>defx_rem_rs')
