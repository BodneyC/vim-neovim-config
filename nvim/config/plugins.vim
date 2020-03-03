call plug#begin('~/.local/share/nvim/plugged')
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'Shougo/neco-vim'
  Plug 'neoclide/coc-neco'

  Plug 'jeetsukumaran/vim-pythonsense'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-liquid'
  Plug 'alvan/vim-closetag', {'for': ['html', 'xml']}

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
  Plug 'brooth/far.vim'

  Plug 'tpope/vim-fugitive'
  Plug 'oguzbilgic/vim-gdiff', {'on': ['Gdiff', 'Gdiffsplit']}
  Plug 'rbong/vim-flog'
  Plug 'junegunn/gv.vim', {'on': 'GV'}

  Plug 'junegunn/vim-easy-align'
  Plug 'tmsvg/pear-tree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'andymass/vim-matchup'
  Plug 'wellle/targets.vim'

  Plug 'benmills/vimux'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'soywod/iris.vim'
  Plug 'bodneyc/Comrade'

  Plug 'bodneyc/1989.vim', { 'branch': 'personal-touches' }

  Plug 'rhysd/vim-grammarous', {'for': ['markdown', 'tex']}
  Plug 'junegunn/goyo.vim'

  Plug 'simnalamburt/vim-mundo'
  Plug 'liuchengxu/vista.vim'
  Plug 'vim-utils/vim-all'

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
" let &runtimepath .= "," . $HOME . "/gitclones/Comrade"
