vim.cmd('let mapleader=" "')

--- Leave unmapped for which-key
-- vim.keymap.set('n', '<leader>', '<NOP>')

vim.keymap.set('n', [[\]], [[<CMD>WhichKey \<CR>]], {})

local flags = require('utl.maps').flags

vim.keymap.set('n', '<leader>e', [[<CMD>e<CR>]], flags.s)
vim.keymap.set('n', '<leader>q', [[<CMD>q<CR>]], flags.s)
vim.keymap.set('n', '<leader>Q', [[<CMD>qa!<CR>]], flags.s)
vim.keymap.set('n', '<leader>w', [[<CMD>w<CR>]], flags.s)
vim.keymap.set('n', '<leader>W', [[<CMD>wa | qa<CR>]], flags.s)

vim.keymap.set('n', 'Q', [[q]])
vim.keymap.set('n', 'Q!', [[q!]])
vim.keymap.set('n', '<F1>', [[:H <C-r><C-w><CR>]], flags.s)
vim.keymap.set('n', '<F2>', [[<CMD>syn sync fromstart<CR>]], flags.s)
vim.keymap.set('n', '<F7>', [[<CMD>set spell!<CR>]], flags.s)
vim.keymap.set('i', '<F7>', [[<C-o>:set spell!<CR>]], flags.s)

vim.keymap.set('i', '<C-w>', '<C-S-w>', flags.s)

vim.keymap.set('n', 'Y', 'yy', flags.s)
for _, ch in ipairs({ 'y', 'Y', 'p', 'P' }) do
  vim.keymap.set('n', '<leader>' .. ch, '"+' .. ch, flags.s)
  vim.keymap.set('x', '<leader>' .. ch, '"+' .. ch, flags.s)
end

vim.keymap.set('n', '<C-p>', [[<Tab>]])
vim.keymap.set('n', '<leader>*', [[:%s/\<<C-r><C-w>\>//g<left><left>]])
vim.keymap.set('n', '<leader>/', [[<Cmd>noh<CR>]], flags.s)

-- NOTE: Doesn't work with `vim.keymap.set`
-- NOTE: Also works with vim.cmd([[nmap gcc]])
vim.api.nvim_set_keymap('n', '<C-/>', [[gcc]], {})
vim.api.nvim_set_keymap('x', '<C-/>', [[gc]], {})
vim.api.nvim_set_keymap('i', '<C-/>', [[<C-o>gcc]], {})

vim.keymap.set('n', '<leader>"', [[<CMD>sbn<CR>]], flags.s)
vim.keymap.set('n', '<leader>%', [[<CMD>vert sbn<CR>]], flags.s)
vim.keymap.set('n', '<leader>bD', require('mod.functions').bufonly, flags.s)
vim.keymap.set('n', '<leader>be', [[<CMD>enew<CR>]], flags.s)
vim.keymap.set('n', '<leader>bd', [[<CMD>Bdelete<CR>]], flags.s)

-- resize

local util = require('utl.util')
vim.keymap.set({ 'n', 't' }, '<C-M-h>', function() return util.resize_window('h') end, flags.s)
vim.keymap.set({ 'n', 't' }, '<C-M-j>', function() return util.resize_window('j') end, flags.s)
vim.keymap.set({ 'n', 't' }, '<C-M-k>', function() return util.resize_window('k') end, flags.s)
vim.keymap.set({ 'n', 't' }, '<C-M-l>', function() return util.resize_window('l') end, flags.s)

-- line movement
vim.keymap.set('n', '<S-down>', [[<CMD>m+<CR>]], flags.s)
vim.keymap.set('n', '<S-up>', [[<CMD>m-2<CR>]], flags.s)
vim.keymap.set('n', '<S-Tab>', [[<CMD>bp<CR>]], flags.s)
vim.keymap.set('n', '<Tab>', [[<CMD>bn<CR>]], flags.s)
vim.keymap.set('i', '<S-down>', [[<C-o>:m+<CR>]])
vim.keymap.set('i', '<S-up>', [[<C-o>:m-2<CR>]])
vim.keymap.set('x', '<S-down>', [[:m'>+<CR>gv=gv]])
vim.keymap.set('x', '<S-up>', [[:m-2<CR>gv=gv]])

vim.keymap.set('x', '>', [[>gv]])
vim.keymap.set('x', '<', [[<gv]])
vim.keymap.set('x', '<Tab>', [[>gv]])
vim.keymap.set('x', '<S-Tab>', [[<gv]])

-- git
vim.keymap.set('n', '<leader>ge', [[<CMD>Ge:<CR>]], flags.s)
vim.keymap.set('n', '<leader>}', [[zf}]], flags.s)

vim.keymap.set('n', '<leader>i',
  function() return require('utl.util').toggle_bool_option('o', 'ignorecase') end, flags.s)

vim.keymap.set('n', '<leader>ea', [[vip:EasyAlign<CR>]], flags.s)
vim.keymap.set('x', '<leader>ea', [[:EasyAlign<CR>]], flags.s)

vim.keymap.set('n', '<leader>U', [[:UndotreeToggle<CR>]], flags.s)

vim.keymap.set('n', '<leader>H', function()
  return require('mod.terminal').floating_help(vim.fn.expand('<cword>'))
end, flags.s)

vim.keymap.set('v', '<up>', '<Plug>SchleppUp', flags.u)
vim.keymap.set('v', '<down>', '<Plug>SchleppDown', flags.u)
vim.keymap.set('v', '<left>', '<Plug>SchleppLeft', flags.u)
vim.keymap.set('v', '<right>', '<Plug>SchleppRight', flags.u)

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

local cmp = require('cmp')

local function table_len(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end

-- function _G.master_cr()
--   if cmp.visible() then
--     local entries = cmp.get_entries()
--     -- Bit of a shitty work around until I come up with something better
--     -- vim.pretty_print(entries)
--       return npairs.esc('<C-y>')
--     -- if table_len(entries) == 1 and entries[1].completion_item.label:find('^Workspace loading') then
--     --   return npairs.autopairs_cr()
--     -- else
--     --   return npairs.esc('<C-y>')
--     -- end
--   else
--     return npairs.autopairs_cr()
--   end
-- end

-- vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.master_cr()', {
--   silent = true,
--   expr = true,
--   noremap = true,
-- })
