call plug#begin('~/.local/share/nvim/plugged')
  Plug 'BodneyC/At-Zed-vim',   { 'branch': 'master' }
  Plug 'BodneyC/VirkSpaces',   { 'branch': 'master' }
  Plug 'BodneyC/bolorscheme',  { 'branch': 'master' }
  Plug 'BodneyC/flocho',       { 'branch': 'master' }
  Plug 'BodneyC/hex-this-vim', { 'branch': 'master' }
  Plug 'BodneyC/pic-vim',      { 'branch': 'master' }
  Plug 'BodneyC/togool.vim',   { 'branch': 'master' }
  Plug 'Shougo/neco-vim'
  Plug 'Yggdroot/indentLine'
  Plug 'alvan/vim-closetag', {'for': ['html', 'xml', 'markdown']}
  Plug 'andymass/vim-matchup'
  Plug 'benmills/vimux'
  Plug 'bodneyc/Comrade'
  Plug 'bodneyc/spelunker.vim', { 'branch': 'feature/quickui_support' }
  Plug 'bronson/vim-visual-star-search'
  Plug 'brooth/far.vim'
  Plug 'chrisbra/recover.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'dylanaraps/fff.vim'
  Plug 'janko/vim-test'
  Plug 'jeetsukumaran/vim-pythonsense'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/gv.vim', {'on': 'GV'}
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'liuchengxu/vista.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'm-pilia/vim-pkgbuild'
  Plug 'machakann/vim-swap'
  Plug 'majutsushi/tagbar'
  Plug 'mhinz/vim-startify'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'moll/vim-bbye'
  Plug 'neoclide/coc-neco'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'oguzbilgic/vim-gdiff', {'on': ['Gdiff', 'Gdiffsplit']}
  Plug 'rbgrouleff/bclose.vim'
  Plug 'rbong/vim-flog'
  Plug 'rhysd/vim-grammarous', {'for': ['markdown', 'tex']}
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  Plug 'scrooloose/nerdcommenter'
  Plug 'sheerun/vim-polyglot'
  Plug 'simnalamburt/vim-mundo'
  Plug 'skywind3000/vim-quickui'
  Plug 'soywod/iris.vim'
  Plug 'tmsvg/pear-tree'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-liquid'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'uiiaoo/java-syntax.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/BufOnly.vim'
  Plug 'vim-utils/vim-all'
  Plug 'wellle/targets.vim'
  Plug 'wellle/visual-split.vim'
call plug#end()

func! s:add_to_rtp(p, back)
  let dir = $HOME . "/" . a:p
  if ! isdirectory(dir)
    echoe dir . " not found"
  endif
  if a:back
    let &rtp .= "," . dir
  else
    let &rtp = dir . "," . &rtp
  endif
endfunc

" call <SID>add_to_rtp("gitclones/VirkSpaces", v:true)
" call <SID>add_to_rtp("gitclones/1989.vim", v:true)
" call <SID>add_to_rtp("gitclones/at-zed-vim", v:true)
" call <SID>add_to_rtp("gitclones/pic-vim", v:true)
" call <SID>add_to_rtp("gitclones/hex-this-vim", v:true)
" call <SID>add_to_rtp("gitclones/flocho", v:true)
" call <SID>add_to_rtp("gitclones/bolorscheme", v:true)
" call <SID>add_to_rtp("gitclones/spelunker.vim", v:true)
" call <SID>add_to_rtp("gitclones/wal.vim", v:true)
