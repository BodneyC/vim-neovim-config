return {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local variant = 'nightfox'
    require('nightfox').setup({
      options = {
        styles = {
          comments = 'italic',
          keywords = 'bold',
          types = 'italic,bold',
        },
      },
      groups = {
        all = {
          IndentBlanklineChar = { fg = 'bg3' },
          TelescopePromptBorder = { bg = 'bg2', fg = 'fg2' },
          TelescopePromptNormal = { bg = 'bg2', fg = 'fg0' },
          TelescopePromptTitle = { bg = 'bg2', fg = 'fg2' },
          TelescopePromptPrefix = { bg = 'bg2', fg = 'fg2' },
          TelescopeNormal = { bg = 'bg1' },
          gitblame = { fg = 'palette.comment' },
          CursorLine = { bg = 'bg2' },
          CurrentWord = { bg = 'bg2' },
          CurrentWords = { bg = 'bg1' },
          CurrentWordsTwins = { link = 'CurrentWords' },
          -- WSDelimiterRed = { bg = '#292736' },
          -- WSDelimiterYellow = { bg = '#313739' },
          -- WSDelimiterBlue = { bg = '#212E3F' },
          -- WSDelimiterOrange = { bg = '#2D2F34' },
          -- WSDelimiterGreen = { bg = '#22303A' },
          -- WSDelimiterViolet = { bg = '#2A2B3F' },
          -- WSDelimiterCyan = { bg = '#20323E' },
        },
      },
    })
    vim.cmd('colo ' .. variant)
    local palette = require('nightfox.palette.' .. variant).palette
    vim.api.nvim_set_hl(
      0,
      '@text.uri',
      { fg = palette.orange.base, underline = false, italic = true }
    )
  end,
}
