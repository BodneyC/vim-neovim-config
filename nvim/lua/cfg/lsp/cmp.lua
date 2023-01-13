local cmp = require('cmp')

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

vim.o.completeopt = 'menu,menuone,noselect'

for _, v in pairs({ '/', '?' }) do
  cmp.setup.cmdline(v, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer', }, },
  })
end

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = 'path', }, },
    { { name = 'cmdline', }, }
  ),
})
