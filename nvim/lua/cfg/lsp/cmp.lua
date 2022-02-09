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

  mapping = {
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
  },

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

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    {
      name = 'buffer',
    },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
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

-- require('utl.util').augroup({
--   name = '__CMP__',
--   autocmds = {
--     {
--       event = 'FileType',
--       glob = 'lua',
--       cmd = [[lua require('cmp').setup.buffer {sources = {{name = 'nvim_lua'}}}]],
--     },
--   },
-- })
