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

  --- Lsp ---
  -- use {'haorenW1025/completion-nvim'}
  -- use {'steelsojka/completion-buffers'}
  use {'glepnir/lspsaga.nvim'}
  use {'hrsh7th/nvim-compe'}
  use {'mfussenegger/nvim-dap'}
  use {'mfussenegger/nvim-jdtls'}
  use {'neovim/nvim-lspconfig'}
  use {'nvim-lua/lsp-status.nvim'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-packer.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim', run = {'make'}},
    },
  }
  use {'onsails/lspkind-nvim'}

  --- Added functionality ---
  -- use {'benmills/vimux'}
  -- use {'nvim-treesitter/completion-treesitter'}
  use {'BodneyC/hex-this-vim', branch = 'master'}
  use {'BodneyC/pic-vim', branch = 'master'}
  use {'bodneyc/Comrade', branch = 'master'}
  -- use {'brooth/far.vim'}
  use {'windwp/nvim-spectre'}
  use {'christoomey/vim-tmux-navigator', cond = os.getenv('TMUX')}
  -- use {'glepnir/dashboard-nvim'}
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn', ft = 'markdown'}
  use {'itchyny/calendar.vim', cmd = 'Cal'}
  use {'knubie/vim-kitty-navigator', cond = os.getenv('KITTY_WINDOW_ID')}
  use {'nicwest/vim-http', cmd = 'Http'}
  use {'nvim-treesitter/nvim-treesitter'}
  use {'nvim-treesitter/nvim-treesitter-refactor'}
  use {'nvim-treesitter/nvim-treesitter-textobjects'}
  use {'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle'}
  use {'vigoux/treesitter-context.nvim'}

  --- QOL ---
  use {'bronson/vim-visual-star-search'}
  use {'dominikduda/vim_current_word'}
  use {'honza/vim-snippets'}
  use {'hrsh7th/vim-vsnip'}
  use {'hrsh7th/vim-vsnip-integ'}
  use {'jiangmiao/auto-pairs'}
  use {'junegunn/vim-easy-align'}
  use {'kamykn/spelunker.vim'}
  use {'liuchengxu/vista.vim', cmd = 'Vista'}
  use {'ludovicchabant/vim-gutentags'}
  use {'lukas-reineke/format.nvim'}
  use {'machakann/vim-swap'}
  use {'majutsushi/tagbar', cmd = 'Tagbar'}
  use {'rhysd/vim-grammarous', ft = {'markdown', 'tex'}}
  use {'scrooloose/nerdcommenter'}
  use {'simnalamburt/vim-mundo'}

  --- Vim internal wrappers ---
  -- use {'cohama/lexima.vim'}
  use {'BodneyC/At-Zed-vim', branch = 'master'}
  use {'BodneyC/flocho', branch = 'master'}
  use {'BodneyC/togool.vim', branch = 'master'}
  use {'alvan/vim-closetag', ft = {'html', 'xml', 'markdown'}}
  use {'andymass/vim-matchup'}
  use {'chrisbra/recover.vim'}
  use {'moll/vim-bbye'}
  use {'radenling/vim-dispatch-neovim'}
  use {'rhysd/clever-f.vim'}
  use {'tpope/vim-dispatch'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-unimpaired'}
  use {'vim-scripts/BufOnly.vim'}
  use {'vim-utils/vim-all'}

  --- Prettiness ---
  use {'BodneyC/bolorscheme', branch = 'master'}
  -- use {'arcticicestudio/nord-vim'}
  use {'KabbAmine/vCoolor.vim'}
  use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
  use {'amdt/vim-niji'}
  use {'dstein64/nvim-scrollview'}
  use {'junegunn/goyo.vim', cmd = 'Goyo'}
  use {'junegunn/limelight.vim', cmd = 'Limelight'}
  use {'kristijanhusak/defx-icons'}
  use {'kyazdani42/nvim-web-devicons'}
  use {'romgrk/barbar.nvim', requires = {{'romgrk/lib.kom'}}}
  use {'rktjmp/lush.nvim'}
  use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
  use {'vim-airline/vim-airline'}
  use {'wellle/targets.vim'}
  use {'wellle/visual-split.vim'}

  --- SDL ---
  use {'BodneyC/VirkSpaces', branch = 'master'}
  use {'Shougo/defx.nvim', run = ':UpdateRemotePlugins'}
  -- use {'airblade/vim-gitgutter'}
  use {'lewis6991/gitsigns.nvim'}
  use {'f-person/git-blame.nvim'}
  use {'gregsexton/gitv', cmd = 'Gitv', requires = {{'tpope/vim-fugitive'}}}
  use {'junegunn/gv.vim', cmd = 'GV'}
  use {'kristijanhusak/defx-git'}
  use {'oguzbilgic/vim-gdiff', cmd = {'Gdiff', 'Gdiffsplit'}}
  use {'rbong/vim-flog', cmd = 'Flog'}
  use {'sodapopcan/vim-twiggy', cmd = 'Twiggy'}

  --- Language support ---
  -- use {'jeetsukumaran/vim-pythonsense', ft = 'python'}
  -- use {'sheerun/vim-polyglot'}
  use {'BodneyC/sood-vim', branch = 'master'}
  use {'BodneyC/knit-vim', branch = 'master'}
  use {'drmingdrmer/vim-indent-lua'}
  use {'janko/vim-test', cmd = 'TestFile'}
  use {'justinmk/vim-syntax-extra'}
  use {'leafgarland/typescript-vim'}
  use {'m-pilia/vim-pkgbuild', ft = 'pkgbuild'}
  use {'mboughaba/i3config.vim'}
  use {'michaeljsmith/vim-indent-object'}
  use {'NoorWachid/VimVLanguage'}
  use {'plasticboy/vim-markdown'}
  use {'uiiaoo/java-syntax.vim'}

  --- Local ---
  -- use {'~/Documents/knit-vim'}
  -- use {'~/gitclones/VirkSpaces', branch = 'master'}
  -- use {'~/gitclones/barbar.nvim', branch = 'master', requires = {{'romgrk/lib.kom'}}}
  -- use {'~/gitclones/bolorscheme', branch = 'master'}

end)
