call plug#begin('~/.local/share/nvim/plugged')
  Plug 'Shougo/neco-vim'
  Plug 'Yggdroot/indentLine'
  Plug 'alvan/vim-closetag', {'for': ['html', 'xml']}
  Plug 'andymass/vim-matchup'
  Plug 'benmills/vimux'
  Plug 'bodneyc/1989.vim', { 'branch': 'personal-touches' }
  Plug 'bodneyc/Comrade'
  Plug 'bronson/vim-visual-star-search'
  Plug 'brooth/far.vim'
  Plug 'chrisbra/recover.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'https://gitlab.com/BodneyC/At-Zed-vim',   { 'branch': 'master' }
  Plug 'https://gitlab.com/BodneyC/VirkSpaces',   { 'branch': 'master' }
  Plug 'https://gitlab.com/BodneyC/hex-this-vim', { 'branch': 'master' }
  Plug 'https://gitlab.com/BodneyC/pic-vim',      { 'branch': 'master' }
  Plug 'https://gitlab.com/BodneyC/togool.vim',   { 'branch': 'master' }
  Plug 'itchyny/lightline.vim'
  Plug 'janko/vim-test'
  Plug 'jeetsukumaran/vim-pythonsense'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/gv.vim', {'on': 'GV'}
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'liuchengxu/vista.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'mhinz/vim-startify'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'moll/vim-bbye'
  Plug 'neoclide/coc-neco'
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'oguzbilgic/vim-gdiff', {'on': ['Gdiff', 'Gdiffsplit']}
  Plug 'rbong/vim-flog'
  Plug 'rhysd/vim-grammarous', {'for': ['markdown', 'tex']}
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
  Plug 'vim-utils/vim-all'
  Plug 'wellle/targets.vim'
  Plug 'wellle/visual-split.vim'
  Plug 'yuttie/comfortable-motion.vim'
call plug#end()

function! s:add_to_rtp(p, back)
  let l:dir = $HOME . "/" . a:p
  if ! isdirectory(l:dir)
    echoe l:dir . " not found"
  endif
  if a:back
    let &rtp .= "," . l:dir
  else
    let &rtp = l:dir . "," . &rtp
  endif
endfunction

" call <SID>add_to_rtp("gitclones/virkspaces", v:true)
" call <SID>add_to_rtp("gitclones/1989.vim", v:true)
" call <SID>add_to_rtp("gitclones/at-zed-vim", v:true)
" call <SID>add_to_rtp("gitclones/pic-vim", v:true)
" call <SID>add_to_rtp("gitclones/hex-this-vim", v:true)
" call <SID>add_to_rtp("gitclones/Comrade", v:true)
