set autoindent
set backspace=indent,eol,start
set breakindent
set breakindentopt=shift:3
set bs=2
set cul
set cursorcolumn
set cursorline
set expandtab
set foldenable
set foldmethod=manual
set hidden
set hls
set icm=split
set laststatus=2
set linebreak
set matchpairs+=<:>
set mouse=a
set noautowrite
set noequalalways
set noshowmode
set nu rnu
set ruler
set scrolloff=1
set shiftwidth=0
set shortmess+=c
set signcolumn=yes
set smartindent
set softtabstop=0
set spelllang=en_gb
set splitbelow
set splitright
set tabstop=2
set textwidth=0
set ttimeout
set ttimeoutlen=50
set updatetime=50
set wildmode=longest,full
set winblend=6
set wrap
set fillchars=vert:\|

set guifont=VictorMono\ Nerd\ Font:h11

let s:undodir = expand('$HOME/.config/nvim/undo')
if ! isdirectory(s:undodir)
  call mkdir(s:undodir, 'p')
endif
exe 'set undodir='.s:undodir
set undofile
set undolevels=10000
set undoreload=10000

let s:notags = expand("$HOME/.notags")
if ! filereadable(s:notags) |
  call writefile([], s:notags)
endif

syntax on
