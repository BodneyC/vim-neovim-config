local cmp = require('cmp')
local types = require('cmp.types')
local util = require('utl.util')
local lspkind = require('lspkind')

local function replace_termcodes(s)
  return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local function feedkeys(s, mode)
  vim.api.nvim_feedkeys(replace_termcodes(s), mode, true)
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local copt = 'menu,menuone,noselect,preview'
vim.o.completeopt = copt

cmp.setup {
  completion = {
    autocomplete = {
      types.cmp.TriggerEvent.InsertEnter,
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

  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    -- ['<CR>'] = cmp.mapping.confirm({
    --   -- behavior = cmp.ConfirmBehavior.Insert,
    --   select = true,
    -- }),
    -- ['<CR>'] = function()
    --   local cinf = vim.fn.complete_info()
    --   if cinf.selected == -1 then
    --     -- vim.fn.feedkeys(replace_termcodes('\n'), 'i')
    --     feedkeys('<Plug>AutoPairsReturn', '')
    --   else
    --     vim.fn.feedkeys(replace_termcodes('<C-y> '), 'i')
    --   end
    -- end,
    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.')
      if vim.fn.pumvisible() == 1 then
        feedkeys('<C-n>', 'n')
      elseif vim.fn['vsnip#available']() == 1 then
        feedkeys('<Plug>(vsnip-expand-or-jump)', '')
      elseif has_words_before() then
        feedkeys('<C-n><C-n>', 'n')
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(_)
      local col = vim.fn.col('.')
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
    format = function(entry, vim_item)
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

      return vim_item
    end,
  },

  sources = {
    {name = 'buffer'},
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'calc'},
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
