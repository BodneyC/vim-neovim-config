local skm = vim.api.nvim_set_keymap

vim.cmd('let mapleader=" "')

--- Leave unmapped for which-key
-- skm('n', '<leader>', '<NOP>', {})

skm('n', [[\]], [[<CMD>WhichKey \<CR>]], {})

local flags = require('utl.maps').flags

local function vsnip_map(mode, key, pos)
  skm(mode, key,
    'vsnip#jumpable(' .. pos .. ')  ? \'<Plug>(vsnip-jump-next)\' : \'' .. key ..
      '\'', flags.se)
end
vsnip_map('i', '<C-j>', 1)
vsnip_map('i', '<C-k>', -1)
vsnip_map('s', '<C-j>', 1)
vsnip_map('s', '<C-k>', -1)

skm('n', '<leader>E', [[<CMD>e!<CR>]], flags.ns)
skm('n', '<leader>Q', [[<CMD>qa!<CR>]], flags.ns)
skm('n', '<leader>W', [[<CMD>wa | qa<CR>]], flags.ns)
skm('n', '<leader>e', [[<CMD>e<CR>]], flags.ns)
skm('n', '<leader>q', [[<CMD>q<CR>]], flags.ns)
skm('n', '<leader>w', [[<CMD>w<CR>]], flags.ns)
skm('n', '<A-s>', [[<CMD>w<CR>]], flags.ns)
skm('n', 'Q', [[q]], flags.n)
skm('n', 'Q!', [[q!]], flags.n)
skm('n', '<F1>', [[:H <C-r><C-w><CR>]], flags.ns)
skm('n', '<F2>', [[<CMD>syn sync fromstart<CR>]], flags.ns)
skm('n', '<F7>', [[<CMD>set spell!<CR>]], flags.ns)
skm('i', '<F7>', [[<C-o>:set spell!<CR>]], flags.ns)

skm('i', '<C-w>', '<C-S-w>', flags.ns)

skm('n', 'Y', 'yy', flags.ns)
for _, ch in ipairs({'y', 'Y', 'p', 'P'}) do
  skm('n', '<leader>' .. ch, '"+' .. ch, flags.ns)
  skm('x', '<leader>' .. ch, '"+' .. ch, flags.ns)
end

skm('i', '<M-d>', [[<C-r>=strftime('%Y-%m-%d')<CR>]], flags.ns)

