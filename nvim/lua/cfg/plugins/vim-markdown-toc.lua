return {
  'mzlogin/vim-markdown-toc',
  init = function()
    vim.g.vmt_list_item_char = '-'
    vim.g.vmt_list_indent_text = '  '
    vim.g.vmt_dont_insert_fence = 1
  end,
}
