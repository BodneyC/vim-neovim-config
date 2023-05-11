local function snippet_map(mode, key, pos)
  vim.keymap.set(mode, key, [[<cmd>lua require'luasnip'.jump(]] .. pos .. [[)<Cr>]], { silent = true })
end

snippet_map('i', '<C-j>', 1)
snippet_map('i', '<C-k>', -1)
snippet_map('s', '<C-j>', 1)
snippet_map('s', '<C-k>', -1)

require('luasnip.loaders.from_snipmate').lazy_load({ paths = os.getenv('HOME') .. '/.config/nvim/snippets' })