skm('n', '<C-p>', [[<Tab>]], flags.n)
skm('n', '<leader>*', [[:%s/\<<C-r><C-w>\>//g<left><left>]], flags.n)
skm('n', '<leader>/', [[<Cmd>noh<CR>]], flags.ns)
skm('n', '<leader>;', [[<Cmd>Commands<CR>]], flags.ns)
-- skm('n', '<leader>t', [[<Cmd>Twiggy<CR>]], ns)
skm('n', '<leader>T', [[<Cmd>SymbolsOutline<CR>]], flags.ns)
skm('n', '<leader>U', [[<Cmd>MundoToggle<CR>]], flags.ns)

skm('n', '<C-/>', [[gcc]], {})
skm('x', '<C-/>', [[gc]], {})
skm('i', '<C-/>', [[<C-o>gcc]], {})

skm('n', '', [[gcc]], {})
skm('x', '', [[gc]], {})
skm('i', '', [[<C-o>gcc]], {})

-- buffers
skm('n', '<leader>bp', [[<CMD>BufferPick<CR>]], flags.ns)
skm('n', '<M-/>', [[<CMD>BufferPick<CR>]], flags.ns)
skm('n', '÷', [[<CMD>BufferPick<CR>]], flags.ns)

for i = 1, 9 do
  skm('n', '<M-' .. i .. '>', [[<CMD>BufferGoto ]] .. i .. [[<CR>]], flags.ns)
end
skm('n', '<M-,>', [[<CMD>BufferMovePrevious<CR>]], flags.ns)
skm('n', '<M-.>', [[<CMD>BufferMoveNext<CR>]], flags.ns)

skm('n', '<leader>"', [[<CMD>sbn<CR>]], flags.ns)
skm('n', '<leader>#', [[<C-^>]], flags.ns)
skm('n', '<leader>%', [[<CMD>vert sbn<CR>]], flags.ns)
skm('n', '<leader>bD', [[<CMD>lua require('mod.functions').bufonly()<CR>]], flags.ns)
skm('n', '<leader>be', [[<CMD>enew<CR>]], flags.ns)
skm('n', '<leader>bd', [[<CMD>Bdelete<CR>]], flags.ns)
skm('n', '<leader>bb', [[<CMD>BufferPick<CR>]], flags.ns)

-- resize
local function resize_window_str(p, c)
  return p .. [[lua require('utl.util').resize_window(']] .. c .. [[')<CR>]]
end

skm('n', '<C-M-h>', resize_window_str('<Cmd>', 'h'), flags.ns)
skm('n', '<C-M-j>', resize_window_str('<Cmd>', 'j'), flags.ns)
skm('n', '<C-M-k>', resize_window_str('<Cmd>', 'k'), flags.ns)
skm('n', '<C-M-l>', resize_window_str('<Cmd>', 'l'), flags.ns)
skm('t', '<C-M-h>', resize_window_str('<C-\\><C-n>:', 'h'), flags.ns)
skm('t', '<C-M-j>', resize_window_str('<C-\\><C-n>:', 'j'), flags.ns)
skm('t', '<C-M-k>', resize_window_str('<C-\\><C-n>:', 'k'), flags.ns)
skm('t', '<C-M-l>', resize_window_str('<C-\\><C-n>:', 'l'), flags.ns)

-- line movement
skm('n', '<S-down>', [[<CMD>m+<CR>]], flags.ns)
skm('n', '<S-up>', [[<CMD>m-2<CR>]], flags.ns)
skm('n', '<S-Tab>', [[<CMD>bp<CR>]], flags.ns)
skm('n', '<Tab>', [[<CMD>bn<CR>]], flags.ns)
skm('i', '<S-down>', [[<C-o>:m+<CR>]], flags.n)
skm('i', '<S-up>', [[<C-o>:m-2<CR>]], flags.n)
skm('x', '<S-down>', [[:m'>+<CR>gv=gv]], flags.n)
skm('x', '<S-up>', [[:m-2<CR>gv=gv]], flags.n)

skm('x', '>', [[>gv]], flags.n)
skm('x', '<', [[<gv]], flags.n)
skm('x', '<Tab>', [[>gv]], flags.n)
skm('x', '<S-Tab>', [[<gv]], flags.n)

-- git
skm('n', '<leader>gg', [[<CMD>Git<CR>]], flags.ns)
skm('n', '<leader>gl', [[<CMD>ToggleLazyGit<CR>]], flags.ns)
skm('n', '<leader>ge', [[<CMD>Ge:<CR>]], flags.ns)
skm('n', '<leader>z', [[<CMD>ZoomToggle<CR>]], flags.ns)
skm('n', '<leader>}', [[zf}]], flags.ns)

skm('n', '<leader>i',
  [[<CMD>lua require('utl.util').toggle_bool_option('o', 'ignorecase')<CR>]],
  flags.ns)

skm('n', '<leader>ea', [[vip:EasyAlign<CR>]], flags.ns)
skm('x', '<leader>ea', [[:EasyAlign<CR>]], flags.ns)

skm('n', '<leader>H',
  [[<CMD>lua require('mod.terminal').floating_help(vim.fn.expand('<cword>'))<CR>]],
  flags.ns)

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

skm('i', '<BS>', [[<C-r>=MasterBS()<CR>]], flags.ns)

skm('i', '<M-w>', [[<C-r>=AutoPairsFastWrap()<CR>]], flags.ns)
skm('i', '∑', [[<C-r>=AutoPairsFastWrap()<CR>]], flags.ns)
