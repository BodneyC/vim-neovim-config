local vim = vim
local util = require'utl.util'

local M = {}

function M.init()
  vim.cmd([[
    let @t="mzvipo |j e* `z"
    let @j="Ji |"
  ]])
end

return M
