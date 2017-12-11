nmap nt :NERDTreeToggle<cr>

let NERDTreeWinSize=25
let NERDTreeMinimalUI=0
let NERDTreeDirArrows=1
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "Close if last window

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif "Open if directory

" UNCOMMENT IF PATCHED FONT IS INSTALLED
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
"set encoding=utf-8
