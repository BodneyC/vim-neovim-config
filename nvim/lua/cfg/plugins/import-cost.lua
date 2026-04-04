return {
  'barrett-ruth/import-cost.nvim',
  build = 'sh install.sh npm',
  opts = { highlight = 'Comment' },
  config = function()
    vim.g.import_cost = {}
  end,
}
