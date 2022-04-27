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
vim.keymap.set('i', 'jj', '<Esc>', s)

vim.keymap.set('n', 'Y', 'yy', s)
for _, ch in ipairs({'y', 'Y', 'p', 'P'}) do
  vim.keymap.set('n', '<leader>' .. ch, '"+' .. ch, s)
  vim.keymap.set('x', '<leader>' .. ch, '"+' .. ch, s)
end

vim.keymap.set('n', '<C-p>', [[<Tab>]])
vim.keymap.set('n', '<leader>*', [[:%s/\<<C-r><C-w>\>//g<left><left>]])
vim.keymap.set('n', '<leader>/', [[<Cmd>noh<CR>]], s)
vim.keymap.set('n', '<leader>S', [[<Cmd>SymbolsOutline<CR>]], s)

vim.keymap.set('n', '<C-/>', [[gcc]], {})
vim.keymap.set('x', '<C-/>', [[gc]], {})
vim.keymap.set('i', '<C-/>', [[<C-o>gcc]], {})

-- NOTE: Doesn't work with `vim.keymap.set`
vim.api.nvim_set_keymap('n', '', [[gcc]], {})
vim.api.nvim_set_keymap('x', '', [[gc]], {})
vim.api.nvim_set_keymap('i', '', [[<C-o>gcc]], {})

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

-- bs
vim.cmd([[
  function! MasterBS()
    if (&buftype != '')
      return "\<BS>"
    endif
    let ln = line('.')
    let l = getline(ln)
    let pl = getline(ln - 1)
    if l[:col('.') - 2] =~ '^\s\+$'
      if pl =~ '^\s*$'
        if l =~ '^\s*$'
          return "\<Esc>:silent exe line('.') - 1 . 'delete'\<CR>S"
        else
          return "\<C-o>:silent exe line('.') - 1 . 'delete'\<CR>"
        endif
      else
        return "\<C-w>\<BS>"
      endif
    else
      return AutoPairsDelete()
    endif
  endfunc
]])

vim.keymap.set('i', '<BS>', [[<C-r>=MasterBS()<CR>]], s)

vim.keymap.set('i', '<M-w>', [[<C-r>=AutoPairsFastWrap()<CR>]], s)
vim.keymap.set('i', '∑', [[<C-r>=AutoPairsFastWrap()<CR>]], s)
