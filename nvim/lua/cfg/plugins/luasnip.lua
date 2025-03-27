-- local function snippet_map(mode, key, pos)
--   vim.keymap.set(
--     mode,
--     key,
--     [[<cmd>lua require'luasnip'.jump(]] .. pos .. [[)<Cr>]],
--     { silent = true }
--   )
-- end

-- snippet_map('i', '<C-j>', 1)
-- snippet_map('i', '<C-k>', -1)
-- snippet_map('s', '<C-j>', 1)
-- snippet_map('s', '<C-k>', -1)

local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

require('luasnip.loaders.from_snipmate').lazy_load({
  paths = os.getenv('HOME') .. '/.config/nvim/snippets',
})
require("luasnip.loaders.from_vscode").load({ path = os.getenv('HOME') .. '/gitclones/friendly-snippets' })
