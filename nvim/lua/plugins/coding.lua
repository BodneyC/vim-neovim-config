local function smart_backspace()
  local npairs = require('nvim-autopairs')
  if vim.bo.buftype ~= '' then
    return npairs.esc('<BS>')
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  if line:sub(1, col):match('%S') then
    return npairs.autopairs_bs(vim.api.nvim_get_current_buf())
  end

  local prev = row > 1 and vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1]
  if prev and not prev:match('%S') then
    if line:match('%S') then
      return npairs.esc("<C-o>:silent exe line('.') - 1 . 'delete'<CR>")
    end
    return npairs.esc("<Esc>:silent exe line('.') - 1 . 'delete'<CR>S")
  end
  return npairs.esc(col == 0 and '<C-w>' or '<C-w><BS>')
end

return {
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    lazy = true,
    config = function()
      local ls = require('luasnip')
      ls.setup({ update_events = 'TextChanged,TextChangedI' })
      require('luasnip.loaders.from_snipmate').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })

      vim.keymap.set({ 'i', 's' }, '<C-j>', function()
        ls.jump(1)
      end, { silent = true, desc = 'Snippet: next placeholder' })
      vim.keymap.set({ 'i', 's' }, '<C-k>', function()
        ls.jump(-1)
      end, { silent = true, desc = 'Snippet: previous placeholder' })
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        break_undo = false,
        map_bs = false,
        fast_wrap = { map = '<M-w>' },
      })
      vim.keymap.set('i', '<BS>', smart_backspace, { expr = true, replace_keycodes = false })
      vim.keymap.set('i', '∑', "<Esc>l<Cmd>lua require('nvim-autopairs.fastwrap').show()<CR>", { desc = 'Fast wrap' })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'onsails/lspkind-nvim',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'windwp/nvim-autopairs',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local feedkeys = require('util').feedkeys

      cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = vim.o.completeopt },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              feedkeys('<C-d>')
            end
          end, { 'i', 's' }),
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
        window = {
          completion = { col_offset = -3, side_padding = 0 },
        },
        formatting = {
          fields = { 'abbr', 'menu', 'kind' },
          format = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 }),
        },
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
      })
    end,
  },

  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>F',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        desc = 'Format buffer',
      },
    },
    opts = {
      formatters = {
        jq = { prepend_args = { '.' } },
      },
      formatters_by_ft = {
        json = { 'jq' },
        bib = { 'bibtex-tidy' },
      },
      format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
    },
  },
}
