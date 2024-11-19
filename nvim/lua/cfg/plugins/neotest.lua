local function set_keymap()
  local km = require('utl.mapper')
  local map = km({ noremap = true, silent = true })

  local s = { silent = true }

  local neotest = require('neotest')

  map('n', '<leader>tr', neotest.run.run, 'run test', s)
  map('n', '<leader>td', function()
    require('neotest').run.run({
      strategy = 'dap',
    })
  end, 'debug test', s)
  map('n', '<leader>tf', function()
    neotest.run.run(vim.fn.expand('%'))
  end, 'test file', s)
  map('n', '<leader>tp', neotest.output_panel.toggle, 'test output panel', s)
  map('n', '<leader>t|', neotest.summary.toggle, 'test summary', s)
  map('n', '<leader>tS', neotest.summary.toggle, 'test summary', s)
  map('n', ']t', neotest.jump.next, 'next summary', s)
  map('n', '[t', neotest.jump.prev, 'prev summary', s)
  map('n', ']T', function()
    neotest.jump.next({ status = 'failed' })
  end, 'next summary', s)
  map('n', '[T', function()
    neotest.jump.prev({ status = 'failed' })
  end, 'next summary', s)
end

return {
  'rcarriga/neotest',
  config = function()
    require('neotest').setup({
      log_level = vim.log.levels.DEBUG,
      diagnostic = { enabled = true },
      status = { enabled = true, virtual_text = false, signs = true },
      adapters = {
        require('neotest-bash'),
        require('neotest-bats').setup({
          use_file_as_executable = true,
        }),
        require('neotest-go'),
        require('neotest-python')({ dap = { justMyCode = false } }),
        require('neotest-plenary'),
        require('neotest-vim-test')({
          ignore_file_types = { 'python', 'vim', 'lua' },
        }),
        require('neotest-jest')({
          jestCommand = './node_modules/.bin/jest',
          jestConfigFile = 'custom.jest.config.ts',
          env = { CI = true },
          cwd = function(_)
            vim.fn.getcwd()
          end,
        }),
      },
    })
    set_keymap()
  end,
  dependencies = {
    'nvim-neotest/neotest-go',
    'antoinemadec/FixCursorHold.nvim',
    'haydenmeade/neotest-jest',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'rcarriga/neotest-plenary',
    'rcarriga/neotest-python',
    'rcarriga/neotest-vim-test',
    'rcasia/neotest-bash',
    'BodneyC/neotest-bats',
  },
}
