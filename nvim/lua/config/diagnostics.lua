local icons = require('config.icons').diagnostics
local severity = vim.diagnostic.severity

vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = icons.error,
      [severity.WARN] = icons.warn,
      [severity.INFO] = icons.info,
      [severity.HINT] = icons.hint,
    },
    linehl = {
      [severity.ERROR] = 'DiagnosticSignError',
      [severity.WARN] = 'DiagnosticSignWarn',
      [severity.INFO] = 'DiagnosticSignInfo',
      [severity.HINT] = 'DiagnosticSignHint',
    },
  },
})

local map = require('util').map
map('n', '[w', function()
  vim.diagnostic.jump({ count = -1 })
end, 'Prev diagnostic')
map('n', ']w', function()
  vim.diagnostic.jump({ count = 1 })
end, 'Next diagnostic')
map('n', '[W', function()
  vim.diagnostic.jump({ count = -1, severity = severity.ERROR })
end, 'Prev error')
map('n', ']W', function()
  vim.diagnostic.jump({ count = 1, severity = severity.ERROR })
end, 'Next error')
map('n', '<leader>dq', vim.diagnostic.setloclist, 'Diagnostics to loclist')
map('n', '<leader>dv', function()
  vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end, 'Toggle diagnostic virtual lines')
