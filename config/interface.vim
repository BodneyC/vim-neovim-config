" Plugin variable settings
  let g:SuperTabDefaultCompletionType = "<c-n>"
  let g:indentLine_showFirstIndentLevel = 1
  let g:yats_host_keyword = 1

" General vim config
  " runtime! archlinux.vim
  set nocompatible               " run in vim mode
  set expandtab                  " expand tabs into spaces
  set tabstop=2                  " indentation leves of normal tabs
  set softtabstop=0              " indentation level of soft-tabs
  set shiftwidth=0               " how many columns to re-indent with << and >>
  set autoindent                 " auto-indent new lines
  set breakindent                " Indent on wrap
  set breakindentopt=shift:1     " Wrap indent of 1
  set smartindent                " return ending brackets to proper locations
  set ruler                      " show cursor position at all times
  set hls                        " don't highlight the previous search term
  set number                     " turn on line numbering
  set wrap                       " turn on visual word wrapping
  set linebreak                  " only break lines on 'breakat' characters
  set laststatus=2               " Always display
  set mouse=a                    " Enable mouse
  set termguicolors              " Should probably check if available
  set tags=.git/tags;$HOME          " Search upwards to $HOME for tag file
  set bs=2                       " fix backspace on some consoles
  set scrolloff=3                " # lines below cursor always
  set backspace=indent,eol,start " Backspace behaviour
  set matchpairs+=<:>            " use % to jump between pairs
  set autowrite                  " Automatically write when switching buffers
  set ttimeout
  set ttimeoutlen=50
  set splitbelow
  set splitright
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
  hi clear SpellBad
  hi SpellBad cterm=underline,bold ctermfg=red
  hi SpellCap cterm=underline,bold ctermfg=red
  hi SpellRare cterm=underline,bold ctermfg=red
  hi SpellLocal cterm=underline,bold ctermfg=red
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd BufRead,BufNewFile *.tex setlocal spell
  autocmd BufRead,BufNewFile *.txt setlocal spell

" AStyle
  autocmd BufNewFile,BufRead *.C,*.java,*.c,*.H,*.h set formatprg=astyle\ --style=linux\ --indent=spaces\ -f\ -xb\ -xg\ -p

" Colorscheme
  let g:onedark_termcolors = 256
  colorscheme space-vim-dark
  hi Normal guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
  hi LineNr guibg=NONE ctermbg=NONE
  hi Search ctermbg=black ctermfg=white

" Lightline
  set laststatus=2
  let g:limelight_conceal_guifg = 'DarkGray'
  let g:limelight_conceal_guifg = '#777777'

  let g:lightline = { 
        \   'colorscheme': 'one',
        \   'active': {
        \     'right': [ [ 'lineinfo' ],
        \                [ 'percent' ],
        \                [ 'WordCount', 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ],
        \     'left': [ [ 'mode' ],
        \               [ 'paste', 'cocstatus', 'readonly', 'filename', 'Fugitive', 'modified' ] ]
        \   }, 
        \   'component' : {
        \	    'WordCount' : 'wc: %{wordCount#WordCount()}',
        \     'Fugitive': '%{FugitiveStatusline()}',
        \   },
        \   'component_function': {
        \     'cocstatus': 'coc#status'
        \   }
        \ }
  let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
  let s:palette.normal.middle   = [ [ 'NONE', '#111111', 'NONE', 'NONE' ] ]
  let s:palette.normal.left     = [ [ 'black', '#98c379', 'NONE', 'NONE' ] ]
  let s:palette.normal.right    = s:palette.normal.left
  let s:palette.inactive.middle = [ [ 'NONE', '#111f23', 'NONE', 'NONE' ] ]
  let s:palette.inactive.left   = s:palette.inactive.middle
  let s:palette.inactive.right  = s:palette.inactive.middle
  let s:palette.insert.left     = [ [ 'black', '#61afef', 'NONE', 'NONE' ] ]
  let s:palette.insert.right    = s:palette.insert.left
  let s:palette.visual.left     = [ [ 'black', '#c678dd', 'NONE', 'NONE' ] ]
  let s:palette.visual.right    = s:palette.visual.left
  let s:palette.replace.right   = s:palette.replace.left
  let s:palette.replace.left    = [ [ 'black', '#e06c75', 'NONE', 'NONE' ] ]

" AutoPairs settings
  let g:AutoPairsMultilineClose=0
  let g:AutoPairsFlyMode=0

" Undo stuff
  set undofile
  set undodir=$HOME/.config/nvim/undo
  set undolevels=100000
  set undoreload=100000

