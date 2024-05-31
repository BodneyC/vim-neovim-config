vim.api.nvim_create_user_command('HelmLookup', require('mod.helm').lookup, {})
vim.keymap.set('n', '<C-]>', '<CMD>HelmLookup<CR>', { noremap = true, silent = true })
