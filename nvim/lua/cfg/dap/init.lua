local util = require('utl.util')

util.safe_require('cfg.dap.dap')
util.safe_require('cfg.dap.dap-ui')
util.safe_require('cfg.dap.virtual-text')
util.safe_require('cfg.dap.signs')

local skm = vim.api.nvim_set_keymap

local ldr = [[<leader>x]]

local store = require('utl.fn_store')
local ns = require('utl.maps').flags.ns

skm('n', ldr .. 'x', store.fn(require('mod.dap-helper').run_dap), ns)

skm('n', ldr .. 'c', store.fn(require('dap').continue), ns)
skm('n', ldr .. 's', store.fn(require('dap').step_over), ns)
skm('n', ldr .. 'S', store.fn(require('dap').step_into), ns)
skm('n', ldr .. 'u', store.fn(require('dap').step_out), ns)
skm('n', ldr .. 'b', store.fn(require('dap').toggle_breakpoint), ns)
skm('n', ldr .. 'B',
  [[<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]],
  ns)
skm('n', ldr .. 'l', store.fn(require('dap').list_breakpoints), ns)
skm('n', ldr .. 'r', store.fn(require('dap').repl.open), ns)
skm('n', ldr .. 'R', store.fn(require('dap').repl.run_last), ns)

skm('n', ldr .. 'h', store.fn(require('dap.ui.widgets').hover), ns)
skm('n', ldr .. 'e', store.fn(require('dap.ui.widgets').expression),
  ns)
skm('n', ldr .. '?', store.fn(function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end), ns)

skm('n', ldr .. 'o', store.fn(require('dapui').open), ns)
skm('n', ldr .. 'O', store.fn(require('dapui').close), ns)
