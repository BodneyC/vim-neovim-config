call plug#begin('~/.local/share/nvim/plugged')

" Intellisense
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  "Plug 'w0rp/ale'
  "Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Languages
  " Typescript
    "Plug 'Shougo/deoplete.nvim'
    "Plug 'HerringtonDarkholme/yats.vim'
    "Plug 'mhartington/nvim-typescript', {'for': ['typescript', 'tsx'], 'do': './install.sh' }
  " Go
    Plug 'fatih/vim-go', { 'tag': '*' }
    Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
  " C++
    Plug 'octol/vim-cpp-enhanced-highlight'

" Interface
  "Plug 'Shougo/denite.nvim'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'mhinz/vim-startify'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'ChesleyTan/wordCount.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'majutsushi/tagbar'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'moll/vim-bbye'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'tpope/vim-eunuch'
  Plug 'Yggdroot/indentLine'
  Plug 'itchyny/lightline.vim'

" Text manipulation
  Plug 'easymotion/vim-easymotion' " \\sX , \\wXX
  Plug 'junegunn/vim-easy-align'
  Plug 'kien/ctrlp.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ervandew/supertab'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-repeat' " Better . functionality
  Plug 'tpope/vim-surround' " Surround with ys<w>
  Plug 'inkarkat/vim-ingo-library'  " required by LineJuggler
  Plug 'inkarkat/vim-LineJuggler', { 'rev': 'stable' }
  Plug 'terryma/vim-multiple-cursors'
  
" Integrations
  " Terminal
    Plug 'wincent/terminus'
  " exCtags
    "Plug 'xolox/vim-easytags'
  " Tmux
    Plug 'benmills/vimux'
  " Git
    Plug 'tpope/vim-fugitive'

" Colorschemes
  "Plug 'dim13/smyck.vim'
  "Plug 'nightsense/carbonized'
  "Plug 'joshdick/onedark.vim'
  Plug 'chr4/jellygrass.vim'
  Plug 'nanotech/jellybeans.vim'
  Plug 'liuchengxu/space-vim-dark' 

" Writing
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-notes'
  Plug 'rhysd/vim-grammarous'
  Plug 'lervag/vimtex'
  Plug 'junegunn/goyo.vim'
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()
