local vim = vim

local bskm = vim.api.nvim_buf_set_keymap

local M = {}

M.init = function()
  bskm(0, '<C-u>', 'cc', {})
end

return M
