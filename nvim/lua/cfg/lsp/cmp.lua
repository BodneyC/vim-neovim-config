local M = {}

local cmp = require('cmp')
local util = require('utl.util')

function M.zero_cmp_config()
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  vim.o.completeopt = 'menu,menuone,noselect'

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      { { name = 'path' } },
      { { name = 'cmdline' } }
    ),
  })

  cmp.setup({
    -- NOTE: For future Ben: the default is this but with `noinsert`
    completion = { completeopt = 'menu,menuone,noselect' },
    preselect = require('cmp').PreselectMode.None,
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping(function(_)
        if cmp.visible() then -- TODO: Or, at end of word
          cmp.select_next_item()
        else
          local _, col = unpack(vim.api.nvim_win_get_cursor(0))
          local line = vim.api.nvim_get_current_line()
          local char = line:sub(col, col)
          if char == '' or char:match("%s") ~= nil then
            util.feedkeys('<C-i>', 'n')
          else
            cmp.complete()
          end
        end
      end, { 'i', 's' }),
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
      { name = 'nvim_lsp',               keyword_length = 3 },
      { name = 'buffer',                 keyword_length = 3 },
      { name = 'nvim_lsp_signature_help' },
      { name = 'path' },
      { name = 'luasnip' },
    },
    formatting = {
      format = require('lspkind').cmp_format({
        mode = 'symbol',
        preset = 'default',
        symbol_map = require('mod.theme').icons.lspkind,
      }),
    },
  })
end

return M
