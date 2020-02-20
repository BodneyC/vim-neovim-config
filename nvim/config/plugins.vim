call plug#begin('~/.local/share/nvim/plugged')

" Intellisense
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'Shougo/neco-vim'
  Plug 'neoclide/coc-neco'

" Languages
  Plug 'jeetsukumaran/vim-pythonsense'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-liquid'
  Plug 'udalov/kotlin-vim', {'for': 'kotlin'}
  Plug 'alvan/vim-closetag', {'for': ['html', 'xml']}

" Interface
  Plug 'mhinz/vim-startify'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'moll/vim-bbye'
  Plug 'Yggdroot/indentLine'
  Plug 'itchyny/lightline.vim'
  Plug 'chrisbra/recover.vim'
  Plug 'wellle/visual-split.vim'
  Plug 'bronson/vim-visual-star-search'
  Plug 'skywind3000/vim-quickui'
  Plug 'michaeljsmith/vim-indent-object'

" Projects
  Plug 'brooth/far.vim'

" Git
  Plug 'tpope/vim-fugitive'
  Plug 'oguzbilgic/vim-gdiff', {'on': ['Gdiff', 'Gdiffsplit']}
  Plug 'rbong/vim-flog'
  Plug 'junegunn/gv.vim', {'on': 'GV'}

" Text manipulation
  Plug 'junegunn/vim-easy-align'
  Plug 'tmsvg/pear-tree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-repeat' " Better . functionality
  Plug 'tpope/vim-surround' " Surround with ys<w>
  Plug 'andymass/vim-matchup'
  Plug 'wellle/targets.vim'

" Integrations
  Plug 'benmills/vimux'
  Plug 'ludovicchabant/vim-gutentags'

" Colorschemes
  Plug 'bodneyc/1989.vim', { 'branch': 'personal-touches' }

" Writing
  Plug 'rhysd/vim-grammarous', {'for': ['markdown', 'tex']}
  Plug 'junegunn/goyo.vim', {'for': ['markdown', 'tex']}

" Utils
  Plug 'simnalamburt/vim-mundo'
  Plug 'liuchengxu/vista.vim'
  Plug 'vim-utils/vim-all'

" Personal
  Plug 'https://gitlab.com/BodneyC/VirkSpaces',   { 'branch': 'master' }
  Plug 'https://gitlab.com/BodneyC/At-Zed-vim',   { 'branch': 'master' }
  Plug 'https://gitlab.com/BodneyC/pic-vim',      { 'branch': 'master' }
  Plug 'https://gitlab.com/BodneyC/togool.vim',   { 'branch': 'master' }
  Plug 'https://gitlab.com/BodneyC/hex-this-vim', { 'branch': 'master' }

call plug#end()

" let &runtimepath .= "," . $HOME . "/gitclones/virkspaces"
" let &runtimepath .= "," . $HOME . "/gitclones/1989.vim"
" let &runtimepath .= "," . $HOME . "/gitclones/at-zed-vim"
" let &runtimepath .= "," . $HOME . "/gitclones/pic-vim"
" let &runtimepath .= "," . $HOME . "/gitclones/hex-this-vim"

" May return to
  " Plug 'junegunn/vader.vim'
  " Plug 'stevearc/vim-arduino'
  " Plug 'z3t0/arduvim'
  " Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
  " Plug 'mgedmin/python-imports.vim'
  " Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  " Plug 'scrooloose/nerdtree-project-plugin'
  " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  " Plug 'majutsushi/tagbar'
  " Plug 'ryanoasis/vim-devicons'
  " Plug 'shumphrey/fugitive-gitlab.vim'
  " Plug 'easymotion/vim-easymotion' " \\sX , \\wXX
  " Plug 'kien/ctrlp.vim'
  " Plug 'jiangmiao/auto-pairs'
  " Plug 'inkarkat/vim-ingo-library'  " required by LineJuggler
  " Plug 'inkarkat/vim-LineJuggler', { 'rev': 'stable' }
  " Plug 'terryma/vim-multiple-cursors'
  " Plug 'Konfekt/FastFold'
  " Plug 'tmhedberg/SimpylFold'
  " Plug 'dim13/smyck.vim'
  " Plug 'nightsense/carbonized'
  " Plug 'joshdick/onedark.vim'
  " Plug 'chr4/jellygrass.vim'
  " Plug 'nanotech/jellybeans.vim'
  " Plug 'liuchengxu/space-vim-dark'
  " Plug 'dylanaraps/wal.vim'
  " Plug 'cocopon/iceberg.vim'
  " Plug 'sts10/vim-pink-moon'
  " Plug 'scheakur/vim-scheakur'
  " Plug 'NLKNguyen/papercolor-theme'
  " Plug 'rakr/vim-two-firewatch'
  " Plug 'nightsense/vimspectr'
  " Plug 'xolox/vim-misc'
  " Plug 'xolox/vim-notes'
  " Plug 'bodneyc/vim-leader-guide'
  " Plug 'vim-utils/vim-troll-stopper'
  " Plug 'puremourning/vimspector'
  " Plug 'honza/vim-snippets'
