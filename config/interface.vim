" General vim config
  " runtime! archlinux.vim
  set nocompatible               " run in vim mode
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
  set nu rnu                     " turn on line numbering
  set wrap                       " turn on visual word wrapping
  set linebreak                  " only break lines on 'breakat' characters
  set laststatus=2               " Always display
  set mouse=a                    " Enable mouse
  set tags=.git/tags;$HOME       " Search upwards to $HOME for tag file
  set bs=2                       " fix backspace on some consoles
  set scrolloff=1                " # lines below cursor always
  set backspace=indent,eol,start " Backspace behaviour
  set matchpairs+=<:>            " use % to jump between pairs
  set autowrite                  " Automatically write when switching buffers
  set ttimeout
  set ttimeoutlen=50
  set splitbelow
  set splitright
  set cul
  syntax on                      " turn on syntax highlighting

" Folding
  set nofoldenable
  set foldmethod=syntax

" Last position when opening file
  if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
  endif

" Strip trailing whitespace on save
  autocmd BufWritePre *.conf :%s/\s\+$//e
  autocmd BufWritePre *.py :%s/\s\+$//e
  autocmd BufWritePre *.css :%s/\s\+$//e
  autocmd BufWritePre *.html :%s/\s\+$//e

" Spelling
  set spelllang=en_gb
  " autocmd BufRead,BufNewFile *.md,*.tex setlocal spell

" AStyle
"   autocmd BufNewFile,BufRead *.C,*.java,*.c,*.H,*.h set formatprg=astyle\ --style=linux\ --indent=spaces\ -f\ -xb\ -xg\ -p

" Colorscheme
  let g:onedark_termcolors = 256
  " set notermguicolors
  colorscheme iceberg

" Lightline
  set laststatus=2
  let g:limelight_conceal_guifg = 'DarkGray'
  let g:limelight_conceal_guifg = '#777777'

  let g:lightline = { 
        \   'colorscheme': 'one',
        \   'active': {
        \     'right': [ [ 'lineinfo' ],
        \                [ 'fileformat', 'fileencoding', 'filetype' ] ],
        \     'left': [ [ 'filename' ],
        \               [ 'git', 'paste', 'cocstatus', 'readonly', 'Fugitive', 'modified' ] ]
        \   }, 
        \   'component' : {
        \	    'WordCount' : 'wc: %{wordCount#WordCount()}',
        \     'Fugitive': '%{FugitiveStatusline()}',
        \   },
        \   'component_function': {
        \     'cocstatus': 'coc#status'
        \   }
        \ }
  let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
  let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
  let g:lightline.component_type   = {'buffers': 'tabsel'}
  let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette

  let s:palette.normal.middle   = [ [ 'NONE', 'NONE', 'NONE', '235' ] ]
  let s:palette.normal.left     = [ [ 'black', '#98c379', 'black', 'green' ] ]
  let s:palette.normal.right    = s:palette.normal.left

  let s:palette.inactive.middle = [ [ 'NONE', 'NONE', 'NONE', '235' ] ]
  let s:palette.inactive.left   = s:palette.inactive.middle
  let s:palette.inactive.right  = s:palette.inactive.middle

  let s:palette.insert.left     = [ [ 'black', '#61afef', 'black', 'blue' ] ]
  let s:palette.insert.right    = s:palette.insert.left

  let s:palette.visual.left     = [ [ 'black', '#c678dd', 'black', '140' ] ]
  let s:palette.visual.right    = s:palette.visual.left

  let s:palette.replace.middle  = [ [ 'NONE', 'NONE', 'NONE', '235' ] ]
  let s:palette.replace.left    = [ [ 'black', '#98c379', 'black', 'red' ] ]
  let s:palette.replace.right   = s:palette.replace.left

" AutoPairs settings
  let g:AutoPairsMultilineClose=0
  let g:AutoPairsFlyMode=0

" Undo stuff
  set undofile
  set undodir=$HOME/.config/nvim/undo
  set undolevels=10000
  set undoreload=10000
