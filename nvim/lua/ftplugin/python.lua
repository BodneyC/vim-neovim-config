local vim = vim

local M = {}

M.init = function()
  vim.bo.formatprg = 'autopep8 -'
end

return M
