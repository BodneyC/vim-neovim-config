local vim = vim
local util = require'utl.util'

local M = {}

M.init = function()
  util.exec([[
    let @t="mzvipo |j e* `z"
    let @j="Ji |"
  ]])
end

return M
