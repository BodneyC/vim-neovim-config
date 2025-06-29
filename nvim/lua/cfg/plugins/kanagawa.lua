return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kanagawa').setup({
      compile = true,
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
          ['@module']                      = { fg = syn.keyword },
          ['@label']                       = { link = 'Label' },
          ['@number.float']                = { link = 'Float' },
          ['@type.builtin']                = { link = '@module' },
          ['@keyword.function']            = { fg = syn.keyword, italic = true },
          ['@keyword.storage']             = { link = 'StorageClass' },
          ['@keyword.repeat']              = { link = 'Repeat' },
          ['@keyword.exception']           = { link = 'Exception' },
          ['@keyword.conditional']         = { link = 'Conditional' },
          ['@keyword.conditional.ternary'] = { link = 'Conditional' },
          ['@markup']                      = { fg = theme.ui.fg },
          ['@markup.link']                 = { fg = syn.keyword },
          ['@markup.link.label']           = { link = 'Special' },
          ['@markup.link.url']             = {
            fg = syn.constant,
            italic = true,
            underline = true,
          },
          ['@markup.raw']                  = { fg = syn.identifier, italic = true },
          ['@markup.raw.block']            = { fg = syn.number },     -- pink
          ['@markup.list']                 = { fg = syn.keyword },
          ['@markup.list.checked']         = { fg = theme.term[11] }, -- green
          ['@markup.list.unchecked']       = { fg = syn.identifier }, -- yellow
          CmpItemAbbrDeprecated            = { fg = colors.palette.fujiGray, strikethrough = true, italic = true },
          -- blue
          CmpItemAbbrMatch                 = { fg = colors.palette.springBlue },
          CmpItemAbbrMatchFuzzy            = { link = 'CmpItemAbbrMatch' },
          -- light blue
          CmpItemKindVariable              = { fg = colors.palette.lightBlue, italic = true },
          CmpItemKindInterface             = { link = 'CmpItemKindVariable' },
          CmpItemKindText                  = { link = 'CmpItemKindVariable' },
          -- pink
          CmpItemKindFunction              = { fg = colors.palette.springViolet1, italic = true },
          CmpItemKindMethod                = { link = 'CmpItemKindFunction' },
          -- front
          CmpItemKindKeyword               = { italic = true },
          CmpItemKindProperty              = { link = 'CmpItemKindKeyword' },
          CmpItemKindUnit                  = { link = 'CmpItemKindKeyword' },
          -- other
          CmpItemKindSnippet               = { fg = colors.palette.oniViolet, italic = true },
        }
      end,
      background = {
        dark = 'dragon',
        light = 'lotus',
      },
    })
    vim.cmd([[color kanagawa]])
  end,
}
