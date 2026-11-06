local util = require('util')
local map = util.map

map('n', '\\', '<Cmd>WhichKey \\<CR>')

map('n', '<leader>e', '<Cmd>edit<CR>', 'Edit')
map('n', '<leader>q', '<Cmd>quit<CR>', 'Quit')
map('n', '<leader>Q', '<Cmd>quitall!<CR>', 'Force quit')
map('n', '<leader>w', '<Cmd>write<CR>', 'Write')
map('n', '<leader>W', '<Cmd>ClearUnlisted<CR><Cmd>wall | quitall<CR>', 'Write all and quit', { silent = false })

map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', 'gj', 'j')
map('n', 'gk', 'k')

map('n', 'Q', 'q')
map('n', 'Q!', 'q!')
map('n', '<F1>', ':H <C-r><C-w><CR>', 'Help under cursor')
map('n', '<F2>', '<Cmd>syntax sync fromstart<CR>', 'Resync syntax')
map({ 'n', 'i' }, '<F7>', '<Cmd>setlocal spell!<CR>', 'Toggle spell')

map('i', '<C-a>', '<Esc>A')
map('i', '<C-e>', '<C-o><C-e>')
map('i', '<C-y>', '<C-o><C-y>')
map('i', '<C-w>', '<C-S-w>')

map('n', 'Y', 'yy')
for _, key in ipairs({ 'y', 'Y', 'p', 'P' }) do
  local desc = key:lower() == 'y' and 'Copy to clipboard' or 'Paste from clipboard'
  map({ 'n', 'v' }, '<leader>' .. key, '"+' .. key, desc)
end

map('n', '<C-p>', '<Tab>')
map('n', '<leader>*', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], 'Replace under cursor', { silent = false })
map('n', '<leader>/', function()
  vim.cmd.nohlsearch()
  if vim.fn.exists(':NoiceDismiss') == 2 then
    vim.cmd.NoiceDismiss()
  end
end, 'Remove highlight')

for _, lhs in ipairs({ '<C-/>', '<C-_>' }) do
  map('n', lhs, 'gcc', 'Toggle comment', { remap = true })
  map('x', lhs, 'gc', 'Toggle comment', { remap = true })
  map('i', lhs, '<C-o>gcc', 'Toggle comment', { remap = true })
end

map('n', '<leader>2', '<Cmd>sbnext<CR>', 'Split')
map('n', '<leader>5', '<Cmd>vertical sbnext<CR>', 'Vertical split')
map('n', '<leader>bD', util.wipe_hidden_buffers, 'Delete other buffers')
map('n', '<leader>be', '<Cmd>enew<CR>', 'New file')

for _, dir in ipairs({ 'h', 'j', 'k', 'l' }) do
  map({ 'n', 't' }, '<C-M-' .. dir .. '>', function()
    util.resize_window(dir)
  end)
end

map('n', '<S-Down>', '<Cmd>move +1<CR>')
map('n', '<S-Up>', '<Cmd>move -2<CR>')
map('i', '<S-Down>', '<Cmd>move +1<CR>')
map('i', '<S-Up>', '<Cmd>move -2<CR>')
map('x', '<S-Down>', ":move '>+1<CR>gv=gv")
map('x', '<S-Up>', ":move '<-2<CR>gv=gv")

map('n', '<Tab>', '<Cmd>bnext<CR>')
map('n', '<S-Tab>', '<Cmd>bprevious<CR>')

map('x', '>', '>gv')
map('x', '<', '<gv')
map('x', '<Tab>', '>gv')
map('x', '<S-Tab>', '<gv')

map('n', '<leader>}', 'zf}', 'Fold to blank line')
map('n', '<leader>i', function()
  vim.o.ignorecase = not vim.o.ignorecase
end, 'Toggle case sensitive')
