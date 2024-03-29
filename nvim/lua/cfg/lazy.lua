local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', --[[ latest stable release --]]
    lazypath,
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
      {
        'williamboman/mason.nvim',
        opts = {},
      },
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
  {
    'stevearc/dressing.nvim',
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },

  { 'nvimdev/lspsaga.nvim', opts = require('cfg.plugins.lspsaga') },
  { 'simrat39/symbols-outline.nvim', opts = {} },

  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      { 'junegunn/fzf', build = './install --bin' },
    },
    config = function()
      vim.g.fzf_history_dir = os.getenv('HOME')
        .. '/.local/share/nvim/fzf-history'
      if vim.fn.isdirectory(vim.g.fzf_history_dir) == 0 then
        os.execute('mkdir -p ' .. vim.g.fzf_history_dir)
      end
      -- calling `setup` is optional for customization
      require('fzf-lua').setup(require('cfg.plugins.fzf'))
    end,
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
      require('nvim-treesitter.configs').setup(
        require('cfg.plugins.treesitter')
      )
      require('ts_context_commentstring').setup(
        require('cfg.plugins.ts_context_comments')
      )
    end,
    dependencies = {
      'RRethy/nvim-treesitter-endwise',
      'RRethy/nvim-treesitter-textsubjects',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'vigoux/treesitter-context.nvim',
      'JoosepAlviste/nvim-ts-context-commentstring',
      { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
    },
  },

  --[[------------------------------------------------------------------------
  DAP Setup and configuration
  --------------------------------------------------------------------------]]

  'mfussenegger/nvim-dap',
  'theHamsta/nvim-dap-virtual-text',
  'rcarriga/nvim-dap-ui',
  'jbyuki/one-small-step-for-vimkind',

  { 'Pocco81/dap-buddy.nvim', branch = 'dev' },
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

  { 'BodneyC/hex-this-vim', cmd = 'HexThis' },
  { 'numToStr/Navigator.nvim', opts = {} },

  {
    'rcarriga/neotest',
    config = function()
      require('neotest').setup(require('cfg.plugins.neotest'))
    end,
    dependencies = {
      'nvim-neotest/neotest-go',
      'antoinemadec/FixCursorHold.nvim',
      'haydenmeade/neotest-jest',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/neotest-plenary',
      'rcarriga/neotest-python',
      'rcarriga/neotest-vim-test',
      'rcasia/neotest-bash',
      'BodneyC/neotest-bats',
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

  { 'folke/todo-comments.nvim', opts = require('cfg.plugins.todo-comments') },
  {
    'folke/trouble.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
  },
  {
    'folke/which-key.nvim',
    opts = { triggers_blacklist = { n = { '"' } } },
  },
  { 'kwkarlwang/bufresize.nvim', config = true },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        break_undo = false,
        map_cr = true,
        map_bs = false,
        fast_wrap = { map = '<M-w>' },
      })
      vim.keymap.set(
        'i',
        '∑',
        [[<esc>l<cmd>lua require('nvim-autopairs.fastwrap').show()<cr>]],
        { silent = true }
      )
    end,
  },
  {
    'luukvbaal/stabilize.nvim',
    opts = {
      ignore = {
        filetype = {
          'help',
          'list',
          'Trouble',
          'NvimTree',
          'Outline',
          'neo-tree',
        },
        buftype = { 'terminal', 'quickfix', 'loclist' },
      },
    },
  },
  {
    'rhysd/clever-f.vim',
    config = function()
      vim.g.clever_f_mark_char_color = 'ModeMsg'
      vim.keymap.set('', ';', '<Plug>(clever-f-repeat-forward)', {})
      vim.keymap.set('', ',', '<Plug>(clever-f-repeat-back)', {})
      vim.keymap.set('n', '<Esc>', function()
        vim.fn['clever_f#reset']()
        vim.cmd([[normal! "<Esc>"]])
      end, {})
    end,
  },

  --[[------------------------------------------------------------------------
  Wrappers Around Vim Internal-ish Stuff
  --------------------------------------------------------------------------]]

  'andymass/vim-matchup', -- % on `end`s
  'moll/vim-bbye', -- <leader>bd
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
    config = function()
      -- NOTE: Deferring this as large errors on startup causes Neovim to crash
      vim.defer_fn(function()
        require('noice').setup(require('cfg.plugins.noice'))
      end, 100)
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      { 'rcarriga/nvim-notify', opts = require('cfg.plugins.notify') },
    },
  },

  --[[------------------------------------------------------------------------
  Colors Outside of Treesitter
  --------------------------------------------------------------------------]]

  'dstein64/nvim-scrollview',
  'voldikss/vim-floaterm',
  'wellle/targets.vim',
  'wellle/visual-split.vim',

  { 'KabbAmine/vCoolor.vim', cmd = 'VCoolor' },
  { 'junegunn/limelight.vim', cmd = 'Limelight' },
  { 'nvim-lualine/lualine.nvim', opts = require('cfg.plugins.lualine') },
  { 'rrethy/vim-hexokinase', build = 'make hexokinase' },
  { 'sainnhe/everforest', lazy = false },

  {
    'marko-cerovac/material.nvim',
    lazy = false,
    -- config = require('mod.colors').material,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    config = require('mod.colors').nightfox,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      local hooks = require('ibl.hooks')
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#BB5A61' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#BE9F66' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#5090C4' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#A0764E' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#77995F' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#945BA5' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#3E838C' })
      end)

      require('ibl').setup({
        exclude = {
          filetypes = {
            'packer',
            'floaterm',
            'help',
            'Outline',
            'NvimTree',
            'neo-tree',
            '',
          },
        },
        scope = { show_start = false, show_end = false },
        indent = { char = '│', highlight = highlight },
      })
    end,
  },
  {
    'mzlogin/vim-markdown-toc',
    init = function()
      vim.g.vmt_list_item_char = '-'
      vim.g.vmt_list_indent_text = '  '
      vim.g.vmt_dont_insert_fence = 1
    end,
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
            unhide = false,
          })
        end,
      })
    end,
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
  'sindrets/diffview.nvim',

  { 'oguzbilgic/vim-gdiff', cmd = { 'Gdiff', 'Gdiffsplit' } },

  {
    'rmagatti/auto-session',
    opts = { log_level = 'warn', auto_session_suppress_dirs = { '~/' } },
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = require('cfg.plugins.gitsigns'),
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
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
        },
      },
    },
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

  { 'BodneyC/knit-vim', ft = 'knit' },
  { 'BodneyC/sood-vim', ft = 'sood' },
  { 'dkarter/bullets.vim', ft = 'markdown' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  { 'justinmk/vim-syntax-extra', ft = { 'lex', 'yacc' } },
  { 'm-pilia/vim-pkgbuild', ft = 'pkgbuild' },
  {
    'rmagatti/gx-extended.nvim',
    opts = { open_fn = require('lazy.util').open },
  },

  {
    'plasticboy/vim-markdown',
    ft = 'markdown',
    init = function()
      vim.g.vim_markdown_folding_disabled = true
      vim.g.vim_markdown_no_default_key_mappings = true
    end,
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
    end,
  },
})
