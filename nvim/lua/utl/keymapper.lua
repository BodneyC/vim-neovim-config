local M = {}

M.which_key = require 'which-key'

local map_opts = { noremap = true, silent = true }

function M.map(mode, key, cmd, desc)
  vim.keymap.set(mode, key, cmd, map_opts)
  if desc then M.which_key.register({ [key] = { desc } }, { mode = mode }) end
end

function M.buf_keymapper(bufnr)

  local bm = {}
  local buf_map_opts = vim.tbl_deep_extend('force', map_opts, { buffer = bufnr })

  function bm.map(mode, key, cmd, _desc)
    vim.keymap.set(mode, key, cmd, buf_map_opts)
    -- NOTE: This is turning out to be very slow
    -- if desc then
    --   M.which_key
    --       .register({ [key] = { desc } }, { mode = mode, buffer = bufnr })
    -- end
  end

  return bm

end

return M
