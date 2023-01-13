local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  --- Lsp
  'tami5/lspsaga.nvim',
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
  },
  'neovim/nvim-lspconfig',
  'nvim-lua/lsp-status.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-packer.nvim',
      { 'nvim-telescope/telescope-fzy-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
      -- One to track
      'nvim-telescope/telescope-rg.nvim',
    },
  },
  'onsails/lspkind-nvim',
  'simrat39/symbols-outline.nvim',
  'ray-x/lsp_signature.nvim',

  --- DAP
  'mfussenegger/nvim-dap',
  'theHamsta/nvim-dap-virtual-text',
  'rcarriga/nvim-dap-ui',
  { 'Pocco81/dap-buddy.nvim', branch = 'dev' },
  'jbyuki/one-small-step-for-vimkind',
  'nvim-telescope/telescope-dap.nvim',
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end,
  },
  { 'mxsdev/nvim-dap-vscode-js', dependencies = { 'mfussenegger/nvim-dap' } },

  { 'williamboman/mason.nvim', config = require('cfg.plugins.mason') },
  'williamboman/mason-lspconfig.nvim',

  --- Added functionality
  { 'BodneyC/hex-this-vim', cmd = 'HexThis' },
  'windwp/nvim-spectre',
  'knubie/vim-kitty-navigator',
  'windwp/nvim-ts-autotag', -- Setup in ts.lua
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require('nvim-treesitter.configs').setup(
        require('cfg.plugins.tree-sitter'))
    end,
  },
  'nvim-treesitter/nvim-treesitter-refactor',
  'nvim-treesitter/nvim-treesitter-textobjects',
  { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
  'JoosepAlviste/nvim-ts-context-commentstring',
  'vigoux/treesitter-context.nvim',
  'RRethy/nvim-treesitter-textsubjects',
  'RRethy/nvim-treesitter-endwise',
  'p00f/nvim-ts-rainbow',
  'vim-test/vim-test',

  'rcarriga/neotest-vim-test',
  'rcarriga/neotest-plenary',
  'rcarriga/neotest-python',
  'haydenmeade/neotest-jest',
  {
    'rcarriga/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
    },
  },

  --- QOL
  'farmergreg/vim-lastplace',
  {
    'folke/which-key.nvim',
    config = {
      triggers_blacklist = {
        n = { '"' }, -- slow for "+
      },
    },
  },
  { 'folke/todo-comments.nvim', config = require('cfg.plugins.todo-comments') },
  'bronson/vim-visual-star-search',
  'dominikduda/vim_current_word',
  'hrsh7th/vim-vsnip',
  'hrsh7th/vim-vsnip-integ',
  -- 'jiangmiao/auto-pairs',
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        break_undo = false,
        map_cr = false,
        map_bs = false,
        fast_wrap = { map = '<M-w>' },
      }
      vim.keymap.set('i', '∑', [[<esc>l<cmd>lua require('nvim-autopairs.fastwrap').show()<cr>]], { silent = true })
    end
  },
  'junegunn/vim-easy-align',
  'kamykn/spelunker.vim',
  { 'kwkarlwang/bufresize.nvim', config = true },
  {
    'luukvbaal/stabilize.nvim',
    config = {
      ignore = {
        filetype = { 'help', 'list', 'Trouble', 'NvimTree', 'Outline' },
        buftype = { 'terminal', 'quickfix', 'loclist' },
      },
    },
  },
  { 'folke/trouble.nvim', dependencies = 'kyazdani42/nvim-web-devicons' },
  'mhartington/formatter.nvim',
  'machakann/vim-swap',
  'tpope/vim-commentary',
  'zirrostig/vim-schlepp',

  --- Vim internal wrappers
  {
    'nat-418/boole.nvim',
    config = { mappings = { increment = '<C-a>', decrement = '<C-x>' } },
  },
  'andymass/vim-matchup', -- % on `end`s
  'moll/vim-bbye', -- <leader>bd
  'tpope/vim-repeat',
  'tpope/vim-surround',

  'tpope/vim-unimpaired',
  'tweekmonster/startuptime.vim',
  'vim-utils/vim-all', -- a<CR>

  --- Prettiness
  {
    'sainnhe/everforest',
    lazy = false,
    config = function() require('mod.everforest').config() end,
  },
  { 'KabbAmine/vCoolor.vim', cmd = 'VCoolor' },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = {
      char = '│',
      show_first_indent_level = true,
      -- show_end_of_line = true,
      filetype_exclude = {
        'packer',
        'floaterm',
        'help',
        'Outline',
        'NvimTree',
        '',
      },
    },
  },
  'dstein64/nvim-scrollview',
  { 'junegunn/goyo.vim', cmd = 'Goyo' },
  { 'junegunn/limelight.vim', cmd = 'Limelight' },
  {
    'akinsho/bufferline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    version = '^v3',
    config = require('cfg.plugins.bufferline'),
  },
  { 'rrethy/vim-hexokinase', build = 'make hexokinase' },
  { 'nvim-lualine/lualine.nvim', config = require('cfg.plugins.lualine') },
  'wellle/targets.vim',
  'wellle/visual-split.vim',

  --- SDL
  {
    'rmagatti/auto-session',
    config = { log_level = 'warn', auto_session_suppress_dirs = { '~/' } },
  },
  {
    'rmagatti/session-lens',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = { theme_conf = { border = false } },
  },
  -- {'BodneyC/VirkSpaces'},
  'kyazdani42/nvim-tree.lua',
  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = require('cfg.plugins.gitsigns'),
  },
  'f-person/git-blame.nvim',
  { 'oguzbilgic/vim-gdiff', cmd = { 'Gdiff', 'Gdiffsplit' } },
  'tpope/vim-fugitive',

  --- Language support
  -- 'Olical/conjure',
  'towolf/vim-helm',
  { 'hashivim/vim-terraform', ft = 'terraform' },
  { 'BodneyC/sood-vim', ft = 'sood' },
  { 'BodneyC/knit-vim', ft = 'knit' },
  { 'justinmk/vim-syntax-extra', ft = { 'lex', 'yacc' } },
  -- 'leafgarland/typescript-vim',
  'jose-elias-alvarez/typescript.nvim',
  { 'm-pilia/vim-pkgbuild', ft = 'pkgbuild' },
  'michaeljsmith/vim-indent-object',
  { 'plasticboy/vim-markdown', ft = 'markdown' },
  { -- bullet points in MD
    'dkarter/bullets.vim',
    ft = 'markdown',
  },
  'simrat39/rust-tools.nvim',
  {
    'barrett-ruth/import-cost.nvim',
    build = 'sh install.sh npm',
    config = { highlight = 'Comment' },
  },

  { name = 'lsp_lines', url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },

})
