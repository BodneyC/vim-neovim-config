return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup({
      transparent_cursorline = true,
      hi = {
        background = "None", -- Background highlight for diagnostics
      },
      options = {
        multilines = {
          enabled = true,
          always_show = true,
          severity = { vim.diagnostic.severity.ERROR },
        },
      },
    })
    vim.diagnostic.config({ virtual_text = false })
  end
}
