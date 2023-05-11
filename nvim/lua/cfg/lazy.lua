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
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'onsails/lspkind-nvim',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'ray-x/lsp_signature.nvim',

      -- Snippets
      { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
      -- Snippet Collection (Optional)
      -- 'rafamadriz/friendly-snippets',
    },
  },
  {
    'nvimdev/lspsaga.nvim',
    config = require('cfg.plugins.lspsaga'),
  },

  -- 'nvim-lua/lsp-status.nvim',
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
  'simrat39/symbols-outline.nvim',
  -- { name = 'lsp_lines', url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function() require('cfg.plugins.null_ls') end,
  },

  --- DAP
  'mfussenegger/nvim-dap',
  'theHamsta/nvim-dap-virtual-text',
  'rcarriga/nvim-dap-ui',
  { 'Pocco81/dap-buddy.nvim',    branch = 'dev' },
  'jbyuki/one-small-step-for-vimkind',
  'nvim-telescope/telescope-dap.nvim',
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end,
  },
  { 'mxsdev/nvim-dap-vscode-js', dependencies = { 'mfussenegger/nvim-dap' } },

  --- Added functionality
  { 'BodneyC/hex-this-vim',      cmd = 'HexThis' },
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
  { 'folke/todo-comments.nvim',   config = require('cfg.plugins.todo-comments') },
  'bronson/vim-visual-star-search',
  'dominikduda/vim_current_word',
  -- 'jiangmiao/auto-pairs',
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        break_undo = false,
        map_cr = true,
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
        filetype = { 'help', 'list', 'Trouble', 'NvimTree', 'Outline', 'neo-tree' },
        buftype = { 'terminal', 'quickfix', 'loclist' },
      },
    },
  },
  { 'folke/trouble.nvim',        dependencies = 'kyazdani42/nvim-web-devicons' },
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
  'moll/vim-bbye',        -- <leader>bd
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'mbbill/undotree',
  'tpope/vim-unimpaired',
  'tweekmonster/startuptime.vim',
  'vim-utils/vim-all', -- a<CR>
  {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "edluffy/hologram.nvim" },
    config = {
      row = 8,
      col = 0,
      default_pet = "cat",
      default_style = "light_gray",
    }
  },
  {
    "folke/noice.nvim",
    config = require('cfg.plugins.noice'),
    dependencies = { "MunifTanjim/nui.nvim" }
  },

  --- Prettiness
  {
    'sainnhe/everforest',
    lazy = false,
    -- config = function() require('mod.colors').everforst() end,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    config = function() require('mod.colors').nightfox() end,
  },
  { 'KabbAmine/vCoolor.vim',     cmd = 'VCoolor' },
  'voldikss/vim-floaterm',
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
        'neo-tree',
        '',
      },
    },
  },
  'dstein64/nvim-scrollview',
  { 'junegunn/goyo.vim',         cmd = 'Goyo' },
  { 'junegunn/limelight.vim',    cmd = 'Limelight' },
  -- {
  --   'akinsho/bufferline.nvim',
  --   dependencies = 'kyazdani42/nvim-web-devicons',
  --   version = '^v3',
  --   config = require('cfg.plugins.bufferline'),
  -- },
  { 'rrethy/vim-hexokinase',     build = 'make hexokinase' },
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
  -- 'kyazdani42/nvim-tree.lua',
  {
    'nvim-neo-tree/neo-tree.nvim',
    -- branch = 'v2.x',
    -- config = function()
    --   local config = require('cfg.plugins.neo-tree')
    --   require('neo-tree').setup(config)
    -- end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      'kyazdani42/nvim-web-devicons',
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        tag = "v1.*",
        config = {
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', "quickfix" },
            },
          },
          other_win_hl_color = '#e35e4f',
        }
      }
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = require('cfg.plugins.gitsigns'),
  },
  'f-person/git-blame.nvim',
  { 'oguzbilgic/vim-gdiff',      cmd = { 'Gdiff', 'Gdiffsplit' } },
  'tpope/vim-fugitive',

  --- Language support
  -- 'Olical/conjure',
  'towolf/vim-helm',
  { 'hashivim/vim-terraform',    ft = 'terraform' },
  { 'BodneyC/sood-vim',          ft = 'sood' },
  { 'BodneyC/knit-vim',          ft = 'knit' },
  { 'justinmk/vim-syntax-extra', ft = { 'lex', 'yacc' } },
  -- 'leafgarland/typescript-vim',
  'jose-elias-alvarez/typescript.nvim',
  { 'm-pilia/vim-pkgbuild',    ft = 'pkgbuild' },
  'michaeljsmith/vim-indent-object',
  { 'plasticboy/vim-markdown', ft = 'markdown' },
  {
    -- bullet points in MD
    'dkarter/bullets.vim',
    ft = 'markdown',
  },
  'simrat39/rust-tools.nvim',
  {
    'barrett-ruth/import-cost.nvim',
    build = 'sh install.sh npm',
    config = { highlight = 'Comment' },
  },
  {
    'rmagatti/gx-extended.nvim',
    config = {}
  },

  --   -- Clojure
  --   {
  --     'tpope/vim-sexp-mappings-for-regular-people',
  --     ft = { 'clojure' },
  --     dependencies = {
  --       'guns/vim-sexp',
  --       'tpope/vim-repeat',
  --       'tpope/vim-surround',
  --     },
  --   },
  --   {
  --     'guns/vim-sexp',
  --     ft = { 'clojure' },
  --     config = function()
  --       vim.g.sexp_mappings = require('cfg.plugins.sexp').disabled_sexp_mappings
  --     end,
  --   },
  --   {
  --     'Olical/conjure',
  --     ft = { 'clojure' },
  --     config = function()
  --       vim.g["conjure#mapping#prefix"] = ','
  --     end,
  --   },
  --   'PaterJason/cmp-conjure',
  --   {
  --     'clojure-vim/vim-jack-in',
  --     ft = { 'clojure' },
  --     dependencies = { 'clojure-vim/vim-jack-in', 'tpope/vim-dispatch', 'radenling/vim-dispatch-neovim' }
  --   },

})
