let mapleader="\<Space>"

" Tags
nnoremap <leader>ct :!DIR=$(git rev-parse --show-toplevel) && ctags -Rf $DIR/.git/tags --tag-relative --extras=+f --exclude=.git --exclude=pkg --exclude=node_modules<CR>

" General leader
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>* :s/\<<c-r><c-w>\>//<left>

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
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <leader><leader> <c-^>
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

" Movement
xnoremap <S-up>   :m-2<CR>gv=gv
xnoremap <S-down> :m'>+<CR>gv=gv
nnoremap <S-up>   :m-2<CR>
nnoremap <S-down> :m+<CR>
inoremap <S-up>   <Esc>:m-2<CR>
inoremap <S-down> <Esc>:m+<CR>

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

function! WinMove(k)
  let t:curwin = winnr()
  exec "wincmd " . a:k
  if(t:curwin == winnr())
    if(match(a:k, '[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd " . a:k
  endif
endfunction

inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l

" FZF
let g:bclose_no_plugin_maps=1
nnoremap <leader>b :Buffer<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Rg 
nnoremap <leader>m :Marks<CR> 
nnoremap <leader>i :IndentLinesToggle<CR>
