local vim = vim

local bskm = vim.api.nvim_buf_set_keymap

local M = {}

M.init = function()
  local n_s = {noremap = true, silent = true}
  bskm(0, 'n', 'e', [[<Cmd>enew<CR>]], n_s)
  bskm(0, 'n', 'c', [[<Cmd>call dashboard#telescope#change_colorscheme()<CR>]], n_s)
  bskm(0, 'n', 'f', [[<Cmd>call dashboard#telescope#find_file()<CR>]], n_s)
  bskm(0, 'n', 'a', [[<Cmd>call dashboard#telescope#find_word()<CR>]], n_s)
  bskm(0, 'n', 'b', [[<Cmd>call dashboard#telescope#bookmarks()<CR>]], n_s)
  bskm(0, 'n', 'h', [[<Cmd>call dashboard#telescope#find_history()<CR>]], n_s)
  bskm(0, 'n', 'q', [[<Cmd>q<CR>]], n_s)
  bskm(0, 'n', 'd', [[<Cmd>bd<CR>]], n_s)
end

return M
