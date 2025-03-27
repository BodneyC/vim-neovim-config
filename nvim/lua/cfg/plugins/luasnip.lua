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
require("luasnip.loaders.from_vscode").load({
  path = os.getenv('HOME') .. '/.config/nvim/snippets/friendly-snippets',
})
