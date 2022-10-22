local M = {}

local neotest = require('neotest')

local function set_keymap()

  local s = {
    silent = true,
  }

  vim.keymap.set('n', '<leader>tr', neotest.run.run, s)
  vim.keymap.set('n', '<leader>td', function()
    require('neotest').run.run({
      strategy = 'dap',
    })
  end, s)
  vim.keymap.set('n', '<leader>tf', function()
    neotest.run.run(vim.fn.expand('%'))
  end, s)
  vim.keymap.set('n', '<leader>t|', neotest.summary.toggle, s)
  vim.keymap.set('n', '<leader>tS', neotest.summary.toggle, s)
  vim.keymap.set('n', ']t', neotest.jump.next, s)
  vim.keymap.set('n', '[t', neotest.jump.prev, s)
end

function M.init()
  vim.diagnostic.config({
    virtual_text = false,
  })
  set_keymap()
end

return M
