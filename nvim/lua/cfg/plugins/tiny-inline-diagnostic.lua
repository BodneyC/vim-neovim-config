return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup()
    vim.diagnostic.config({ float = false, virtual_text = false })
  end
}
