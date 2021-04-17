local vim = vim

local M = {}

M.init = function()
  vim.bo.tags = (vim.o.tags and vim.o.tags .. ';' or '') .. os.getenv('HOME') .. '/go/src'
  vim.bo.expandtab = false
end

return M
