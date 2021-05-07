local vim = vim
local util = require'utl.util'

local M = {}

function M.init()
  util.exec([[
    let @t="mzvipo |j e* `z"
    let @j="Ji |"
  ]])
end

return M
