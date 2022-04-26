local util = require('utl.util')

util.safe_require('cfg.dap.dap')
util.safe_require('cfg.dap.dap-ui')
util.safe_require('cfg.dap.virtual-text')
util.safe_require('cfg.dap.signs')

local ldr = [[<leader>x]]

local s = require('utl.maps').flags.s

vim.keymap.set('n', ldr .. 'x', require('mod.dap-helper').run_dap, s)

vim.keymap.set('n', ldr .. 'c', require('dap').continue, s)
vim.keymap.set('n', ldr .. 's', require('dap').step_over, s)
vim.keymap.set('n', ldr .. 'S', require('dap').step_into, s)
vim.keymap.set('n', ldr .. 'u', require('dap').step_out, s)
vim.keymap.set('n', ldr .. 'b', require('dap').toggle_breakpoint, s)
vim.keymap.set('n', ldr .. 'B',
  [[<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]],
  s)
vim.keymap.set('n', ldr .. 'l', require('dap').list_breakpoints, s)
vim.keymap.set('n', ldr .. 'r', require('dap').repl.open, s)
-- vim.keymap.set('n', ldr .. 'R', require('dap').repl.run_last, s)

vim.keymap.set('n', ldr .. 'h', require('dap.ui.widgets').hover, s)
-- vim.keymap.set('n', ldr .. 'e', require('dap.ui.widgets').expression, s)
vim.keymap.set('n', ldr .. '?', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, s)

vim.keymap.set('n', ldr .. 'o', require('dapui').open, s)
vim.keymap.set('n', ldr .. 'O', require('dapui').close, s)

require('which-key').register({
  x = {
    x = 'Dap run',
    c = 'Dap continue',
    s = 'Dap step over',
    S = 'Dap step into',
    u = 'Dap step out',
    b = 'Dap toggle breakpoint',
    B = 'Dap set breakpoint',
    l = 'Dap list breakpoints',
    r = 'Dap repl open',
    -- R = 'Dap repl run last',
    h = 'Dap hover',
    -- e = 'Dap expr',
    ['?'] = 'Dap scopes',
    o = 'DapUI open',
    O = 'DapUI close',
  },
}, {
  prefix = '<leader>',
})
