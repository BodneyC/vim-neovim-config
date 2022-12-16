local util = require('utl.util')

--- Impatient
-- util.safe_require('impatient')

--- Packer

local install_path = vim.fn.stdpath('data') ..
    '/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer...'
end

vim.cmd('packadd packer.nvim')
-- util.safe_require('packer_compiled')

local packer = util.safe_require('packer')
if not packer then return end

packer.init({
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
  },
})

packer.startup(function(use)

  use { 'lewis6991/impatient.nvim' }
  use { 'wbthomason/packer.nvim', opt = true }

  --- Lsp
  use { 'tami5/lspsaga.nvim' }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    },
  }
  use { 'neovim/nvim-lspconfig' }
  use { 'nvim-lua/lsp-status.nvim' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-packer.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim', run = { 'make' } },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- One to track
      { 'nvim-telescope/telescope-rg.nvim' },
    },
  }
  use { 'onsails/lspkind-nvim' }
  use { 'simrat39/symbols-outline.nvim' }
  use { 'ray-x/lsp_signature.nvim' }

  --- DAP
  use { 'mfussenegger/nvim-dap' }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use { 'rcarriga/nvim-dap-ui' }
  use { 'Pocco81/dap-buddy.nvim', branch = 'dev' }
  use { 'jbyuki/one-small-step-for-vimkind' }
  use { 'nvim-telescope/telescope-dap.nvim' }
  use { 'mfussenegger/nvim-dap-python' }
  use { 'mxsdev/nvim-dap-vscode-js', requires = { 'mfussenegger/nvim-dap' } }

  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }

  --- Added functionality
  use { 'BodneyC/hex-this-vim', cmd = 'HexThis' }
  use { 'windwp/nvim-spectre' }
  use { 'knubie/vim-kitty-navigator' }
  use { 'windwp/nvim-ts-autotag' } -- Setup in ts.lua
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }
  use { 'nvim-treesitter/nvim-treesitter-refactor' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'vigoux/treesitter-context.nvim' }
  use { 'RRethy/nvim-treesitter-textsubjects' }
  use { 'RRethy/nvim-treesitter-endwise' }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'vim-test/vim-test' }

  use {
    'rcarriga/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'rcarriga/neotest-vim-test',
      'rcarriga/neotest-plenary',
      'rcarriga/neotest-python',
      'haydenmeade/neotest-jest',
    },
  }

  --- QOL
  use { 'farmergreg/vim-lastplace' }
  use { 'folke/which-key.nvim' }
  use { 'folke/todo-comments.nvim' }
  use { 'bronson/vim-visual-star-search' }
  use { 'dominikduda/vim_current_word' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/vim-vsnip-integ' }
  -- use {'jiangmiao/auto-pairs'}
  use { 'windwp/nvim-autopairs' }
  use { 'junegunn/vim-easy-align' }
  use { 'kamykn/spelunker.vim' }
  use { 'kwkarlwang/bufresize.nvim' }
  use { 'luukvbaal/stabilize.nvim' }
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'mhartington/formatter.nvim' }
  use { 'machakann/vim-swap' }
  use { 'tpope/vim-commentary' }
  use { 'zirrostig/vim-schlepp' }

  --- Vim internal wrappers
  use({ 'https://github.com/nat-418/boole.nvim' })
  use { 'andymass/vim-matchup' } -- % on `end`s
  use { 'moll/vim-bbye' } -- <leader>bd
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }

  use { 'tpope/vim-unimpaired' }
  use { 'tweekmonster/startuptime.vim' }
  use { 'vim-utils/vim-all' } -- a<CR>

  --- Prettiness
  use { 'sainnhe/everforest' }
  use { 'KabbAmine/vCoolor.vim', cmd = 'VCoolor' }
  use { 'lukas-reineke/indent-blankline.nvim' }
  use { 'dstein64/nvim-scrollview' }
  use { 'junegunn/goyo.vim', cmd = 'Goyo' }
  use { 'junegunn/limelight.vim', cmd = 'Limelight' }
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    tag = '*',
  }
  use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'wellle/targets.vim' }
  use { 'wellle/visual-split.vim' }

  --- SDL
  use { 'rmagatti/auto-session' }
  use { 'rmagatti/session-lens', requires = { 'nvim-telescope/telescope.nvim' } }
  -- use {'BodneyC/VirkSpaces'}
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'f-person/git-blame.nvim' }
  use { 'oguzbilgic/vim-gdiff', cmd = { 'Gdiff', 'Gdiffsplit' } }
  use { 'tpope/vim-fugitive' }

  --- Language support
  use { 'Olical/conjure' }
  use { 'towolf/vim-helm' }
  use { 'hashivim/vim-terraform', ft = 'terraform' }
  use { 'BodneyC/sood-vim', ft = 'sood' }
  use { 'BodneyC/knit-vim', ft = 'knit' }
  use { 'justinmk/vim-syntax-extra', ft = { 'lex', 'yacc' } }
  -- use {'leafgarland/typescript-vim'}
  use { 'jose-elias-alvarez/typescript.nvim' }
  use { 'm-pilia/vim-pkgbuild', ft = 'pkgbuild' }
  use { 'michaeljsmith/vim-indent-object' }
  use { 'plasticboy/vim-markdown', ft = 'markdown' }
  use { -- bullet points in MD
    'dkarter/bullets.vim',
    ft = 'markdown',
  }
  use { 'simrat39/rust-tools.nvim' }

  --- Local
  ---- Mine
  -- use {'~/gitclones/VirkSpaces'}
  -- use {'~/gitclones/bolorscheme'}
  -- use {'~/Documents/knit-vim'}
  ---- Others
  -- use {'~/gitclones/barbar.nvim', branch = 'master', requires = {{'romgrk/lib.kom'}}}
  -- use {'~/gitclones/git-blame.nvim'}

  use { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' }

  -- load plugins from the various plugins lists
  if PACKER_BOOTSTRAP then packer.sync() end

end)

if PACKER_BOOTSTRAP then
  local grp = vim.api.nvim_create_augroup('OnPackerComplete', { clear = true })
  vim.api.nvim_create_autocmd('User PackerComplete',
    { callback = require 'cfg.plugins', group = grp })
else
  require 'cfg.plugins'
end
