local icons = require('mod.theme').icons

vim.fn.sign_define('DapBreakpoint', {
  text = icons.dap.breakpoint,
  texthl = '',
  linehl = '',
  numhl = '',
})
vim.fn.sign_define('DapBreakpointCondition', {
  text = icons.dap.breakpoint_condition,
  texthl = '',
  linehl = '',
  numhl = '',
})
vim.fn.sign_define('DapBreakpointRejected', {
  text = icons.dap.breakpoint_rejected,
  texthl = '',
  linehl = '',
  numhl = '',
})
vim.fn.sign_define('DapLogPoint', {
  text = icons.dap.log_point,
  texthl = '',
  linehl = '',
  numhl = '',
})
