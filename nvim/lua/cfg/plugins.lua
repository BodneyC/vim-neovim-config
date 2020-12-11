local vim = vim

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd('packadd packer.nvim')

local packer = require 'packer'

return packer.startup(function()
  local use = packer.use

  use {'wbthomason/packer.nvim', opt = true}

  use {'BodneyC/At-Zed-vim', branch = 'master'}
  use {'BodneyC/VirkSpaces', branch = 'master'}
  -- use {'BodneyC/barbar.nvim',   branch = 'playing-around' }
  use {'BodneyC/bolorscheme', branch = 'master'}
  use {'BodneyC/flocho', branch = 'master'}
  use {'BodneyC/hex-this-vim', branch = 'master'}
  use {'BodneyC/pic-vim', branch = 'master'}
  use {'BodneyC/sood-vim', branch = 'master'}
  use {'BodneyC/togool.vim', branch = 'master'}
  use {'KabbAmine/vCoolor.vim'}
  use {'Shougo/defx.nvim', run = ':UpdateRemotePlugins'}
  use {'Yggdroot/indentLine'}
  use {'airblade/vim-gitgutter'}
  use {'alvan/vim-closetag', ft = {'html', 'xml'}}
  use {'amdt/vim-niji'}
  use {'andymass/vim-matchup'}
  use {'benmills/vimux'}
  use {'bodneyc/Comrade', branch = 'master'}
  use {'bronson/vim-visual-star-search'}
  use {'brooth/far.vim'}
  use {'chrisbra/recover.vim'}
  use {'christoomey/vim-tmux-navigator'}
  use {'dominikduda/vim_current_word'}
  use {'drmingdrmer/vim-indent-lua'}
  use {'gregsexton/gitv', cmd = 'Gitv', requires = {'tpope/vim-fugitive'}}
  -- use {'guns/vim-sexp'}
  use {'haorenW1025/completion-nvim'}
  use {'honza/vim-snippets'}
  use {'hrsh7th/vim-vsnip'}
  use {'hrsh7th/vim-vsnip-integ'}
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn', cmd = 'MarkdownPreview'}
  use {'itchyny/calendar.vim', cmd = 'Cal'}
  use {'janko/vim-test', cmd = 'TestFile'}
  use {'jeetsukumaran/vim-pythonsense', ft = 'python'}
  use {'jiangmiao/auto-pairs'}
  use {'junegunn/fzf', run = 'cd ~/.fzf && ./install --all'}
  use {'yuki-ycino/fzf-preview.vim', branch = 'release', run = ':FzfPreviewInstall' }
  use {'junegunn/fzf.vim'}
  use {'junegunn/goyo.vim', cmd = 'Goyo'}
  use {'junegunn/gv.vim', cmd = 'GV'}
  use {'junegunn/limelight.vim', cmd = 'Limelight'}
  use {'junegunn/vim-easy-align'}
  use {'justinmk/vim-syntax-extra'}
  use {'kamykn/spelunker.vim'}
  use {'knubie/vim-kitty-navigator'}
  use {'kristijanhusak/defx-git'}
  use {'kristijanhusak/defx-icons'}
  use {'kyazdani42/nvim-web-devicons'}
  use {
    'leafgarland/typescript-vim',
    ft = {'tsx', 'typescript', 'typescriptreact', 'typescriptcommon'},
  }
  use {'liuchengxu/vista.vim', cmd = 'Vista'}
  use {'ludovicchabant/vim-gutentags'}
  use {'lukas-reineke/format.nvim'}
  use {'m-pilia/vim-pkgbuild', ft = 'pkgbuild'}
  use {'machakann/vim-swap'}
  use {'majutsushi/tagbar', cmd = 'Tagbar'}
  use {'mhinz/vim-startify'}
  use {'michaeljsmith/vim-indent-object'}
  use {'moll/vim-bbye'}
  use {'neovim/nvim-lspconfig'}
  use {'nicwest/vim-http', cmd = 'Http'}
  use {'nvim-lua/lsp-status.nvim'}
  use {'nvim-treesitter/completion-treesitter'}
  use {'nvim-treesitter/nvim-treesitter'}
  use {'nvim-treesitter/nvim-treesitter-refactor'}
  use {'nvim-treesitter/nvim-treesitter-textobjects'}
  use {'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle'}
  use {'oguzbilgic/vim-gdiff', cmd = {'Gdiff', 'Gdiffsplit'}}
  use {'radenling/vim-dispatch-neovim'}
  use {'rbong/vim-flog', cmd = 'Flog'}
  use {'rhysd/clever-f.vim'}
  use {'rhysd/vim-grammarous', ft = {'markdown', 'tex'}}
  use {'romgrk/barbar.nvim'}
  use {'romgrk/lib.kom'}
  use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
  use {'scrooloose/nerdcommenter'}
  use {'sheerun/vim-polyglot'}
  use {'simnalamburt/vim-mundo'}
  use {'sodapopcan/vim-twiggy', cmd = 'Twiggy'}
  use {'steelsojka/completion-buffers'}
  use {'tpope/vim-dispatch'}
  use {'tpope/vim-repeat'}
  -- use {'tpope/vim-sexp-mappings-for-regular-people'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-unimpaired'}
  use {'uiiaoo/java-syntax.vim'}
  use {'vigoux/treesitter-context.nvim'}
  use {'vim-airline/vim-airline'}
  use {'vim-scripts/BufOnly.vim'}
  use {'vim-utils/vim-all'}
  use {'wellle/targets.vim'}
  use {'wellle/visual-split.vim'}

end)
