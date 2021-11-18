local util = require('utl.util')

util.safe_require('cfg.dap.dap')
util.safe_require('cfg.dap.dap-ui')
util.safe_require('cfg.dap.virtual-text')
util.safe_require('cfg.dap.signs')

local skm = vim.api.nvim_set_keymap

local dbg_ldr = [[<leader>x]]

local ns = require('utl.maps').flags.ns

-- skm('n', dbg_ldr .. 'r', [[<Cmd>lua require('dap').run()<CR>]], ns)
skm('n', dbg_ldr .. 'c', [[<CMD>lua require('dap').continue()<CR>]], ns)
skm('n', dbg_ldr .. 's', [[<Cmd>lua require('dap').step_over()<CR>]], ns)
skm('n', dbg_ldr .. 'S', [[<Cmd>lua require('dap').step_into()<CR>]], ns)
skm('n', dbg_ldr .. 'u', [[<Cmd>lua require('dap').step_out()<CR>]], ns)
skm('n', dbg_ldr .. 'b', [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]], ns)
skm('n', dbg_ldr .. 'B',
  [[<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]],
  ns)
skm('n', dbg_ldr .. 'i', [[:lua require('dap.ui.variables').hover()<CR>]], ns)
skm('n', dbg_ldr .. 'i', [[:lua require('dap.ui.variables').visual_hover()<CR>]], ns)
skm('n', dbg_ldr .. '?', [[:lua require('dap.ui.variables').scopes()<CR>]], ns)
skm('n', dbg_ldr .. 'l', [[<Cmd>lua require('dap').list_breakpoints()<CR>]], ns)
skm('n', dbg_ldr .. 'r', [[<Cmd>lua require('dap').repl.open()<CR>]], ns)
skm('n', dbg_ldr .. 'R', [[<Cmd>lua require('dap').repl.run_last()<CR>]], ns)

skm('n', dbg_ldr .. 'o', [[<Cmd>lua require('dapui').open()<CR>]], ns)
skm('n', dbg_ldr .. 'O', [[<Cmd>lua require('dapui').close()<CR>]], ns)
