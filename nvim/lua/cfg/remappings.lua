vim.cmd('let mapleader=" "')

--- Leave unmapped for which-key
-- vim.keymap.set('n', '<leader>', '<NOP>')

local mapper = require('utl.mapper')
local map = mapper({ noremap = true, silent = true })

map('n', [[\]], [[<CMD>WhichKey \<CR>]])

map('n', '<leader>e', [[<CMD>e<CR>]], 'Edit')
map('n', '<leader>q', [[<CMD>q<CR>]], 'Quit')
map('n', '<leader>Q', [[<CMD>qa!<CR>]], 'Force quit')
map('n', '<leader>w', [[<CMD>w<CR>]], 'Write')
map('n', '<leader>W', [[<CMD>wa | qa<CR>]], 'Force write')

map('n', 'Q', [[q]])
map('n', 'Q!', [[q!]])
map('n', '<F1>', [[:H <C-r><C-w><CR>]], 'Help under cursor')
map('n', '<F2>', [[<CMD>syn sync fromstart<CR>]], 'Resync syntax')
map('n', '<F7>', [[<CMD>set spell!<CR>]], 'Toggle spell')
map('i', '<F7>', [[<C-o>:set spell!<CR>]])

map('i', '<C-w>', '<C-S-w>')

map('n', 'Y', 'yy')
for _, ch in ipairs({ 'y', 'Y', 'p', 'P' }) do
  local action = ((ch == 'y' or ch == 'Y') and 'Copy to' or 'Paste from') .. ' clipboard'
  map('n', '<leader>' .. ch, '"+' .. ch, action)
  map('x', '<leader>' .. ch, '"+' .. ch, action)
end

map('n', '<C-p>', [[<Tab>]])
map('n', '<leader>*', [[:%s/\<<C-r><C-w>\>//g<left><left>]], 'Replace under cursor', { silent = false })
map('n', '<leader>/', [[<Cmd>noh<CR>]], 'Remove highlight')

-- NOTE: Doesn't work with `vim.keymap.set`
-- NOTE: Also works with vim.cmd([[nmap gcc]])
vim.api.nvim_set_keymap('n', '<C-/>', [[gcc]], {})
vim.api.nvim_set_keymap('x', '<C-/>', [[gc]], {})
vim.api.nvim_set_keymap('i', '<C-/>', [[<C-o>gcc]], {})
vim.api.nvim_set_keymap('n', '', [[gcc]], {})
vim.api.nvim_set_keymap('x', '', [[gc]], {})
vim.api.nvim_set_keymap('i', '', [[<C-o>gcc]], {})

map('n', '<leader>2', [[<CMD>sbn<CR>]], 'Split')
map('n', '<leader>5', [[<CMD>vert sbn<CR>]], 'Vertical split')
map('n', '<leader>bD', require('mod.functions').bufonly, 'Delete other buffers')
map('n', '<leader>be', [[<CMD>enew<CR>]], 'New file')
map('n', '<leader>bd', [[<CMD>Bdelete<CR>]], 'Delete buffer')

map('n', '<leader>m', [[<CMD>NoiceDismiss<CR>]], 'Dismiss Noice messages')

-- resize

local util = require('utl.util')
map({ 'n', 't' }, '<C-M-h>', function() return util.resize_window('h') end)
map({ 'n', 't' }, '<C-M-j>', function() return util.resize_window('j') end)
map({ 'n', 't' }, '<C-M-k>', function() return util.resize_window('k') end)
map({ 'n', 't' }, '<C-M-l>', function() return util.resize_window('l') end)

-- line movement
map('n', '<S-down>', [[<CMD>m+<CR>]])
map('n', '<S-up>', [[<CMD>m-2<CR>]])
map('n', '<S-Tab>', [[<CMD>bp<CR>]])
map('n', '<Tab>', [[<CMD>bn<CR>]])
map('i', '<S-down>', [[<C-o>:m+<CR>]])
map('i', '<S-up>', [[<C-o>:m-2<CR>]])
map('x', '<S-down>', [[:m'>+<CR>gv=gv]])
map('x', '<S-up>', [[:m-2<CR>gv=gv]])

map('x', '>', [[>gv]])
map('x', '<', [[<gv]])
map('x', '<Tab>', [[>gv]])
map('x', '<S-Tab>', [[<gv]])

map('n', '<leader>ge', [[<CMD>Ge:<CR>]], 'Git edit')
map('n', '<leader>}', [[zf}]], 'Fold to blank line')

map(
  'n', '<leader>i',
  function() return require('utl.util').toggle_bool_option('o', 'ignorecase') end,
  'Toggle case sensitive'
)

map('n', '<leader>ea', [[vip:EasyAlign<CR>]], 'Easy align paragraph')
map('x', '<leader>ea', [[:EasyAlign<CR>]], 'Easy align')

map('n', '<leader>U', [[:UndotreeToggle<CR>]], 'Undo tree')

map('n', '<leader>H', function()
  return require('mod.terminal').floating_help(vim.fn.expand('<cword>'))
end, 'Help under cursor')

map('v', '<up>', '<Plug>SchleppUp', nil, { unique = true })
map('v', '<down>', '<Plug>SchleppDown', nil, { unique = true })
map('v', '<left>', '<Plug>SchleppLeft', nil, { unique = true })
map('v', '<right>', '<Plug>SchleppRight', nil, { unique = true })

map('n', '<leader>F', function() vim.cmd [[Format]] end, 'Format', { unique = true })

local npairs = require('nvim-autopairs')

local function getline(bufnr, row)
  return vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ''
end

function _G.master_bs()
  if vim.bo.buftype ~= '' then return npairs.esc('<BS>') end
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local current_line = getline(bufnr, row)
  -- Current line is blank to cursor
  if current_line:sub(0, col):match('%S') == nil then
    local previous_line = getline(bufnr, row - 1)
    -- All of previous line is blank
    if previous_line:match('%S') == nil then
      -- All of current line is blank
      if current_line:match('%S') == nil then
        return npairs.esc('<Esc>:silent exe line(\'.\') - 1 . \'delete\'<CR>S')
      else -- Part of current line is not blank
        return npairs.esc('<C-o>:silent exe line(\'.\') - 1 . \'delete\'<CR>')
      end
    end
    -- The previous line has text
    if col == 0 then
      return npairs.esc('<C-w>')
    else
      return npairs.esc('<C-w><BS>')
    end
  end
  return npairs.autopairs_bs(bufnr)
end

vim.api.nvim_set_keymap('i', '<BS>', 'v:lua.master_bs()', {
  silent = true,
  expr = true,
  noremap = true,
})
