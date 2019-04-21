let g:SuperTabDefaultCompletionType = "<c-n>"

"runtime! archlinux.vim
set nocompatible    "run in vim mode
set expandtab       "expand tabs into spaces
set tabstop=2       "indentation leves of normal tabs
set softtabstop=0   "indentation level of soft-tabs
set shiftwidth=0    "how many columns to re-indent with << and >>
set autoindent      "auto-indent new lines
set breakindent
set breakindentopt=shift:1
set smartindent     "return ending brackets to proper locations
set ruler           "show cursor position at all times
set hls           "don't highlight the previous search term
set number          "turn on line numbering
set wrap            "turn on visual word wrapping
set linebreak       "only break lines on 'breakat' characters
set laststatus=2
set mouse=a
set termguicolors
set tags=./tags;$HOME
syntax on           "turn on syntax highlighting

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
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif "Open if directory
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "Close if last window

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

" AStyle
autocmd BufNewFile,BufRead *.C,*.java,*.c,*.H,*.h set formatprg=astyle\ --style=linux\ --indent=spaces\ -f\ -xb\ -xg\ -p

let g:onedark_termcolors = 256
colorscheme jellybeans

hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi Search ctermbg=black ctermfg=white

let g:lightline = { 
			\   'colorscheme': 'one',
			\   'active': {
			\     'right': [ [ 'lineinfo' ],
			\                [ 'percent' ],
			\                [ 'WordCount', 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ],
			\     'left': [ [ 'mode', 'paste' ],
			\               [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
			\   }, 
			\   'component' : {
			\	    'WordCount' : 'wc: %{wordCount#WordCount()}',
			\   },
      \   'component_function': {
      \     'cocstatus': 'coc#status'
      \   }
			\ }
set laststatus=2
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" AutoPairs settings
let g:AutoPairsMultilineClose=0
let g:AutoPairsFlyMode=0

" Undo stuff
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=100000
set undoreload=100000

