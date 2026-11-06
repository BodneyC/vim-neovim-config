local function neotest(path, ...)
  local args = { ... }
  return function()
    local fn = require('neotest')
    for part in path:gmatch('[^.]+') do
      fn = fn[part]
    end
    fn(unpack(args))
  end
end

return {
  {
    'vim-test/vim-test',
    init = function()
      vim.g['test#strategy'] = 'neovim'
      vim.g['test#java#maventest#file_pattern'] = [[\v([Tt]est.*|.*[Tt]est(s|Case)?).(java|kt)$]]
      vim.g['test#javascript#ava#file_pattern'] = [[\v(tests|spec)?/.*\.(js|jsx|coffee|ts|tsx)$]]
      vim.g['test#javascript#jest#file_pattern'] = [[\v(__tests__/.*|(spec|test))\.(js|jsx|coffee|ts|tsx)$]]
    end,
  },

  {
    'rcarriga/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
      'vim-test/vim-test',
      'BodneyC/neotest-bats',
      'haydenmeade/neotest-jest',
      'nvim-neotest/neotest-go',
      'rcarriga/neotest-plenary',
      'rcarriga/neotest-python',
      'rcarriga/neotest-vim-test',
      'rcasia/neotest-bash',
    },
    keys = {
      { '<leader>tr', neotest('run.run'), desc = 'Run nearest test' },
      { '<leader>td', neotest('run.run', { strategy = 'dap' }), desc = 'Debug nearest test' },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        desc = 'Run test file',
      },
      { '<leader>tp', neotest('output_panel.toggle'), desc = 'Test output panel' },
      { '<leader>t|', neotest('summary.toggle'), desc = 'Test summary' },
      { '<leader>tS', neotest('summary.toggle'), desc = 'Test summary' },
      { ']t', neotest('jump.next'), desc = 'Next test' },
      { '[t', neotest('jump.prev'), desc = 'Prev test' },
      { ']T', neotest('jump.next', { status = 'failed' }), desc = 'Next failed test' },
      { '[T', neotest('jump.prev', { status = 'failed' }), desc = 'Prev failed test' },
    },
    config = function()
      require('neotest').setup({
        status = { virtual_text = false, signs = true },
        adapters = {
          require('neotest-bash'),
          require('neotest-bats').setup({ use_file_as_executable = true }),
          require('neotest-go'),
          require('neotest-python')({ dap = { justMyCode = false } }),
          require('neotest-plenary'),
          require('neotest-vim-test')({ ignore_file_types = { 'python', 'vim', 'lua' } }),
          require('neotest-jest')({
            jestCommand = './node_modules/.bin/jest',
            jestConfigFile = 'custom.jest.config.ts',
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  },
}
