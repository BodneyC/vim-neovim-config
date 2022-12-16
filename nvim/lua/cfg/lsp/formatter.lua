require('formatter').setup {
  filetype = {
    sh = {
      function()
        return {
          exe = 'shfmt',
          args = { '-w', '-i=2', '-bn', '-ci', '-sr' },
          stdin = false,
        }
      end,
    },
    zsh = {
      function()
        return {
          exe = 'shfmt',
          args = { '-w', '-i=2', '-bn', '-ci', '-sr' },
          stdin = false,
        }
      end,
    },
    lua = {
      function()
        return {
          exe = 'lua-format',
          args = { '-i' },
          stdin = false,
        }
      end,
    },
    go = {
      function()
        return {
          exe = 'gofmt',
          args = { '-w' },
          stdin = true,
        }
      end,
    },
    javascript = {
      function()
        return {
          exe = 'prettier',
          args = {
            '--stdin-filepath',
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            '--single-quote',
          },
          stdin = true,
        }
      end,
    },
    json = {
      function()
        return {
          exe = 'prettier',
          args = {
            '--stdin-filepath',
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            '--double-quote',
          },
          stdin = true,
        }
      end,
    },
    markdown = {
      function()
        return {
          exe = 'prettier',
          args = {
            '--stdin-filepath',
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            '--double-quote',
          },
          stdin = true,
        }
      end,
    },
    python = {
      function()
        return {
          exe = 'autopep8',
          args = { '--in-place' },
          stdin = true,
        }
      end,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  },
}
