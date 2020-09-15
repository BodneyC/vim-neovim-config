let g:pear_tree_map_special_keys = 0

imap <silent><expr> <CR> pumvisible()
      \ ? complete_info()["selected"] != "-1"
      \   ? "\<Plug>(completion_confirm_completion)"
      \   : "\<C-e>\<CR>"
      \ : "\<Plug>(PearTreeExpand)"

imap <silent><expr> <BS>
      \ getline('.')[:col('.') - 2] =~ '^\s\+$'
      \ ? getline(line('.') - 1) =~ '^\s*$'
      \   ? getline('.') =~ '^\s*$'
      \     ? "<Esc>ck"
      \     : "<C-o>:exe line('.') - 1 . 'delete'<CR>"
      \   : "<C-w><BS>"
      \ : pear_tree#insert_mode#Backspace()

inoremap <silent><expr> <C-f>   pear_tree#insert_mode#JumpOut()
inoremap <silent><expr> <Esc>   pear_tree#insert_mode#Expand()
inoremap <silent><expr> <Space> pear_tree#insert_mode#Space()

" ... well, I'm never going to type these in I suppose...
imap 䙛 <Plug>(PearTreeCloser_])
imap 𭕫 <Plug>(PearTreeCloser_))
imap 𔂈  <Plug>(PearTreeCloser_})

func! s:pear_tree_close(c)
  if (pear_tree#GetSurroundingPair() != [] && pear_tree#GetSurroundingPair()[1] == a:c)
    return pear_tree#insert_mode#JumpOut()
  else
    return pear_tree#insert_mode#HandleCloser(a:c)
  endif
endfunc

inoremap <silent><expr> ]  <SID>pear_tree_close(']')
inoremap <silent><expr> )  <SID>pear_tree_close(')')
inoremap <silent><expr> }  <SID>pear_tree_close('}')
