set nocompatible
filetype off

if empty($TERMTHEME)
  echoe "$TERMTHEME not set, defaulting to 'dark'"
  let $TERMTHEME = 'dark'
endif

let g:python_host_prog = systemlist('command -v python2')[0]
let g:python3_host_prog = systemlist('command -v python3')[0]

let g:polyglot_disabled = ['autoindent']

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'aca/completion-tabnine', { 'do': './install.sh' }
  Plug 'airblade/vim-gitgutter'
  Plug 'alvan/vim-closetag', { 'for': ['html', 'xml', 'markdown'] }
  Plug 'andymass/vim-matchup'
  Plug 'bakpakin/fennel.vim'
  Plug 'benmills/vimux'
  Plug 'BodneyC/At-Zed-vim',    { 'branch': 'master' }
  Plug 'BodneyC/bolorscheme',   { 'branch': 'master' }
  Plug 'bodneyc/Comrade',       { 'branch': 'master' }
  Plug 'BodneyC/flocho',        { 'branch': 'master' }
  Plug 'BodneyC/hex-this-vim',  { 'branch': 'master' }
  Plug 'BodneyC/pic-vim',       { 'branch': 'master' }
  Plug 'bodneyc/spelunker.vim', { 'branch': 'feature/quickui_support' }
  Plug 'BodneyC/togool.vim',    { 'branch': 'master' }
  Plug 'BodneyC/VirkSpaces',    { 'branch': 'master' }
  Plug 'bronson/vim-visual-star-search'
  Plug 'brooth/far.vim'
  Plug 'chrisbra/recover.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'haorenW1025/completion-nvim'
  Plug 'honza/vim-snippets'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn' }
  Plug 'janko/vim-test'
  Plug 'jeetsukumaran/vim-pythonsense'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/gv.vim', { 'on': 'GV' }
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'leafgarland/typescript-vim'
  Plug 'liuchengxu/vista.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'machakann/vim-swap'
  Plug 'majutsushi/tagbar'
  Plug 'mhinz/vim-startify'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'moll/vim-bbye'
  Plug 'm-pilia/vim-pkgbuild'
  Plug 'neovim/nvim-lsp'
  Plug 'nicwest/vim-http'
  Plug 'nvim-lua/diagnostic-nvim'
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'nvim-treesitter/completion-treesitter'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'oguzbilgic/vim-gdiff', { 'on': ['Gdiff', 'Gdiffsplit'] }
  Plug 'Olical/aniseed', { 'tag': 'v3.6.2' }
  Plug 'Olical/conjure', { 'tag': 'v4.3.1' }
  Plug 'rbgrouleff/bclose.vim'
  Plug 'rbong/vim-flog'
  Plug 'rhysd/clever-f.vim'
  Plug 'rhysd/vim-grammarous', { 'for': ['markdown', 'tex'] }
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  Plug 'scrooloose/nerdcommenter'
  Plug 'sheerun/vim-polyglot'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neco-vim'
  Plug 'simnalamburt/vim-mundo'
  Plug 'skywind3000/vim-quickui'
  Plug 'sodapopcan/vim-twiggy'
  Plug 'soywod/iris.vim'
  Plug 'steelsojka/completion-buffers'
  " Plug 'tadaa/vimade'
  Plug 'tmsvg/pear-tree'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-liquid'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'uiiaoo/java-syntax.vim'
  Plug 'vigoux/treesitter-context.nvim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/BufOnly.vim'
  Plug 'vim-utils/vim-all'
  Plug 'wellle/targets.vim'
  Plug 'wellle/visual-split.vim'
  Plug 'Yggdroot/indentLine'
  Plug 'yuttie/comfortable-motion.vim'
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

lua require'nvim-init'
