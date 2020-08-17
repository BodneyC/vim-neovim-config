call plug#begin('~/.local/share/nvim/plugged')
  Plug 'neovim/nvim-lsp'
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'nvim-lua/diagnostic-nvim'
  Plug 'haorenW1025/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/completion-treesitter'
  Plug 'steelsojka/completion-buffers'
  Plug 'aca/completion-tabnine', { 'do': './install.sh' }
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'preservim/nerdtree'
  Plug 'scrooloose/nerdtree-project-plugin'

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
  Plug 'BodneyC/At-Zed-vim',   { 'branch': 'master' }
  Plug 'BodneyC/VirkSpaces',   { 'branch': 'master' }
  Plug 'BodneyC/hex-this-vim', { 'branch': 'master' }
  Plug 'BodneyC/pic-vim',      { 'branch': 'master' }
  Plug 'BodneyC/togool.vim',   { 'branch': 'master' }
  Plug 'BodneyC/flocho',       { 'branch': 'master' }
  " Plug 'BodneyC/bolorscheme',  { 'branch': 'master' }
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'janko/vim-test'
  Plug 'jeetsukumaran/vim-pythonsense'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/gv.vim', {'on': 'GV'}
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'leafgarland/typescript-vim'
  Plug 'liuchengxu/vista.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'machakann/vim-swap'
  Plug 'majutsushi/tagbar'
  Plug 'mhinz/vim-startify'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'moll/vim-bbye'
  Plug 'oguzbilgic/vim-gdiff', {'on': ['Gdiff', 'Gdiffsplit']}
  Plug 'rbgrouleff/bclose.vim'
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
  Plug 'vim-scripts/BufOnly.vim'
  Plug 'vim-utils/vim-all'
  Plug 'wellle/targets.vim'
  Plug 'wellle/visual-split.vim'
  Plug 'RRethy/vim-hexokinase'
  Plug 'dylanaraps/fff.vim'
  Plug 'metakirby5/codi.vim'
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
" call <SID>add_to_rtp("gitclones/flocho", v:true)
call <SID>add_to_rtp("gitclones/bolorscheme", v:true)
" call <SID>add_to_rtp("gitclones/spelunker.vim", v:true)
" call <SID>add_to_rtp("gitclones/wal.vim", v:true)
