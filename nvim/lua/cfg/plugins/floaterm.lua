local fn_store = require('utl.fn_store')
local flags = require('utl.maps').flags

local skm = vim.api.nvim_set_keymap

skm('n', '<leader>tn', fn_store.store_fn(function()
  local wintype = 'vsplit'
  if vim.g.term_direction == 0 then
    wintype = 'split'
  end
  local parts = {
    'FloatermNew',
    '--wintype=' .. wintype,
    '--height=0.3',
    '--width=0.4',
    '--autoclose=2',
  }
  vim.cmd(table.concat(parts, ' '))
end), flags.ns)

skm('n', '<leader>tf', '<CMD>FloatermNew --wintype=float --autoclose=2<CR>', flags.ns)
skm('n', '<leader>tt', '<CMD>FloatermToggle<CR>', flags.ns)
skm('n', '<leader>tl', '<CMD>FloatermNext<CR>', flags.ns)
skm('n', '<leader>th', '<CMD>FloatermPrev<CR>', flags.ns)
