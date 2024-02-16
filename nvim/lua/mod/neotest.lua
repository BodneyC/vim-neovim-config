local M = {}

local neotest = require('neotest')
local km = require('utl.mapper')

local map = km({ noremap = true, silent = true })

local function set_keymap()
  local s = {
    silent = true,
  }

  map('n', '<leader>tr', neotest.run.run, 'run test', s)
  map('n', '<leader>td', function()
    require('neotest').run.run({
      strategy = 'dap',
    })
  end, 'debug test', s)
  map('n', '<leader>tf', function()
    neotest.run.run(vim.fn.expand('%'))
  end, 'test file', s)
  map('n', '<leader>to', neotest.output_panel.toggle, 'test output panel', s)
  map('n', '<leader>t|', neotest.summary.toggle, 'test summary', s)
  map('n', '<leader>tS', neotest.summary.toggle, 'test summary', s)
  map('n', ']t', neotest.jump.next, 'next summary', s)
  map('n', '[t', neotest.jump.prev, 'prev summary', s)
  map('n', ']T', function() neotest.jump.next { status = 'failed' } end, 'next summary', s)
  map('n', '[T', function() neotest.jump.prev { status = 'failed' } end, 'next summary', s)
end

function M.init()
  -- vim.diagnostic.config({
  --   virtual_text = false,
  -- })
  set_keymap()
end

return M
