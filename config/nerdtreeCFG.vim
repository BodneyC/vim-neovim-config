nnoremap <leader>nt :NERDTreeToggle<cr>

let NERDTreeWinSize=25
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowBookmarks=0
let NERDTreeShowHidden=1     

let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"

autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * 
      \   if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
      \ |   Startify 
      \ |   exe 'NERDTree' argv()[0]
      \ |   setlocal nobuflisted
      \ |   wincmd w
      \ | endif 
autocmd VimEnter * 
      \   if argc() == 0
      \ |   Startify 
      \ |   exe 'NERDTree'
      \ |   setlocal nobuflisted
      \ |   wincmd w
      \ | endif 

set encoding=UTF-8
