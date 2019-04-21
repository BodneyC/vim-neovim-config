let g:loaded_netrwPlugin = 1
nnoremap <silent> gx :call netrw#BrowseX(expand('<cfile>'),netrw#CheckIfRemote())<CR>
vnoremap <silent> gx :<C-u>call netrw#BrowseXVis()<CR>
let g:ranger_replace_netrw = 0
let g:ranger_map_keys = 0
nnoremap <silent> <Leader>o :Ranger<CR>
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args>
