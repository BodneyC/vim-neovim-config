let @t = "mzvip:EasyAlign *|\<CR>`z"
let @h = "YpVr="
nnoremap o A<CR>
nnoremap <leader>S 1z=
setlocal conceallevel=2 concealcursor=

" This is a repeat, but it's easier than making is public
func! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunc

func! s:in_markdown_list()
  let col = col('.') - 1
  return getline('.')[:col - 1] =~ '^\s*-\s*'
endfunc

inoremap <silent><expr> <Tab> pumvisible()
      \ ? "\<C-n>"
      \ : <SID>check_back_space()
      \     ? <SID>in_markdown_list()
      \         ? "<C-o>>><C-o>l<C-o>a"
      \         : "\<Tab>"
      \   : completion#trigger_completion()
inoremap <silent><expr> <S-Tab> pumvisible()
      \ ? "\<C-p>"
      \ : <SID>check_back_space()
      \     ? <SID>in_markdown_list()
      \         ? "<C-o><<<C-o>l<C-o>a"
      \         : "\<S-Tab>"
      \   : completion#trigger_completion()
