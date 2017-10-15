" Resizing of slices
nnoremap <silent> <leader>j :resize +5<CR>
nnoremap <silent> <leader>k :resize -5<CR>
nnoremap <silent> <leader>h :vertical resize -5<CR>
nnoremap <silent> <leader>l :vertical resize +5<CR>

" Paste from sys-clipboard
nnoremap <F6> "*yy
inoremap <F6> <esc>"*yyA
nnoremap <F7> "*p
inoremap <F7> <esc>"*pA
nnoremap <F8> gg"*yG``
inoremap <F8> <esc>gg"*yG``A

" Goyo
map <silent> <leader>ge :call goyo#Goyo_e()<CR>
map <silent> <leader>gl :call goyo#Goyo_l()<CR>

" Buffer Control
nnoremap gp :bp<CR>
nnoremap gn :bn<CR>
nnoremap gd :bn|bd#<CR>
nnoremap gl :ls<CR>
" Made a function for this but 'b' doesn't like being passed variables
nnoremap g1 :b1<CR>
nnoremap g2 :b2<CR>
nnoremap g3 :b3<CR>
nnoremap g4 :b4<CR>


" Commands

command! -nargs=0 TODO e D:\Users\BenJC\Documents\1_Current\Programming\TODO.md
command! -nargs=0 ConvLineEndings %s///g


