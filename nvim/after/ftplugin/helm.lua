local function lookup()
  vim.cmd('normal! "kyi"')
  vim.cmd(('silent! grep %s'):format(vim.fn.shellescape('define "' .. vim.fn.getreg('k') .. '"')))
end

vim.api.nvim_buf_create_user_command(0, 'HelmLookup', lookup, {})
vim.keymap.set('n', '<C-]>', lookup, { buffer = true, silent = true, desc = 'Helm lookup' })
