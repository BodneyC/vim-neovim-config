return {
  'plasticboy/vim-markdown',
  ft = 'markdown',
  init = function()
    vim.g.vim_markdown_folding_disabled = true
    vim.g.vim_markdown_no_default_key_mappings = true
  end,
}
