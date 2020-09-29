local vim = vim

local M = {}

function M.init()
  vim.bo.tags = (vim.o.tags and vim.o.tags .. ';' or '') .. os.getenv('HOME') .. '/go/src'
end

return M
