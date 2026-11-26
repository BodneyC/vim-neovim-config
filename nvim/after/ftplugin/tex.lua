vim.o.iskeyword = '@,48-57,_,192-255'
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.cmd([[set iskeyword-=:]])
  end,
  pattern = '*.tex'
})
