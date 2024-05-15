return function()
  require('nvim-autopairs').setup({
    break_undo = false,
    map_cr = true,
    map_bs = false,
    fast_wrap = { map = '<M-w>' },
  })
  vim.keymap.set(
    'i', '∑',
    [[<esc>l<cmd>lua require('nvim-autopairs.fastwrap').show()<cr>]],
    { silent = true }
  )
end
