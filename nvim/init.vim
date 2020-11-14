set nocompatible
filetype off

if empty($TERMTHEME)
  echoe "$TERMTHEME not set, defaulting to 'dark'"
  let $TERMTHEME = 'dark'
endif

try
  let g:python_host_prog = systemlist('command -v python2')[0]
  let g:python3_host_prog = systemlist('command -v python3')[0]
catch /E\(15\|684\).*/
  echo "Python (2 or 3) not found on PATH"
endtry

let g:polyglot_disabled = ['autoindent']

call plug#begin('~/.local/share/nvim/plugged')

  Plug 'Olical/conjure', {'tag': 'v4.8.0'}
  Plug 'amdt/vim-niji'
  Plug 'gregsexton/gitv', {'on': ['Gitv']}
  Plug 'guns/vim-sexp'
  Plug 'itchyny/calendar.vim'
  Plug 'tpope/vim-sexp-mappings-for-regular-people'

  Plug 'BodneyC/At-Zed-vim',    { 'branch': 'master' }
  Plug 'BodneyC/VirkSpaces',    { 'branch': 'master' }
  " Plug 'BodneyC/barbar.nvim',   { 'branch': 'playing-around' }
  Plug 'BodneyC/bolorscheme',   { 'branch': 'master' }
  Plug 'BodneyC/flocho',        { 'branch': 'master' }
  Plug 'BodneyC/hex-this-vim',  { 'branch': 'master' }
  Plug 'BodneyC/pic-vim',       { 'branch': 'master' }
  Plug 'BodneyC/sood-vim',      { 'branch': 'master' }
  Plug 'BodneyC/togool.vim',    { 'branch': 'master' }
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Yggdroot/indentLine'
  Plug 'airblade/vim-gitgutter'
  Plug 'alvan/vim-closetag', { 'for': ['html', 'xml'] }
  Plug 'andymass/vim-matchup'
  Plug 'benmills/vimux'
  Plug 'bodneyc/Comrade',       { 'branch': 'master' }
  Plug 'bodneyc/spelunker.vim', { 'branch': 'feature/quickui_support' }
  Plug 'bronson/vim-visual-star-search'
  Plug 'brooth/far.vim'
  Plug 'chrisbra/recover.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'haorenW1025/completion-nvim'
  Plug 'honza/vim-snippets'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
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
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'leafgarland/typescript-vim'
  Plug 'liuchengxu/vista.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'lukas-reineke/format.nvim'
  Plug 'm-pilia/vim-pkgbuild'
  Plug 'machakann/vim-swap'
  Plug 'majutsushi/tagbar'
  Plug 'mhinz/vim-startify'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'moll/vim-bbye'
  Plug 'neovim/nvim-lsp'
  Plug 'nicwest/vim-http'
  " Plug 'nvim-lua/diagnostic-nvim'
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'nvim-treesitter/completion-treesitter'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/nvim-treesitter-refactor'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/playground'
  Plug 'oguzbilgic/vim-gdiff', { 'on': ['Gdiff', 'Gdiffsplit'] }
  Plug 'radenling/vim-dispatch-neovim'
  Plug 'rbong/vim-flog'
  Plug 'rhysd/clever-f.vim'
  Plug 'rhysd/vim-grammarous', { 'for': ['markdown', 'tex'] }
  Plug 'romgrk/barbar.nvim'
  Plug 'romgrk/lib.kom'
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  Plug 'scrooloose/nerdcommenter'
  Plug 'sheerun/vim-polyglot'
  Plug 'simnalamburt/vim-mundo'
  Plug 'sodapopcan/vim-twiggy'
  Plug 'steelsojka/completion-buffers'
  Plug 'tmsvg/pear-tree'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'uiiaoo/java-syntax.vim'
  Plug 'vigoux/treesitter-context.nvim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-scripts/BufOnly.vim'
  Plug 'vim-utils/vim-all'
  Plug 'wellle/targets.vim'
  Plug 'wellle/visual-split.vim'

call plug#end()

func! s:add_to_rtp(p, back)
  let dir = $HOME . "/" . a:p
  if ! isdirectory(dir)
    echom "add_to_rtp '" . dir . "' not found"
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
" call <SID>add_to_rtp("Documents/sood-vim", v:true)
" call <SID>add_to_rtp("gitclones/barbar.nvim", v:true)
" call <SID>add_to_rtp("gitclones/nvim-treesitter", v:true)
" call <SID>add_to_rtp("gitclones/spelunker.vim", v:true)
" call <SID>add_to_rtp("gitclones/wal.vim", v:true)

lua require'nvim-init'
