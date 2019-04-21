call plug#begin('~/.local/share/nvim/plugged')

" Linter
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"Plug 'w0rp/ale'

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
Plug 'junegunn/fzf.vim'

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
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/denite.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'xolox/vim-easytags'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'tpope/vim-eunuch'
Plug 'Yggdroot/indentLine'
Plug 'wincent/terminus'
Plug 'moll/vim-bbye'
" Better . functionality
Plug 'tpope/vim-repeat'
" Surround with ys<w>"
Plug 'tpope/vim-surround'
" n[<space> add space 
Plug 'inkarkat/vim-ingo-library'  " required by LineJuggler
Plug 'inkarkat/vim-LineJuggler', { 'rev': 'stable' }
Plug 'itchyny/lightline.vim'

" Colorschemes

"Plug 'dim13/smyck.vim'
"Plug 'nightsense/carbonized'
"Plug 'joshdick/onedark.vim'
Plug 'chr4/jellygrass.vim'
Plug 'nanotech/jellybeans.vim'

" Note-taking
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'

call plug#end()
