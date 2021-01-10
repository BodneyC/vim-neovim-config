local vim = vim

local M = {}

M.init = function()
  vim.bo.ts = 4
  vim.bo.comments = 's1:/*,mb:*,ex:*/,://'
  vim.bo.formatoptions = vim.bo.formatoptions .. 'cro'
end

return M

