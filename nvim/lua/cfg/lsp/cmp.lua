local cmp = require('cmp')
local types = require('cmp.types')
local util = require('utl.util')

local function replace_termcodes(s)
  return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local copt = 'menu,menuone,noselect'
vim.o.completeopt = copt

cmp.setup {
  completion = {
    autocomplete = {
      -- types.cmp.TriggerEvent.InsertEnter,
      types.cmp.TriggerEvent.TextChanged,
    },
    completeopt = copt,
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 1,
  },

  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  preselect = types.cmp.PreselectMode.None,

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    -- ['<CR>'] = function()
    --   local cinf = vim.fn.complete_info()
    --   print(vim.inspect(cinf))
    --   if cinf.selected == -1 then
    --     print("feed")
    --     vim.fn.feedkeys(replace_termcodes('\n'), 'i')
    --   else
    --     print("conf")
    --     cmp.mapping.confirm {
    --       behavior = cmp.ConfirmBehavior.Replace,
    --       select = true,
    --     }
    --   end
    -- end,
    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.')
      if vim.fn.pumvisible() == 1 or
        vim.fn.getline('.'):sub(col - 1, col - 1):match('%S') then
        vim.fn.feedkeys(replace_termcodes('<C-n>'), 'n')
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(_)
      local col = vim.fn.col('.')
      if vim.fn.pumvisible() == 1 or
        vim.fn.getline('.'):sub(col - 1, col - 1):match('%S') then
        vim.fn.feedkeys(replace_termcodes('<C-p>'), 'n')
      else
        vim.fn.feedkeys(replace_termcodes('<C-d>'), 'n')
      end
    end, {'i', 's'}),
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
      cmd = [[lua require('cmp').setup.buffer {sources = {{name = 'nvim_lua'}}}]],
    },
  },
})
