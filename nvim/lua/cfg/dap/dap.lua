require('telescope').load_extension('dap')

local dap_install = require('dap-install')
local dbg_list = require('dap-install.api.debuggers').get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
  dap_install.config(debugger)
end

local dap = require('dap')
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= '' then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: '))
      assert(val, 'Please provide a port number')
      return val
    end,
  },
}

dap.adapters.nlua = function(callback, config)
  callback({
    type = 'server',
    host = config.host,
    port = config.port,
  })
end

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

--  git clone https://github.com/microsoft/vscode-node-debug2.git
--  cd vscode-node-debug2
--  npm install
--  gulp build
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {
    os.getenv('HOME') ..
      '/.local/share/nvim/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js',
  },
}
dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}
