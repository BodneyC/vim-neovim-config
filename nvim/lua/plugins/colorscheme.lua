local active = 'catppuccin'

local function theme(name, spec)
  spec.enabled = name == active
  spec.lazy = false
  spec.priority = 1000
  return spec
end

return {
  theme('catppuccin', {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          notify = false,
          mini = { enabled = true, indentscope_color = '' },
        },
      })
      vim.cmd.colorscheme('catppuccin-macchiato')
    end,
  }),

  theme('kanagawa', {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup({
        compile = true,
        statementStyle = { italic = true },
        colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
        background = { dark = 'dragon', light = 'lotus' },
        overrides = function(colors)
          local theme, palette = colors.theme, colors.palette
          local syn = theme.syn
          return {
            ['@module'] = { fg = syn.keyword },
            ['@label'] = { link = 'Label' },
            ['@number.float'] = { link = 'Float' },
            ['@type.builtin'] = { link = '@module' },
            ['@keyword.function'] = { fg = syn.keyword, italic = true },
            ['@keyword.storage'] = { link = 'StorageClass' },
            ['@keyword.repeat'] = { link = 'Repeat' },
            ['@keyword.exception'] = { link = 'Exception' },
            ['@keyword.conditional'] = { link = 'Conditional' },
            ['@keyword.conditional.ternary'] = { link = 'Conditional' },
            ['@markup'] = { fg = theme.ui.fg },
            ['@markup.link'] = { fg = syn.keyword },
            ['@markup.link.label'] = { link = 'Special' },
            ['@markup.link.url'] = { fg = syn.constant, italic = true, underline = true },
            ['@markup.raw'] = { fg = syn.identifier, italic = true },
            ['@markup.raw.block'] = { fg = syn.number },
            ['@markup.list'] = { fg = syn.keyword },
            ['@markup.list.checked'] = { fg = theme.term[11] },
            ['@markup.list.unchecked'] = { fg = syn.identifier },
            CmpItemAbbrDeprecated = { fg = palette.fujiGray, strikethrough = true, italic = true },
            CmpItemAbbrMatch = { fg = palette.springBlue },
            CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
            CmpItemKindVariable = { fg = palette.lightBlue, italic = true },
            CmpItemKindInterface = { link = 'CmpItemKindVariable' },
            CmpItemKindText = { link = 'CmpItemKindVariable' },
            CmpItemKindFunction = { fg = palette.springViolet1, italic = true },
            CmpItemKindMethod = { link = 'CmpItemKindFunction' },
            CmpItemKindKeyword = { italic = true },
            CmpItemKindProperty = { link = 'CmpItemKindKeyword' },
            CmpItemKindUnit = { link = 'CmpItemKindKeyword' },
            CmpItemKindSnippet = { fg = palette.oniViolet, italic = true },
          }
        end,
      })
      vim.cmd.colorscheme('kanagawa')
    end,
  }),

  theme('nightfox', {
    'EdenEast/nightfox.nvim',
    config = function()
      require('nightfox').setup({
        options = {
          styles = { comments = 'italic', keywords = 'bold', types = 'italic,bold' },
        },
        groups = {
          all = {
            IndentBlanklineChar = { fg = 'bg3' },
            gitblame = { fg = 'palette.comment' },
            CursorLine = { bg = 'bg2' },
            CurrentWord = { bg = 'bg2' },
            CurrentWords = { bg = 'bg1' },
            CurrentWordsTwins = { link = 'CurrentWords' },
          },
        },
      })
      vim.cmd.colorscheme('nightfox')
      local palette = require('nightfox.palette.nightfox').palette
      vim.api.nvim_set_hl(0, '@markup.link.url', { fg = palette.orange.base, italic = true })
    end,
  }),

  theme('material', {
    'marko-cerovac/material.nvim',
    init = function()
      vim.g.material_style = 'darker'
    end,
    config = function()
      local colors = require('material.colors')
      require('material').setup({
        contrast = { terminal = true, sidebars = true },
        styles = { comments = { italic = true } },
        plugins = {
          'dap',
          'gitsigns',
          'indent-blankline',
          'lspsaga',
          'neotest',
          'neo-tree',
          'noice',
          'nvim-cmp',
          'nvim-web-devicons',
          'rainbow-delimiters',
          'trouble',
          'which-key',
          'nvim-notify',
        },
        disable = { colored_cursor = true, borders = true, eob_lines = true },
        high_visibility = { darker = true },
        lualine_style = 'stealth',
        custom_highlights = {
          Search = { bg = colors.editor.selection, fg = colors.main.white },
        },
      })
      vim.cmd.colorscheme('material')
    end,
  }),

  theme('oldworld', {
    'dgox16/oldworld.nvim',
    opts = {
      terminal_colors = true,
      styles = { comments = { italic = true }, keywords = { italic = true } },
    },
    config = function(_, opts)
      require('oldworld').setup(opts)
      vim.cmd.colorscheme('oldworld')
    end,
  }),

  theme('everforest', {
    'neanias/everforest-nvim',
    config = function()
      require('everforest').setup({ background = 'hard', transparent_background_level = 0 })
      vim.cmd.colorscheme('everforest')
    end,
  }),

  theme('github', {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    config = function()
      local spec = require('github-theme.palette').load('github_dark_dimmed')
      require('github-theme').setup({
        groups = {
          github_dark_dimmed = {
            Search = { bg = spec.accent.subtle },
            MatchParen = { link = 'Search' },
          },
        },
      })
      vim.cmd.colorscheme('github_dark_dimmed')
    end,
  }),
}
