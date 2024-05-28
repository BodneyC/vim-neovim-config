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
