local util = require('utl.util')

vim.wo.conceallevel = 0
vim.bo.commentstring = '// %s'
vim.fn.execute('syntax match Comment "//.\\+$"')
util.command('SortJSON', ':%!grep -v \'^[\t ]*//\' | jq --indent 2 -S \'.\'', {
  nargs = 0,
})
local map = require('utl.mapper')({ noremap = true, silent = true })
map(0, 'n', '<leader>F', ':SortJSON<CR>', 'Sort JSON')
