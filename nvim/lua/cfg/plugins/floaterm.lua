local terminal = require('mod.terminal')
local fn_store = require('utl.fn_store')
local flags = require('utl.maps').flags
local util = require('utl.util')

local skm = vim.api.nvim_set_keymap

skm('n', '<leader>tn', fn_store.store_fn_map(function()
  terminal.set_terminal_direction()
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

skm('t', 'jj', fn_store.store_fn_map(function()
  util.feedkeys('<C-\\><C-n>', 'n')
  if vim.bo.ft == 'floaterm' then
    vim.cmd([[FloatermToggle]])
  end
end), flags.ns)

skm('n', '<leader>tf', '<CMD>FloatermNew --wintype=float --autoclose=2<CR>',
  flags.ns)
skm('n', '<leader>tt', '<CMD>FloatermToggle<CR>', flags.ns)
skm('n', '<leader>tl', '<CMD>FloatermNext<CR>', flags.ns)
skm('n', '<leader>th', '<CMD>FloatermPrev<CR>', flags.ns)
