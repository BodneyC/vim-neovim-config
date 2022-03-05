require('formatter').setup {
  filetype = {
    sh = {
      function()
        return {
          exe = 'shfmt',
          args = {'-w', '-i=2', '-bn', '-ci', '-sr'},
        }
      end,
    },
    zsh = {
      function()
        return {
          exe = 'shfmt',
          args = {'-w', '-i=2', '-bn', '-ci', '-sr'},
        }
      end,
    },
    lua = {
      function()
        return {
          exe = 'lua-format',
          args = {'-i'},
          stdin = false,
        }
      end,
    },
    go = {
      function()
        return {
          exe = 'gofmt',
          args = {'-w'},
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
          args = {'--in-place'},
          stdin = true,
        }
      end,
    },
  },
}
