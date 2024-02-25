local dap = require('dap')

-- git clone https://github.com/microsoft/vscode-js-debug
-- cd vscode-js-debug
-- npm i --legacy-peer-deps
-- npm run compile
require('dap-vscode-js').setup({
  debugger_path = os.getenv('HOME') .. '/software/vscode-js-debug',
  adapters = {
    'pwa-node',
    'pwa-chrome',
    'pwa-msedge',
    'node-terminal',
    'pwa-extensionHost',
  },
})

for _, language in ipairs({ 'typescript', 'javascript' }) do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
    -- NOTE: This is included *in* neotest-jest, specifying it here does nothing
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Debug Jest Tests',
      -- trace = true, -- include debugger info
      runtimeExecutable = 'node',
      runtimeArgs = { './node_modules/jest/bin/jest.js', '--runInBand' },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      console = 'integratedTerminal',
      internalConsoleOptions = 'neverOpen',
      -- NOTE: These would solve the "no sourcemaps" things... see above
      skipFiles = { '<node_internals>/**' },
      sourceMaps = true,
      resolveSourceMapLocations = { '${workspaceFolder}/', '!/node_modules/**' },
    },
  }
end

--  git clone https://github.com/microsoft/vscode-node-debug2.git
--  cd vscode-node-debug2
--  npm install
--  gulp build
-- dap.adapters.node2 = {
--   type = 'executable',
--   command = 'node',
--   args = {
--     os.getenv('HOME') .. '/software/vscode-node-debug2/out/src/nodeDebug.js',
--   },
-- }
-- dap.configurations.javascript = {
--   {
--     type = 'node2',
--     request = 'launch',
--     program = '${workspaceFolder}/${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal',
--   },
-- }
-- dap.configurations.typescript = dap.configurations.javascript

-- dap.adapters.chrome = {
--   type = 'executable',
--   command = 'node',
--   args = {
--     os.getenv('HOME') .. '/.local/share/nvim/dapinstall/chrome/vscode-chrome-debug/src/chromeDebug.ts',
--   },
-- }

-- dap.configurations.javascript = {
--   {
--     type = 'chrome',
--     request = 'attach',
--     program = '${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     port = 9222,
--     webRoot = '${workspaceFolder}',
--   },
-- }

-- dap.configurations.typescript = {
--   {
--     type = 'chrome',
--     request = 'attach',
--     program = '${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     port = 9222,
--     webRoot = '${workspaceFolder}',
--   },
-- }
