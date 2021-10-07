local cmp = require('cmp')

local function replace_termcodes(s)
  return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local function feedkeys(s, mode)
  vim.api.nvim_feedkeys(replace_termcodes(s), mode, true)
end

local function has_words_before()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
      :match('%s') == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` user.
    end,
  },

  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-g>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        feedkeys('<C-n>', 'n')
      elseif vim.fn['vsnip#available']() == 1 then
        feedkeys('<Plug>(vsnip-expand-or-jump)', '')
      elseif has_words_before() then
        feedkeys('<C-n>', 'n')
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(_)
      if vim.fn.pumvisible() == 1 then
        feedkeys('<C-p>', 'n')
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkeys('<Plug>(vsnip-jump-prev)', '')
      elseif has_words_before() then
        feedkeys('<C-p><C-p>', 'n')
      else
        feedkeys('<C-d>', 'n')
      end
    end, {'i', 's'}),
  },

  formatting = {
    format = require('lspkind').cmp_format(),
  },

  sources = {
    {
      name = 'nvim_lsp',
    },
    {
      name = 'vsnip',
    },
    {
      name = 'buffer',
    },
    {
      name = 'calc',
    },
    {
      name = 'path',
    },
  },
})

util.augroup({
  name = '__CMP__',
  autocmds = {
    {
      event = 'FileType',
      glob = 'lua',
      cmd = [[lua require('cmp').setup.buffer {sources = {{name = 'nvim_lua'}}}]],
    },
  },
})
