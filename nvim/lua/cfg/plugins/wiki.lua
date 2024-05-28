return {
  'lervag/wiki.vim',
  init = function()
    local root = os.getenv('HOME') .. '/.notes-wiki'
    if vim.fn.isdirectory(root) == 0 then
      os.execute('mkdir -p ' .. root)
    end
    vim.g.wiki_root = root
    vim.g.wiki_global_load = 0
    vim.g.wiki_filetypes = { 'md', 'sh' }
  end,
}
