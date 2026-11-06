vim.opt_local.conceallevel = 0
vim.opt_local.commentstring = '// %s'
vim.cmd([[syntax match Comment "//.\+$"]])

vim.api.nvim_buf_create_user_command(0, 'SortJSON', "%!grep -v '^[\t ]*//' | jq --indent 2 -S '.'", {})
vim.keymap.set('n', '<leader>F', '<Cmd>SortJSON<CR>', { buffer = true, silent = true, desc = 'Sort JSON' })
