return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'ray-x/lsp_signature.nvim',
    'windwp/nvim-autopairs',
  },
  config = function()
    local cmp = require('cmp')
    local util = require('utl.util')

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

    local luasnip = require("luasnip")

    cmp.setup({
      -- NOTE: For future Ben: the default is this but with `noinsert`
      completion = { completeopt = 'menu,menuone,noselect' },
      preselect = require('cmp').PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then -- TODO: Or, at end of word
            cmp.select_next_item()
          else
            -- local _, col = unpack(vim.api.nvim_win_get_cursor(0))
            -- local line = vim.api.nvim_get_current_line()
            -- local char = line:sub(col, col)
            -- if char == '' or char:match("%s") ~= nil then
            --   -- util.feedkeys('<C-i>', 'n')
            -- else
            fallback()
            -- end
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(_)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            util.feedkeys('<C-d>', 'n')
          end
        end, { 'i', 's' }),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end)
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
        { name = 'luasnip' },
      },

      window = {
        completion = {
          -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
      },
      formatting = {
        fields = { "abbr", "menu", "kind", },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            symbol_map = require('mod.theme').icons.lspkind,
          })(entry, vim_item)
          -- local strings = vim.split(kind.kind, "%s", { trimempty = true })
          -- kind.kind = " " .. (strings[1] or "") .. " "
          -- kind.menu = "    " .. (strings[2] or "")
          return kind
        end,
      },
    })
  end
}
