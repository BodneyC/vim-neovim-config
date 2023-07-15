local bskm = vim.api.nvim_buf_set_keymap

local flags = require('utl.maps').flags

vim.wo.conceallevel = 0
vim.wo.concealcursor = ''
vim.bo.commentstring = '<!-- %s -->'
vim.o.spell = true
vim.o.nu = false
local group = vim.api.nvim_create_augroup('CustomMarkdown', {
  clear = true,
})
vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  pattern = '*.md',
  callback = function()
    vim.o.nu = false
  end
})
vim.api.nvim_create_autocmd('BufLeave', {
  group = group,
  pattern = 'everforest',
  callback = function()
    vim.o.nu = true
  end
})

bskm(0, 'n', 'j', 'gj', flags.ns)
bskm(0, 'n', 'k', 'gk', flags.ns)
bskm(0, 'n', 'gj', 'j', flags.ns)
bskm(0, 'n', 'gk', 'k', flags.ns)
vim.cmd([[
  let @t = "mzvip:EasyAlign *|\<CR>`z"
  let @h = "YpVr="
]])
bskm(0, 'n', '<leader>S', '1z=', flags.ns)
bskm(0, 'i', '<Tab>', string.gsub([[
  pumvisible()
    ? "\<C-n>"
    : (!(col('.') - 1) || getline('.')[col('.') - 2]  =~ '\s')
      ? (getline('.') =~ '^\s*-\s*')
        ? "\<C-o>>>\<C-o>A "
        : "\<Tab>"
      : compe#complete()
]], '\n', ''), flags.nse)
