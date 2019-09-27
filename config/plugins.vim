call plug#begin('~/.local/share/nvim/plugged')

" Intellisense
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'Shougo/neco-vim'
  Plug 'neoclide/coc-neco'

" Languages
  Plug 'jeetsukumaran/vim-pythonsense'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-liquid'
  Plug 'udalov/kotlin-vim'
  Plug 'junegunn/vader.vim'
  Plug 'stevearc/vim-arduino'
  Plug 'z3t0/arduvim'
  Plug 'mgedmin/python-imports.vim'

" Interface
  "Plug 'Shougo/denite.nvim'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'scrooloose/nerdtree-project-plugin'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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
  Plug 'ryanoasis/vim-devicons'
  Plug 'yuttie/comfortable-motion.vim'
  Plug 'chrisbra/recover.vim'
  Plug 'frazrepo/vim-rainbow'
  Plug 'mengelbrecht/lightline-bufferline'

" Git
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'shumphrey/fugitive-gitlab.vim'

" Text manipulation
  Plug 'easymotion/vim-easymotion' " \\sX , \\wXX
  Plug 'junegunn/vim-easy-align'
  Plug 'kien/ctrlp.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-repeat' " Better . functionality
  Plug 'tpope/vim-surround' " Surround with ys<w>
  Plug 'inkarkat/vim-ingo-library'  " required by LineJuggler
  Plug 'inkarkat/vim-LineJuggler', { 'rev': 'stable' }
  Plug 'terryma/vim-multiple-cursors'
  Plug 'andymass/vim-matchup'
  Plug 'Konfekt/FastFold'
  Plug 'tmhedberg/SimpylFold'
  
" Integrations
  "Plug 'christoomey/vim-tmux-navigator'
  Plug 'benmills/vimux'
  Plug 'honza/vim-snippets'
  Plug 'ludovicchabant/vim-gutentags'

" Colorschemes
  Plug 'dim13/smyck.vim'
  Plug 'nightsense/carbonized'
  Plug 'joshdick/onedark.vim'
  Plug 'chr4/jellygrass.vim'
  Plug 'nanotech/jellybeans.vim'
  Plug 'liuchengxu/space-vim-dark'
  Plug 'dylanaraps/wal.vim'
  Plug 'cocopon/iceberg.vim'

" Writing
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-notes'
  Plug 'rhysd/vim-grammarous'
  Plug 'junegunn/goyo.vim'
  " Plug 'vim-pandoc/vim-pandoc'
  " Plug 'vim-pandoc/vim-pandoc-syntax'

" Extras
  Plug 'simnalamburt/vim-mundo'
  Plug 'liuchengxu/vista.vim'

" Workspace
  Plug 'BodneyC/VirkSpaces', { 'branch': 'master' }
  Plug 'BodneyC/At-Zed-vim', { 'branch': 'master' }
  Plug 'BodneyC/pic-vim',    { 'branch': 'master' }

call plug#end()

" let &runtimepath.=",/home/benjc/Documents/virkspaces-vim/,/home/benjc/Documents/at-z-vim/,/home/benjc/Documents/pic-vim"
