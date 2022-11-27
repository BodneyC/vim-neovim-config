local lspconfig = require 'lspconfig'
local home = vim.loop.os_homedir()
local add_to_default = require 'cfg.lsp.langs.default'.add_to_default
-- npm i -g diagnostic-languageserver
return function()
  lspconfig.diagnosticls.setup(add_to_default {
    filetypes = { 'pkgbuild', 'terraform', 'sh', 'zsh', 'markdown' },
    init_options = {
      filetypes = {
        pkgbuild = 'pkgbuild',
        terraform = 'terraform',
        zsh = 'shellcheck_zsh',
        sh = 'shellcheck',
        markdown = 'markdown',
      },
      formatFiletypes = { sh = 'shfmt', zsh = 'shfmt' },
      -- package-manager - shfmt
      formatters = {
        shfmt = { args = { '-i=2', '-bn', '-ci', '-sr' }, command = 'shfmt' },
      },
      linters = {
        markdown = {
          -- npm i -g markdownlint
          command = 'markdownlint',
          args = { '--stdin' },
          isStderr = true,
          isStdout = false,
          formatPattern = {
            -- README.md:3:81 MD013/line-length Line length [Expected: 80; Actual: 282]
            '^[^:]+(:)(\\d+):?(\\d*)\\s+(.*)$',
            { security = 1, line = 2, column = 3, message = 4 },
          },
          offsetColumn = 0,
          offsetLine = 0,
          securities = { error = 'error', note = 'info', warning = ':' },
          sourceName = 'markdown',
        },
        pkgbuild = {
          args = { '%file' },
          -- manual - vim-pkgbuild
          command = home ..
              '/.local/share/nvim/plugged/vim-pkgbuild/scripts/shellcheck_pkgbuild.sh',
          formatPattern = {
            '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
            { column = 2, line = 1, message = 4, security = 3 },
          },
          securities = { error = 'error', note = 'info', warning = 'warning' },
          sourceName = 'pkgbuild',
        },
        shellcheck = {
          args = { '--format=gcc', '-x', '-' },
          -- package-manager - shellcheck
          command = 'shellcheck',
          debounce = 100,
          formatLines = 1,
          formatPattern = {
            '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
            {
              column = 2,
              endColumn = 2,
              endLine = 1,
              line = 1,
              message = 4,
              security = 3,
            },
          },
          offsetColumn = 0,
          offsetLine = 0,
          securities = { error = 'error', note = 'info', warning = 'warning' },
          sourceName = 'shellcheck',
        },
        shellcheck_zsh = {
          args = { '--shell=bash', '--format=gcc', '-x', '-' },
          -- package-manager - shellcheck
          command = 'shellcheck',
          debounce = 100,
          formatLines = 1,
          formatPattern = {
            '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
            {
              column = 2,
              endColumn = 2,
              endLine = 1,
              line = 1,
              message = 4,
              security = 3,
            },
          },
          offsetColumn = 0,
          offsetLine = 0,
          securities = { error = 'error', note = 'info', warning = 'warning' },
          sourceName = 'shellcheck_zsh',
        },
      },
    },
  })
end
