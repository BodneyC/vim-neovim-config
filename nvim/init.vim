set nocompatible
filetype off

let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

call plug#begin('~/.local/share/nvim/plugged')

" Terminak
Plug 'tc50cal/vim-terminal'

" Linter
Plug 'w0rp/ale'

" Angular
Plug 'Shougo/deoplete.nvim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'for': ['typescript', 'tsx'], 'do': './install.sh' }

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
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'ervandew/supertab'
Plug 'ChesleyTan/wordCount.vim'
Plug 'majutsushi/tagbar'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'justinmk/vim-syntax-extra'
Plug 'lambdalisue/suda.vim'

" Colorschemes

Plug 'dim13/smyck.vim'
Plug 'nightsense/carbonized'
Plug 'joshdick/onedark.vim'
Plug 'chr4/jellygrass.vim'
Plug 'itchyny/lightline.vim'
Plug 'nanotech/jellybeans.vim'

" Note-taking
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'

call plug#end()

"runtime! archlinux.vim
set nocompatible    "run in vim mode
set expandtab       "expand tabs into spaces
set autoindent      "auto-indent new lines
set smartindent     "return ending brackets to proper locations
set tabstop=2       "indentation leves of normal tabs
set softtabstop=-1   "indentation level of soft-tabs
set shiftwidth=0    "how many columns to re-indent with << and >>
set ruler           "show cursor position at all times
set hls           "don't highlight the previous search term
set number          "turn on line numbering
set wrap            "turn on visual word wrapping
set linebreak       "only break lines on 'breakat' characters
set laststatus=2
set mouse=a
syntax on           "turn on syntax highlighting

" Modular Config  
source ~/.config/nvim/config/nerdtreeCFG.vim
source ~/.config/nvim/config/goyo.vim
source ~/.config/nvim/config/latex.vim
source ~/.config/nvim/config/pandoc.vim
source ~/.config/nvim/config/remappings.vim

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
set undodir=$HOME/.config/nvim/undo
set undolevels=100000
set undoreload=100000
