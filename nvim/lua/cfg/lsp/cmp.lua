local cmp = require('cmp')
local util = require('utl.util')

local function has_words_before()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
      :match('%s') == nil
end

vim.o.completeopt = 'menu,menuone,noselect'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-g>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      select = false,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available']() == 1 then
        util.feedkeys('<Plug>(vsnip-expand-or-jump)', '')
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(_)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        util.feedkeys('<Plug>(vsnip-jump-prev)', '')
      elseif has_words_before() then
        cmp.complete()
      else
        util.feedkeys('<C-d>', 'n')
      end
    end, {'i', 's'}),
  }),

  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol',
      preset = 'default',
      symbol_map = require('mod.theme').icons.lspkind,
    }),
  },

  sources = {
    {
      name = 'nvim_lsp',
    },
    {
      name = 'nvim_lsp_signature_help',
    },
    {
      name = 'vsnip',
    },
    {
      name = 'path',
    },
    {
      name = 'buffer',
    },
    {
      name = 'calc',
    },
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    {
      name = 'buffer',
    },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    {
      name = 'path',
    },
  }, {
    {
      name = 'cmdline',
    },
  }),
})
