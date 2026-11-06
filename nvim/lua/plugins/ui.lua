local icons = require('config.icons')

return {
  { 'folke/which-key.nvim', event = 'VeryLazy', opts = {} },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { '' },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', symbols = { modified = '*', readonly = '-' } } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            sections = { 'error', 'warn', 'info' },
            symbols = {
              error = icons.diagnostics.error,
              warn = icons.diagnostics.warn,
              info = icons.diagnostics.info,
            },
          },
        },
        lualine_z = { 'location' },
      },
      extensions = { 'fugitive', 'neo-tree', 'quickfix', 'trouble', 'lazy' },
    },
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      { 'rcarriga/nvim-notify', opts = { timeout = 2000, max_width = 60, max_height = 25 } },
    },
    keys = {
      { '<leader>m', '<Cmd>NoiceDismiss<CR>', desc = 'Dismiss Noice messages' },
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        command_palette = true,
        long_message_to_split = true,
      },
      routes = {
        { filter = { event = 'msg_show', kind = '', find = 'written' }, opts = { skip = true } },
        { filter = { event = 'msg_show', kind = 'search_count' }, opts = { skip = true } },
        { filter = { event = 'msg_showmode' }, view = 'notify' },
      },
      messages = {
        view = 'notify',
        view_error = 'notify',
        view_warn = 'notify',
        view_history = 'messages',
        view_search = false,
      },
      views = {
        cmdline_popup = {
          border = { style = 'none', padding = { 1, 2 } },
          filter_options = {},
          win_options = { winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder' },
        },
      },
      popupmenu = {
        backend = 'nui',
        relative = 'editor',
        position = { row = 8, col = '50%' },
        size = { width = 60, height = 10 },
        border = { style = 'rounded', padding = { 0, 1 } },
        win_options = { winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' } },
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      local colors = {
        RainbowRed = '#BB5A61',
        RainbowYellow = '#BE9F66',
        RainbowBlue = '#5090C4',
        RainbowOrange = '#A0764E',
        RainbowGreen = '#77995F',
        RainbowViolet = '#945BA5',
        RainbowCyan = '#3E838C',
      }
      local hooks = require('ibl.hooks')
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        for name, fg in pairs(colors) do
          vim.api.nvim_set_hl(0, name, { fg = fg })
          vim.api.nvim_set_hl(0, 'TS' .. name, { fg = fg })
        end
      end)

      require('ibl').setup({
        exclude = { filetypes = { 'floaterm', 'help', 'neo-tree', '' } },
        scope = { show_start = false, show_end = false },
        indent = {
          char = '│',
          highlight = {
            'RainbowRed',
            'RainbowYellow',
            'RainbowBlue',
            'RainbowOrange',
            'RainbowGreen',
            'RainbowViolet',
            'RainbowCyan',
          },
        },
      })
    end,
  },

  {
    'HiPhish/rainbow-delimiters.nvim',
    init = function()
      vim.g.rainbow_delimiters = {
        highlight = {
          'TSRainbowRed',
          'TSRainbowYellow',
          'TSRainbowBlue',
          'TSRainbowOrange',
          'TSRainbowGreen',
          'TSRainbowViolet',
          'TSRainbowCyan',
        },
      }
    end,
  },

  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    config = function()
      require('tiny-inline-diagnostic').setup({
        transparent_cursorline = true,
        hi = { background = 'None' },
        options = {
          overwrite_events = { 'LspAttach', 'DiagnosticChanged' },
          multilines = {
            enabled = true,
            always_show = true,
            severity = { vim.diagnostic.severity.ERROR },
          },
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },

  {
    'dstein64/nvim-scrollview',
    opts = {
      excluded_filetypes = { 'neo-tree' },
      signs_on_startup = { 'diagnostics', 'search', 'folds' },
    },
  },

  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = { { '<leader>z', '<Cmd>ZenMode<CR>', desc = 'Zen mode' } },
    opts = {
      window = { backdrop = 0.35, width = 110, height = 1 },
      plugins = {
        options = { number = false },
        twilight = { enabled = true },
      },
    },
  },

  { 'folke/twilight.nvim', cmd = { 'Twilight', 'TwilightEnable', 'TwilightDisable' }, opts = {} },
  { 'junegunn/limelight.vim', cmd = 'Limelight' },
  { 'KabbAmine/vCoolor.vim', cmd = 'VCoolor' },

  {
    'rrethy/vim-hexokinase',
    build = 'make hexokinase',
    init = function()
      vim.g.Hexokinase_virtualText = ' '
      vim.g.Hexokinase_highlighters = { 'backgroundfull' }
      vim.g.Hexokinase_optInPatterns = { 'full_hex', 'triple_hex', 'rgb', 'rgba', 'hsl', 'hsla' }
    end,
  },

  { 'kwkarlwang/bufresize.nvim', opts = {} },
  { 'dominikduda/vim_current_word' },
}
