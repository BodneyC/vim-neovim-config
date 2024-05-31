vim.wo.conceallevel = 0
vim.bo.commentstring = '// %s'
vim.fn.execute('syntax match Comment "//.\\+$"')
vim.api.nvim_create_user_command('SortJSON', ":%!grep -v '^[\t ]*//' | jq --indent 2 -S '.'", {})
vim.keymap.set('n', '<leader>F', ':SortJSON<CR>', { buffer = 0, noremap = true, silent = true })
