require('neotest').setup({
  diagnostic = { enabled = true },
  status = { enabled = true, virtual_text = false, signs = true },
  adapters = {
    require('neotest-bash'),
    require('neotest-python')({ dap = { justMyCode = false } }),
    require('neotest-plenary'),
    require('neotest-vim-test')(
      { ignore_file_types = { 'python', 'vim', 'lua' } }),
    require('neotest-jest')({
      jestCommand = './node_modules/.bin/jest',
      jestConfigFile = 'custom.jest.config.ts',
      env = { CI = true },
      cwd = function(_) vim.fn.getcwd() end,
    }),
  },
})
