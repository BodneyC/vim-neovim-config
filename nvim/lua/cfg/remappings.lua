vim.cmd('let mapleader=" "')

--- Leave unmapped for which-key
-- vim.keymap.set('n', '<leader>', '<NOP>')

vim.keymap.set('n', [[\]], [[<CMD>WhichKey \<CR>]], {})

local flags = require('utl.maps').flags
local s = flags.s
local u = flags.u

local function vsnip_map(mode, key, pos)
  vim.keymap.set(mode, key,
    'vsnip#jumpable(' .. pos .. ')  ? \'<Plug>(vsnip-jump-next)\' : \'' .. key ..
      '\'', flags.se)
end
vsnip_map('i', '<C-j>', 1)
vsnip_map('i', '<C-k>', -1)
vsnip_map('s', '<C-j>', 1)
vsnip_map('s', '<C-k>', -1)

vim.keymap.set('n', '<leader>e', [[<CMD>e<CR>]], s)
vim.keymap.set('n', '<leader>q', [[<CMD>q<CR>]], s)
vim.keymap.set('n', '<leader>Q', [[<CMD>qa!<CR>]], s)
vim.keymap.set('n', '<leader>w', [[<CMD>w<CR>]], s)
vim.keymap.set('n', '<leader>W', [[<CMD>wa | qa<CR>]], s)

vim.keymap.set('n', 'Q', [[q]])
vim.keymap.set('n', 'Q!', [[q!]])
vim.keymap.set('n', '<F1>', [[:H <C-r><C-w><CR>]], s)
vim.keymap.set('n', '<F2>', [[<CMD>syn sync fromstart<CR>]], s)
vim.keymap.set('n', '<F7>', [[<CMD>set spell!<CR>]], s)
vim.keymap.set('i', '<F7>', [[<C-o>:set spell!<CR>]], s)

vim.keymap.set('i', '<C-w>', '<C-S-w>', s)

vim.keymap.set('n', 'Y', 'yy', s)
for _, ch in ipairs({'y', 'Y', 'p', 'P'}) do
  vim.keymap.set('n', '<leader>' .. ch, '"+' .. ch, s)
  vim.keymap.set('x', '<leader>' .. ch, '"+' .. ch, s)
end

