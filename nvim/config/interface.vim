set signcolumn=yes
set noequalalways
set laststatus=2
set hidden
set noshowmode
set expandtab
set tabstop=2
set softtabstop=0
set shiftwidth=0
set textwidth=0
set autoindent
set breakindent
set breakindentopt=shift:3
set smartindent
set ruler
set hls
set cursorline
set nu rnu
set wrap
set linebreak
set mouse=a
set bs=2
" set tags^=.git/tags
set scrolloff=1
set backspace=indent,eol,start
set matchpairs+=<:>
set noautowrite
set ttimeout
set ttimeoutlen=50
set splitbelow
set splitright
set cul
set wildmode=longest,full
set icm=split
set winblend=3
set updatetime=200
set foldenable
set foldmethod=manual
set spelllang=en_gb
set shortmess+=c

set guifont=VictorMono\ Nerd\ Font:h11

let s:undodir = expand('$HOME/.config/nvim/undo')
if ! isdirectory(s:undodir)
  call mkdir(s:undodir, 'p')
endif
exec 'set undodir='.s:undodir
set undofile
set undolevels=10000
set undoreload=10000

let s:notags = expand("$HOME/.notags")
if ! filereadable(s:notags) |
  call writefile([], s:notags)
endif

syntax on
