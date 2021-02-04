local vim = vim
local util = require'utl.util'
local bskm = vim.api.nvim_buf_set_keymap

local M = {}

local n_s = { noremap = true, silent = true }

M.init = function()
  vim.wo.conceallevel = 2
  vim.wo.concealcursor = ''
  bskm(0, 'n', 'j', 'gj', n_s)
  bskm(0, 'n', 'k', 'gk', n_s)
  bskm(0, 'n', 'gj', 'j', n_s)
  bskm(0, 'n', 'gk', 'k', n_s)
  util.exec([[
    let @t = "mzvip:EasyAlign *|\<CR>`z"
    let @h = "YpVr="
  ]])
  bskm(0, 'n', 'o', 'A\x0D', n_s)
  bskm(0, 'n', '<leader>S', '1z=', n_s)
end

return M
