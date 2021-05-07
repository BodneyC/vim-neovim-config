local vim = vim
local util = require 'utl.util'
local bskm = vim.api.nvim_buf_set_keymap

local M = {}

local n_s = {noremap = true, silent = true}
local n_s_e = {noremap = true, silent = true, expr = true}

local tab = function()
  if vim.fn.getline('.'):match('%s-%s') then
    return '<C-o>>>A'
  else
    return '<Tab>'
  end
end

function M.init()
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
  bskm(0, 'i', '<Tab>', string.gsub([[
    pumvisible()
      ? "\<C-n>"
      : (!(col('.') - 1) || getline('.')[col('.') - 2]  =~ '\s')
        ? (getline('.') =~ '^\s*-\s*')
          ? "\<C-o>>>\<C-o>A "
          : "\<Tab>"
        : compe#complete()
  ]], '\n', ''), n_s_e)
end

return M
