local bskm = vim.api.nvim_buf_set_keymap

local M = {}

function M.init()
  bskm(0, 'n', '<C-u>', 'cc', {})
end

return M
