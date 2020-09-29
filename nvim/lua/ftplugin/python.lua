local vim = vim

local M = {}

function M.init()
  vim.bo.formatprg = 'autopep8 -'
end

return M
