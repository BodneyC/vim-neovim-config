local map = require('utl.mapper')({ noremap = true, silent = true })

vim.wo.conceallevel = 0
vim.wo.concealcursor = ''
vim.bo.commentstring = '<!-- %s -->'
vim.o.spell = true
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
  pattern = '*.md',
  callback = function()
    vim.o.nu = true
  end
})

map('n', 'j', 'gj', nil, { buffer = 0 })
map('n', 'k', 'gk', nil, { buffer = 0 })
map('n', 'gj', 'j', nil, { buffer = 0 })
map('n', 'gk', 'k', nil, { buffer = 0 })
vim.cmd([[
  let @t = "mzvip:EasyAlign *|\<CR>`z"
  let @h = "YpVr="
]])
map('n', '<leader>S', '1z=', nil, { buffer = 0 })
map('i', '<Tab>', string.gsub([[
  pumvisible()
    ? "\<C-n>"
    : (!(col('.') - 1) || getline('.')[col('.') - 2]  =~ '\s')
      ? (getline('.') =~ '^\s*-\s*')
        ? "\<C-o>>>\<C-o>A "
        : "\<Tab>"
      : compe#complete()
]], '\n', ''), nil, { buffer = 0, expr = true })
