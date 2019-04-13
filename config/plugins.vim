call plug#begin('~/.local/share/nvim/plugged')

" Terminak
Plug 'tc50cal/vim-terminal'

" Linter
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" Plug 'w0rp/ale'

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
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/denite.nvim'

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
