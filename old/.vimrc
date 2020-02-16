set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" Terminak
Plug 'tc50cal/vim-terminal'

" Linter
Plug 'w0rp/ale'

" Angular
Plug 'HerringtonDarkholme/yats.vim'

Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Vim Stuff

Plug 'mhinz/vim-startify'
Plug 'kien/ctrlp.vim'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rhysd/vim-grammarous'
Plug 'lervag/vimtex'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/limelight.vim'
"Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'ervandew/supertab'
Plug 'ChesleyTan/wordCount.vim'
Plug 'majutsushi/tagbar'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'justinmk/vim-syntax-extra'

" Colorschemes

Plug 'dim13/smyck.vim'
Plug 'nightsense/carbonized'
Plug 'joshdick/onedark.vim'
Plug 'chr4/jellygrass.vim'
Plug 'itchyny/lightline.vim'
Plug 'nanotech/jellybeans.vim'

call plug#end()

set number
syntax on
filetype on
filetype plugin on
filetype indent on
set mouse=a
set autoindent
set modeline
set cursorline
set cursorcolumn
set tabstop=4
set shiftwidth=0
set softtabstop=-1
set noexpandtab
set showmatch
set matchtime=0
set nobackup
set nowritebackup
set directory=~/.vim/swapfiles
set smartcase
set ignorecase
set hlsearch
set incsearch
set autochdir
set linebreak

" Modular Config  
source ~/.vim/config/nerdtreeCFG.vim
source ~/.vim/config/goyo.vim
source ~/.vim/config/latex.vim
source ~/.vim/config/pandoc.vim
source ~/.vim/config/remappings.vim
source ~/.vim/config/web-dev.vim

" Ale
let g:ale_fixers = {
\	'javascript': ['prettier'],
\	'css': ['prettier'],
\	'typescript': ['prettier']
\}
let g:yats_host_keyword = 1

if has("autocmd")
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal g'\"" | endif
endif

augroup filetypedetect
  au! BufRead,BufNewFile *nc setfiletype nc "http://www.vim.org/scripts/script.php?script_id=1847
  autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp
augroup END

"strip trailing whitespace from certain files
autocmd BufWritePre *.conf :%s/\s\+$//e
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.css :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e

set bs=2 "fix backspace on some consoles

set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs

" For NERDTree
"autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Folding
set nofoldenable
set foldmethod=syntax

" Spelling
set spelllang=en_gb
hi clear SpellBad
hi SpellBad cterm=underline,bold ctermfg=red
hi SpellCap cterm=underline,bold ctermfg=red
hi SpellRare cterm=underline,bold ctermfg=red
hi SpellLocal cterm=underline,bold ctermfg=red
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.tex setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell

let g:onedark_termcolors = 256
colorscheme jellybeans
let g:lightline = { 
			\ 'colorscheme': 'one',
			\ 'active': {
			\   'right': [ [ 'lineinfo' ],
			\              [ 'percent' ],
			\              [ 'WordCount', 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ],
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'readonly', 'filename', 'modified' ] ]
			\ }, 
			\ 'component' : {
			\	'WordCount' : 'wc: %{wordCount#WordCount()}'
			\ }
			\ }
set laststatus=2
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" AutoPairs settings
let g:AutoPairsMultilineClose=0
let g:AutoPairsFlyMode=0

" Undo stuff
set undofile
set undodir=$HOME/.vim/undo
set undolevels=100000
set undoreload=100000
set viminfo+=n~/.vim/.viminfo

" gVim stuff
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Old

" function NERDTreeResize()
"   let curWin = winnr()
"   NERDTreeFocus
"   silent! normal! gg"byG
"   let maxcol = max(map(split(@b, "\n"), 'strlen(v:val)')) - 3
"   exec 'vertical resize' maxcol
"   exec curWin 'wincmd w'
" endfunction
" command! -nargs=0 NERDTreeResize :call NERDTreeResize()

" augroup vimrc_nerdtree
"   autocmd!
"   autocmd FileType nerdtree setlocal signcolumn=no
"   autocmd StdinReadPre * let s:std_in=1
"   autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" augroup END

" function NERDTreeResize()
"   let curWin = winnr()
"   NERDTreeFocus
"   silent! normal! gg"byG
"   let maxcol = max(map(split(@b, "\n"), 'strlen(v:val)')) - 3
"   exec 'vertical resize' maxcol
"   exec curWin 'wincmd w'
" endfunction
" command! -nargs=0 NERDTreeResize :call NERDTreeResize()

" augroup vimrc_nerdtree
"   autocmd!
"   autocmd FileType nerdtree setlocal signcolumn=no
"   autocmd StdinReadPre * let s:std_in=1
"   autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" augroup END

" function! s:openNerdTreeIfNotAlreadyOpen()
"   if ! (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
"     NERDTreeToggle
"     setlocal nobuflisted
"     wincmd w
"   endif
" endfunction
