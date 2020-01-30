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
syntax on                      " turn on syntax highlighting
set foldenable
set foldmethod=manual

" Last position when opening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \ | exe "normal g'\""
        \ | endif
endif

" Spelling
set spelllang=en_gb

" Undo stuff
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=10000
set undoreload=10000
