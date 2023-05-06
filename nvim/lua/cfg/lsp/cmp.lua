local M = {}

local cmp = require('cmp')
local zero = require('lsp-zero')
local util = require('utl.util')

function M.zero_cmp_config()
  return {
    -- NOTE: For future Ben: the default is this but with `noinsert`
    completion = { completeopt = 'menu,menuone,noselect' },
    preselect = require('cmp').PreselectMode.None,
    mapping = zero.defaults.cmp_mappings({
      ['<S-Tab>'] = cmp.mapping(function(_)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          util.feedkeys('<C-d>', 'n')
        end
      end, { 'i', 's' }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
      {
        name = 'nvim_lsp',
        keyword_length = 3
      },
      { name = 'nvim_lsp_signature_help', },
      {
        name = 'buffer',
        keyword_length = 3
      },
      { name = 'path', },
      { name = 'luasnip', },
    },
    formatting = {
      format = require('lspkind').cmp_format({
        mode = 'symbol',
        preset = 'default',
        symbol_map = require('mod.theme').icons.lspkind,
      }),
    },
  }
end

function M.post_zero_setup()
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

  cmp.setup.filetype('clojure', {
    sources = {
      { name = 'conjure' },
      { name = 'nvim_lsp',                keyword_length = 3 },
      { name = 'nvim_lsp_signature_help', },
      { name = 'luasnip', },
    },
    {
      { name = 'path', },
      { name = 'buffer', keyword_length = 3 },
    },
  })
end

return M
