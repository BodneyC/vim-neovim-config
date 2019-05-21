" Resizing of slices
nnoremap <silent> <leader>j :resize -5<CR>
nnoremap <silent> <leader>k :resize +5<CR>
nnoremap <silent> <leader>h :vertical resize +5<CR>
nnoremap <silent> <leader>l :vertical resize -5<CR>

" Paste from sys-clipboard
nnoremap <F1> :help <C-R><C-W><CR>
nnoremap <F4> "*yy
inoremap <F4> <esc>"*yya
nnoremap <F5> "*p
inoremap <F5> <esc>"*pa
nnoremap <F6> gg"*yG``
inoremap <F6> <esc>gg"*yG``a

" F-keys
nnoremap <F7> :set spell!<CR>
inoremap <F7> <esc>:set spell!<CR>a

" Misc
nnoremap Q q

" Tabbing
xnoremap < <gv
xnoremap > >gv
xnoremap <s-tab> <gv
xnoremap <tab> >gv

" Goyo
map <silent> <leader>ge :call goyo#Goyo_e()<CR>
map <silent> <leader>gl :call goyo#Goyo_l()<CR>

" Buffer Control
nnoremap gp :bp<CR>
nnoremap gn :bn<CR>
nnoremap gd :bn<CR>:bd#<CR>
nnoremap g# :b#<CR>
nnoremap gl :ls<CR>
nnoremap gb :Buffers<CR>
nnoremap gm :Map<CR>
" Made a function for this but 'b' doesn't like being passed variables
nnoremap g1 :b1<CR>
nnoremap g2 :b2<CR>
nnoremap g3 :b3<CR>
nnoremap g4 :b4<CR>

" Update .vimrc
nmap <leader>s :so $MYVIMRC
nmap <leader>v :e $MYVIMRC

" Split
nmap <leader>" :sbn<CR>
nmap <leader>% :vert sbn<CR>

" Case beefs
command! Wqa wqa
command! WQa wqa
command! WQ wq
command! Wq wq
command! W w
command! Q q

" Commands
command! -nargs=0 ConvLineEndings %s///g

" Four spaces to eight col tabs
function! ToLin()
	set ts=4
	set noet
	%retab!
	set ts=8
	%retab!
endfunction
nnoremap <F2> :call ToLin()<CR>

" Movement
nnoremap <S-up>   :m-2<CR>
nnoremap <S-down> :m+<CR>
inoremap <S-up>   <Esc>:m-2<CR>
inoremap <S-down> <Esc>:m+<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l

" FZF
nnoremap <silent> <space>b :Buffer<CR>
nnoremap <silent> <space>f :Files<CR>
nnoremap <silent> <space>r :Rg 
nnoremap <silent> <space>m :Marks<CR> 
