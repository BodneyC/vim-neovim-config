return {
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
}
