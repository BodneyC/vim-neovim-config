return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kanagawa').setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { italic = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = { ui = { bg_gutter = 'none' } },
        },
      },
      overrides = function(colors)
        -- Kanagawa seems to be pinched largely from Nightfox... but with a few groups
        --  missing. These are the ones I care about.
        local theme = colors.theme
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
          ['@markup.link.url'] = {
            fg = syn.constant,
            italic = true,
            underline = true,
          },
          ['@markup.raw'] = { fg = syn.identifier, italic = true },
          ['@markup.raw.block'] = { fg = syn.number },          -- pink
          ['@markup.list'] = { fg = syn.keyword },
          ['@markup.list.checked'] = { fg = theme.term[11] },   -- green
          ['@markup.list.unchecked'] = { fg = syn.identifier }, -- yellow
        }
      end,
      theme = 'dragon',
      background = {
        dark = 'dragon',
        light = 'lotus',
      },
    })
    vim.cmd([[color kanagawa]])
  end

  ,
}
