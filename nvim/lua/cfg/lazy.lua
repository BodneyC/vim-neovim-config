local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', --[[ latest stable release --]] lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  --[[------------------------------------------------------------------------
  LSP Setup and configuration
  --------------------------------------------------------------------------]]

  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

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
      { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' },
      -- Snippet Collection (Optional)
      'rafamadriz/friendly-snippets',
    },
  },

  { 'nvimdev/lspsaga.nvim',          opts = require('cfg.plugins.lspsaga') },
  { 'simrat39/symbols-outline.nvim', opts = {} },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-packer.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      -- One to track
      'nvim-telescope/telescope-rg.nvim',
      { 'nvim-telescope/telescope-fzy-native.nvim', build = 'make' },
      {
        'nvim-telescope/telescope-smart-history.nvim',
        dependencies = { 'kkharji/sqlite.lua' }
      }
    },
  },

  --[[------------------------------------------------------------------------
  Treesitter
  --------------------------------------------------------------------------]]
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      require('nvim-treesitter.configs').setup(require('cfg.plugins.treesitter'))
      require('ts_context_commentstring').setup(require('cfg.plugins.ts_context_comments'))
    end,
    dependencies = {
      'RRethy/nvim-treesitter-endwise',
      'RRethy/nvim-treesitter-textsubjects',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'vigoux/treesitter-context.nvim',
      'JoosepAlviste/nvim-ts-context-commentstring',
      { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
    }
  },

  --[[------------------------------------------------------------------------
  DAP Setup and configuration
  --------------------------------------------------------------------------]]

  'mfussenegger/nvim-dap',
  'theHamsta/nvim-dap-virtual-text',
  'rcarriga/nvim-dap-ui',
  'jbyuki/one-small-step-for-vimkind',
  'nvim-telescope/telescope-dap.nvim',

  { 'Pocco81/dap-buddy.nvim',    branch = 'dev' },
  { 'mxsdev/nvim-dap-vscode-js', dependencies = { 'mfussenegger/nvim-dap' } },

  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end,
  },

  --[[------------------------------------------------------------------------
  Extra Functionality
  --------------------------------------------------------------------------]]

  'HiPhish/rainbow-delimiters.nvim',
  'vim-test/vim-test',
  'windwp/nvim-spectre',
  'windwp/nvim-ts-autotag', -- Setup in ts.lua

  { 'BodneyC/hex-this-vim',    cmd = 'HexThis' },
  { 'numToStr/Navigator.nvim', opts = {} },

  {
    'rcarriga/neotest',
    config = function()
      require('neotest').setup(require('cfg.plugins.neotest'))
    end,
    dependencies = {
      "nvim-neotest/neotest-go",
      'antoinemadec/FixCursorHold.nvim',
      'haydenmeade/neotest-jest',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/neotest-plenary',
      'rcarriga/neotest-python',
      'rcarriga/neotest-vim-test',
      'rcasia/neotest-bash',
    },
  },

  --[[------------------------------------------------------------------------
  Quality of Life
  --------------------------------------------------------------------------]]

  'bronson/vim-visual-star-search',
  'dominikduda/vim_current_word',
  'farmergreg/vim-lastplace',
  'junegunn/vim-easy-align',
  'kamykn/spelunker.vim',
  'machakann/vim-swap',
  'mhartington/formatter.nvim',
  'tpope/vim-commentary',
  'zirrostig/vim-schlepp',
  -- 'jiangmiao/auto-pairs',

  { 'folke/todo-comments.nvim',  opts = require('cfg.plugins.todo-comments') },
  { 'folke/trouble.nvim',        dependencies = 'kyazdani42/nvim-web-devicons' },
  { 'folke/which-key.nvim',      opts = { triggers_blacklist = { n = { '"' } } } },
  { 'kwkarlwang/bufresize.nvim', config = true },

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
  {
    'luukvbaal/stabilize.nvim',
    opts = {
      ignore = {
        filetype = { 'help', 'list', 'Trouble', 'NvimTree', 'Outline', 'neo-tree' },
        buftype = { 'terminal', 'quickfix', 'loclist' },
      },
    },
  },
  {
    'rhysd/clever-f.vim',
    config = function()
      vim.g.clever_f_mark_char_color = 'ModeMsg'
      vim.cmd([[
        map ; <Plug>(clever-f-repeat-forward)
        map , <Plug>(clever-f-repeat-back)
        nmap <Esc> <Plug>(clever-f-reset)
      ]])
    end
  },

  --[[------------------------------------------------------------------------
  Wrappers Around Vim Internal-ish Stuff
  --------------------------------------------------------------------------]]

  'andymass/vim-matchup', -- % on `end`s
  'moll/vim-bbye',        -- <leader>bd
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'mbbill/undotree',
  'tpope/vim-unimpaired',
  'tweekmonster/startuptime.vim',
  'vim-utils/vim-all', -- a<CR>

  {
    'nat-418/boole.nvim',
    opts = { mappings = { increment = '<C-a>', decrement = '<C-x>' } },
  },
  {
    'folke/noice.nvim',
    opts = require('cfg.plugins.noice'),
    dependencies = {
      'MunifTanjim/nui.nvim',
      { 'rcarriga/nvim-notify', opts = require('cfg.plugins.notify') }
    }
  },

  --[[------------------------------------------------------------------------
  Colors Outside of Treesitter
  --------------------------------------------------------------------------]]

  'dstein64/nvim-scrollview',
  'voldikss/vim-floaterm',
  'wellle/targets.vim',
  'wellle/visual-split.vim',

  { 'KabbAmine/vCoolor.vim',     cmd = 'VCoolor' },
  { 'junegunn/limelight.vim',    cmd = 'Limelight' },
  { 'nvim-lualine/lualine.nvim', opts = require('cfg.plugins.lualine') },
  { 'rrethy/vim-hexokinase',     build = 'make hexokinase' },
  { 'sainnhe/everforest',        lazy = false },

  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    config = require('mod.colors').nightfox,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          'packer', 'floaterm', 'help', 'Outline', 'NvimTree', 'neo-tree', '',
        },
      },
    },
  },
  {
    'mzlogin/vim-markdown-toc',
    init = function()
      vim.g.vmt_list_item_char = '-'
      vim.g.vmt_list_indent_text = '  '
      vim.g.vmt_dont_insert_fence = 1
    end
  },
  {
    'junegunn/goyo.vim',
    cmd = 'Goyo',
    config = function()
      vim.g.goyo_width = 120
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GoyoEnter',
        callback = function()
          require('lualine').hide({
            place = { 'statuslint', 'tabline', 'winbar' },
            unhide = false
          })
        end
      })
    end
  },
  -- {
  --   'akinsho/bufferline.nvim',
  --   dependencies = 'kyazdani42/nvim-web-devicons',
  --   version = '^v3',
  --   config = require('cfg.plugins.bufferline'),
  -- },

  --[[------------------------------------------------------------------------
  SDLC-ish Stuff
  --------------------------------------------------------------------------]]

  'tpope/vim-fugitive',
  { 'oguzbilgic/vim-gdiff',      cmd = { 'Gdiff', 'Gdiffsplit' } },

  {
    'rmagatti/auto-session',
    opts = { log_level = 'warn', auto_session_suppress_dirs = { '~/' } },
  },
  {
    'rmagatti/session-lens',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = { theme_conf = { border = false } },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'MunifTanjim/nui.nvim',
      {
        -- only needed if you want to use the commands with '_with_window_picker' suffix
        's1n7ax/nvim-window-picker',
        version = '2.*',
        opts = {
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', 'quickfix' },
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
    opts = require('cfg.plugins.gitsigns'),
  },

  --[[------------------------------------------------------------------------
  Support for Specific Languages
  --------------------------------------------------------------------------]]

  'jose-elias-alvarez/typescript.nvim',
  'michaeljsmith/vim-indent-object',
  'midchildan/ft-confluence.vim',
  'pearofducks/ansible-vim',
  'simrat39/rust-tools.nvim',
  'towolf/vim-helm',

  { 'BodneyC/knit-vim',          ft = 'knit' },
  { 'BodneyC/sood-vim',          ft = 'sood' },
  { 'dkarter/bullets.vim',       ft = 'markdown', },
  { 'hashivim/vim-terraform',    ft = 'terraform' },
  { 'justinmk/vim-syntax-extra', ft = { 'lex', 'yacc' } },
  { 'm-pilia/vim-pkgbuild',      ft = 'pkgbuild' },
  { 'rmagatti/gx-extended.nvim', opts = {} },

  {
    'plasticboy/vim-markdown',
    ft = 'markdown',
    init = function()
      vim.g.vim_markdown_folding_disabled = true
      vim.g.vim_markdown_no_default_key_mappings = true
    end
  },
  {
    'barrett-ruth/import-cost.nvim',
    build = 'sh install.sh npm',
    opts = { highlight = 'Comment' },
  },

  --[[------------------------------------------------------------------------
  Note-taking
  --------------------------------------------------------------------------]]

  {
    'lervag/wiki.vim',
    init = function()
      local root = os.getenv('HOME') .. '/.notes-wiki'
      if vim.fn.isdirectory(root) == 0 then
        os.execute('mkdir -p ' .. root)
      end
      vim.g.wiki_root = root
      vim.g.wiki_global_load = 0
      vim.g.wiki_filetypes = { 'md', 'sh' }
    end
  }
})
