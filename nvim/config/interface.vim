" General vim config
" runtime! archlinux.vim
set nocompatible               " run in vim mode
set noequalalways
set hidden
set expandtab                  " expand tabs into spaces
set tabstop=4                  " indentation leves of normal tabs
set softtabstop=0              " indentation level of soft-tabs
set shiftwidth=0               " how many columns to re-indent with << and >>
set autoindent                 " auto-indent new lines
set breakindent                " Indent on wrap
set breakindentopt=shift:1     " Wrap indent of 1
set smartindent                " return ending brackets to proper locations
set ruler                      " show cursor position at all times
set hls                        " don't highlight the previous search term
set cursorline                 " highlihgts the line the cursor is on
set nu rnu                     " turn on line numbering
set wrap                       " turn on visual word wrapping
set linebreak                  " only break lines on 'breakat' characters
set laststatus=2               " Always display
set mouse=a                    " Enable mouse
set bs=2                       " fix backspace on some consoles
set tags^=.git/tags
set scrolloff=1                " # lines below cursor always
set backspace=indent,eol,start " Backspace behaviour
set matchpairs+=<:>            " use % to jump between pairs
set autowrite                  " Automatically write when switching buffers
set ttimeout
set ttimeoutlen=50
set splitbelow
set splitright
set cul
set icm=split
set winblend=10
set updatetime=200
set foldenable
set foldmethod=manual
set spelllang=en_gb

let s:undodir = expand('$HOME/.config/nvim/undo')
if ! isdirectory(s:undodir)
  call mkdir(s:undodir, 'p')
endif
exec 'set undodir='.s:undodir
set undofile
set undolevels=10000
set undoreload=10000

let s:notags = expand("$HOME/.notags")
if !filereadable(s:notags) |
  call writefile([], s:notags)
endif

syntax on                      " turn on syntax highlighting
