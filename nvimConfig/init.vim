" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

let g:python_host_prog='/usr/bin/python3'

set nocompatible
filetype off

call plug#begin('/home/benjc/.local/share/nvim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" New

Plug 'kien/ctrlp.vim'
Plug 'hkupty/nvimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rhysd/vim-grammarous'
Plug 'lervag/vimtex'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'BodneyC/TexTemplate-VimPlugin'
Plug 'ervandew/supertab'

" Aesthetics

Plug 'joshdick/onedark.vim'
Plug 'chr4/jellygrass.vim'
Plug 'itchyny/lightline.vim'
"Plug 'ryanoasis/vim-devicons' "UNCOMMENT IF PATCHED FONT IS INSTALLED

call plug#end()

set number
syntax on
filetype on
filetype plugin on
filetype indent on
set autoindent
set modeline
set cursorline
set cursorcolumn
set shiftwidth=4
set tabstop=4
set softtabstop=4
set showmatch
set matchtime=0
set nobackup
set nowritebackup
set directory=/home/benjc/.config/nvim/.swapfiles/
set smartcase
set ignorecase
set hlsearch
set incsearch
set autochdir

" NEW!!!

set linebreak

" Spelling
set spelllang=en_gb
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.tex setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
let g:grammarous#use_vim_spelllang = 1

" !!!WEN


" Colorschemes

if !exists("g:vimrc_loaded")
    colorscheme jellygrass 
    let g:onedark_termcolors = 256
	let g:lightline = { 'colorscheme': 'one', }
	set laststatus=2
	let g:limelight_conceal_guifg = 'DarkGray'
	let g:limelight_conceal_guifg = '#777777'
	hi CursorLine guibg=#434343
	hi CursorColumn guibg=#434343
    if has("gui_running")
		set t_Co=256
        set guioptions-=T
        set guioptions-=L
        set guioptions-=r
        set guioptions-=m
        set gfn=Source\ Code\ Pro\ for\ Powerline\ Semi-Bold\ 10
        set gfw=STHeiti\ 9
        set langmenu=en_US
        set linespace=0
    endif " has
endif " exists(...)


if has("autocmd")  " go back to where you exited
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\""|
        \ endif
endif

set completeopt=longest,menu " preview

if has('mouse')
    set mouse=a
    set selectmode=mouse,key
    set nomousehide
endif


if has('nvim')
  set termguicolors
  set ttimeout
  set ttimeoutlen=0
endif

augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

set foldcolumn=0
set foldlevelstart=200
set foldlevel=200  " disable auto folding

" Modular Config
source /home/benjc/.config/nvim/config/nerdtreeCFG.vim
source /home/benjc/.config/nvim/config/goyo.vim
source /home/benjc/.config/nvim/config/latex.vim
source /home/benjc/.config/nvim/config/pandoc.vim
source /home/benjc/.config/nvim/config/remappings.vim


" NVIMUX
let nvimux_open_term_by_default=1
let g:AutoPairsMutilineClose=0

