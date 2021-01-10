local vim = vim
local util = require'utl.util'
local bskm = vim.api.nvim_buf_set_keymap

local M = {}

M.init = function()
  vim.wo.conceallevel = 2
  vim.wo.concealcursor = ''
  util.exec([[
    let @t = "mzvip:EasyAlign *|\<CR>`z"
    let @h = "YpVr="
  ]])
  bskm(0, 'n', 'o', 'A\x0D', { noremap = true, silent = true })
  bskm(0, 'n', '<leader>S', '1z=', { noremap = true, silent = true })
end

return M
