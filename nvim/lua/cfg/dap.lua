local skm = vim.api.nvim_set_keymap

local n_s = {noremap = true, silent = true}

vim.fn.sign_define('DapBreakpoint', {
  text = '🛑',
  texthl = 'DiffDelete',
  linehl = '',
  numhl = '',
})

-- mappings
local dbg_ldr = [[<leader>x]]

-- skm('n', dbg_ldr .. 'r', [[<Cmd>lua require('dap').run()<CR>]], n_s)
skm('n', dbg_ldr .. 'c', [[<CMD>lua require('dap').continue()<CR>]], n_s)
skm('n', dbg_ldr .. 's', [[<Cmd>lua require('dap').step_over()<CR>]], n_s)
skm('n', dbg_ldr .. 'S', [[<Cmd>lua require('dap').step_into()<CR>]], n_s)
skm('n', dbg_ldr .. 'u', [[<Cmd>lua require('dap').step_out()<CR>]], n_s)
skm('n', dbg_ldr .. 'b', [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]],
  n_s)
skm('n', dbg_ldr .. 'B',
  [[<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]],
  n_s)
skm('n', dbg_ldr .. 'l', [[<Cmd>lua require('dap').list_breakpoints()<CR>]], n_s)
skm('n', dbg_ldr .. 'o', [[<Cmd>lua require('dap').repl.open()<CR>]], n_s)
skm('n', dbg_ldr .. 'R', [[<Cmd>lua require('dap').repl.run_last()<CR>]], n_s)

-- setup
local dap_install = require('dap-install')
local dbg_list = require('dap-install.debuggers_list').debuggers

for debugger, _ in pairs(dbg_list) do
  dap_install.config(debugger, {})
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
  callback({type = 'server', host = config.host, port = config.port})
end

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