vim.keymap.set('n', '<C-p>', [[<Tab>]])
vim.keymap.set('n', '<leader>*', [[:%s/\<<C-r><C-w>\>//g<left><left>]])
vim.keymap.set('n', '<leader>/', [[<Cmd>noh<CR>]], s)
vim.keymap.set('n', '<leader>S', [[<Cmd>SymbolsOutline<CR>]], s)

-- NOTE: Doesn't work with `vim.keymap.set`
-- NOTE: Also works with vim.cmd([[nmap gcc]])
vim.api.nvim_set_keymap('n', '<C-/>', [[gcc]], {})
vim.api.nvim_set_keymap('x', '<C-/>', [[gc]], {})
vim.api.nvim_set_keymap('i', '<C-/>', [[<C-o>gcc]], {})

vim.keymap.set('n', '<leader>"', [[<CMD>sbn<CR>]], s)
vim.keymap.set('n', '<leader>%', [[<CMD>vert sbn<CR>]], s)
vim.keymap.set('n', '<leader>bD', require('mod.functions').bufonly, s)
vim.keymap.set('n', '<leader>be', [[<CMD>enew<CR>]], s)
vim.keymap.set('n', '<leader>bd', [[<CMD>Bdelete<CR>]], s)

-- resize

local util = require('utl.util')
vim.keymap.set({'n', 't'}, '<C-M-h>', function()
  return util.resize_window('h')
end, s)
vim.keymap.set({'n', 't'}, '<C-M-j>', function()
  return util.resize_window('j')
end, s)
vim.keymap.set({'n', 't'}, '<C-M-k>', function()
  return util.resize_window('k')
end, s)
vim.keymap.set({'n', 't'}, '<C-M-l>', function()
  return util.resize_window('l')
end, s)

-- line movement
vim.keymap.set('n', '<S-down>', [[<CMD>m+<CR>]], s)
vim.keymap.set('n', '<S-up>', [[<CMD>m-2<CR>]], s)
vim.keymap.set('n', '<S-Tab>', [[<CMD>bp<CR>]], s)
vim.keymap.set('n', '<Tab>', [[<CMD>bn<CR>]], s)
vim.keymap.set('i', '<S-down>', [[<C-o>:m+<CR>]])
vim.keymap.set('i', '<S-up>', [[<C-o>:m-2<CR>]])
vim.keymap.set('x', '<S-down>', [[:m'>+<CR>gv=gv]])
vim.keymap.set('x', '<S-up>', [[:m-2<CR>gv=gv]])

vim.keymap.set('x', '>', [[>gv]])
vim.keymap.set('x', '<', [[<gv]])
vim.keymap.set('x', '<Tab>', [[>gv]])
vim.keymap.set('x', '<S-Tab>', [[<gv]])

-- git
vim.keymap.set('n', '<leader>ge', [[<CMD>Ge:<CR>]], s)
vim.keymap.set('n', '<leader>}', [[zf}]], s)

vim.keymap.set('n', '<leader>i', function()
  return require('utl.util').toggle_bool_option('o', 'ignorecase')
end, s)

vim.keymap.set('n', '<leader>ea', [[vip:EasyAlign<CR>]], s)
vim.keymap.set('x', '<leader>ea', [[:EasyAlign<CR>]], s)

vim.keymap.set('n', '<leader>H', function()
  return require('mod.terminal').floating_help(vim.fn.expand('<cword>'))
end, s)

vim.keymap.set('v', '<up>', '<Plug>SchleppUp', u)
vim.keymap.set('v', '<down>', '<Plug>SchleppDown', u)
vim.keymap.set('v', '<left>', '<Plug>SchleppLeft', u)
vim.keymap.set('v', '<right>', '<Plug>SchleppRight', u)

-- -- bs
-- vim.cmd([[
--   function! MasterBS()
--     if (&buftype != '')
--       return "\<BS>"
--     endif
--     let ln = line('.')
--     let l = getline(ln)
--     let pl = getline(ln - 1)
--     if l[:col('.') - 2] =~ '^\s\+$'
--       if pl =~ '^\s*$'
--         if l =~ '^\s*$'
--           return "\<Esc>:silent exe line('.') - 1 . 'delete'\<CR>S"
--         else
--           return "\<C-o>:silent exe line('.') - 1 . 'delete'\<CR>"
--         endif
--       else
--         return "\<C-w>\<BS>"
--       endif
--     else
--       return v:lua.MPairs.autopairs_bs(1)
--     endif
--   endfunc
-- ]])
-- vim.keymap.set('i', '<BS>', [[<C-r>=MasterBS()<CR>]], s)
-- vim.keymap.set('i', '<M-w>', [[<C-r>=AutoPairsFastWrap()<CR>]], s)
-- vim.keymap.set('i', '∑', [[<C-r>=AutoPairsFastWrap()<CR>]], s)

local autopairs = require('nvim-autopairs')

local function getline(bufnr, row)
  return vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ''
end

local function esc(cmd)
  return vim.api.nvim_replace_termcodes(cmd, true, false, true)
end

local function master_bs()
  if vim.bo.buftype ~= '' then
    return esc('\\<BS>')
  end
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
        return esc('<Esc>:silent exe line(\'.\') - 1 . \'delete\'<CR>S')
      else -- Part of current line is not blank
        return esc('<C-o>:silent exe line(\'.\') - 1 . \'delete\'<CR>')
      end
    end
    -- The previous line has text
    if col == 0 then
      return esc('<C-w>')
    else
      return esc('<C-w><BS>')
    end
  end
  return autopairs.autopairs_bs(bufnr)
end
_G.MasterBS = master_bs

vim.api.nvim_set_keymap('i', '<BS>', 'v:lua.MasterBS()', {
  silent = true,
  expr = true,
})
