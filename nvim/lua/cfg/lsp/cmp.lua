local cmp = require('cmp')
local util = require('utl.util')

local function replace_termcodes(s)
  return vim.api.nvim_replace_termcodes(s, true, true, true)
end

cmp.setup {
  completion = {
    autocomplete = {cmp.TriggerEvent.InsertEnter, cmp.TriggerEvent.TextChanged},
    completeopt = 'menu,menuone,noselect',
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 1,
  },

  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  mapping = {
    ['<C-p>'] = cmp.mapping.prev_item(),
    ['<C-n>'] = cmp.mapping.next_item(),
    ['<C-d>'] = cmp.mapping.scroll(-4),
    ['<C-f>'] = cmp.mapping.scroll(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping.mode({'i', 's'}, function(_, fallback)
      local col = vim.fn.col('.')
      if vim.fn.pumvisible() == 1 or
        vim.fn.getline('.'):sub(col - 1, col - 1):match('%S') then
        vim.fn.feedkeys(replace_termcodes('<C-n>'), 'n')
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = cmp.mapping.mode({'i', 's'}, function(_, fallback)
      local col = vim.fn.col('.')
      if vim.fn.pumvisible() == 1 or
        vim.fn.getline('.'):sub(col - 1, col - 1):match('%S') then
        vim.fn.feedkeys(replace_termcodes('<C-p>'), 'n')
      else
        vim.fn.feedkeys(replace_termcodes('<C-d>'), 'n')
      end
    end),
  },

  sources = {
    {name = 'buffer'}, {name = 'path'}, {name = 'nvim_lsp'}, {name = 'calc'},
    {name = 'vsnip'},
  },
}

util.augroup({
  name = '__CMP__',
  autocmds = {
    {
      event = 'FileType',
      glob = 'lua',
      cmd = 'lua require(\'cmp\').setup.buffer {sources = {{name = \'nvim_lua\'}}}',
    },
  },
})
