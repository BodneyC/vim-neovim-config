local util = require('utl.util')
local bskm = vim.api.nvim_buf_set_keymap

vim.bo.commentstring = '// %s'
vim.fn.execute('syntax match Comment "//.\\+$"')
util.command('SortJSON', ':%!grep -v \'^[\t ]*//\' | jq --indent 2 -S \'.\'', {
  nargs = 0,
})
bskm(0, 'n', '<leader>F', ':SortJSON<CR>', {
  noremap = true,
  silent = true,
})
