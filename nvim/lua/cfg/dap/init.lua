local util = require('utl.util')

local dap_install = require('dap-install')
local dbg_list = require('dap-install.api.debuggers').get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
  dap_install.config(debugger)
end

util.safe_require('cfg.dap.node')
util.safe_require('cfg.dap.lua')
util.safe_require('cfg.dap.dap-ui')
util.safe_require('cfg.dap.virtual-text')
util.safe_require('cfg.dap.signs')

local ldr = [[<leader>x]]

local map = require('utl.mapper')({ noremap = true, silent = true })

map('n', ldr .. 'x', require('mod.dap-helper').run_dap, 'Run DAP')

map('n', ldr .. 'c', require('dap').continue, 'Continue')
map('n', ldr .. 's', require('dap').step_over, 'Step over')
map('n', ldr .. 'S', require('dap').step_into, 'Step into')
map('n', ldr .. 'u', require('dap').step_out, 'Step out')
map('n', ldr .. 'b', require('dap').toggle_breakpoint, 'Toggle breakpoint')
map(
  'n',
  ldr .. 'B',
  [[<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]],
  'Set break condition'
)
map('n', ldr .. 'l', require('dap').list_breakpoints, 'List breakpoints')
map('n', ldr .. 'r', require('dap').repl.open, 'Open REPL')
-- map('n', ldr .. 'R', require('dap').repl.run_last, 'Run last')

map('n', ldr .. 'h', require('dap.ui.widgets').hover, 'DAP hover')
-- map('n', ldr .. 'e', require('dap.ui.widgets').expression, 'Run expression')
map('n', ldr .. '?', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, 'DAP scopes')

map('n', ldr .. 'o', require('dapui').toggle, 'Toggle DAPUI')
