local skm = vim.api.nvim_set_keymap

local n = {noremap = true}
local ns = {noremap = true, silent = true}
local se = {silent = true, expr = true}

vim.cmd('let mapleader=" "')
skm('n', '<leader>', '<NOP>', {})

local function vsnip_map(mode, key, pos)
  skm(mode, key,
    'vsnip#jumpable(' .. pos .. ')  ? \'<Plug>(vsnip-jump-next)\' : \'' .. key ..
      '\'', se)
end
vsnip_map('i', '<C-j>', 1)
vsnip_map('i', '<C-k>', -1)
vsnip_map('s', '<C-j>', 1)
vsnip_map('s', '<C-k>', -1)

-- wqa
skm('n', '<leader>E', [[<CMD>e!<CR>]], ns)
skm('n', '<leader>Q', [[<CMD>qa!<CR>]], ns)
skm('n', '<leader>W', [[<CMD>wa | qa<CR>]], ns)
skm('n', '<leader>e', [[<CMD>e<CR>]], ns)
skm('n', '<leader>q', [[<CMD>q<CR>]], ns)
skm('n', '<leader>w', [[<CMD>w<CR>]], ns)
skm('n', '<A-s>', [[<CMD>w<CR>]], ns)
skm('n', 'Q', [[q]], n)
skm('n', 'Q!', [[q!]], n)
skm('n', '<F1>', [[:H <C-r><C-w><CR>]], ns)
skm('n', '<F2>', [[<CMD>syn sync fromstart<CR>]], ns)
skm('n', '<F7>', [[<CMD>set spell!<CR>]], ns)
skm('i', '<F7>', [[<C-o>:set spell!<CR>]], ns)

skm('n', 'Y', 'yy', ns)
skm('n', '<leader>y', '"+y', ns)
skm('n', '<leader>Y', '"+Y', ns)
skm('n', '<leader>p', '"+p', ns)
skm('n', '<leader>P', '"+P', ns)

skm('i', '<M-d>', [[<C-r>=strftime('%Y-%m-%d')<CR>]], ns)

skm('n', '<C-p>', [[<Tab>]], n)
skm('n', '<leader>*', [[:%s/\<<C-r><C-w>\>//g<left><left>]], n)
skm('n', '<leader>/', [[<Cmd>noh<CR>]], ns)
skm('n', '<leader>;', [[<Cmd>Commands<CR>]], ns)
-- skm('n', '<leader>t', [[<Cmd>Twiggy<CR>]], ns)
skm('n', '<leader>T', [[<Cmd>Tagbar<CR>]], ns)
skm('n', '<leader>U', [[<Cmd>MundoToggle<CR>]], ns)
skm('n', '<leader>V', [[<Cmd>Vista!!<CR>]], ns)

skm('n', '', [[gcc]], {})
skm('x', '', [[gc]], {})
skm('i', '', [[<C-o>gcc]], {})

-- buffers
skm('n', '<leader>bp', [[<CMD>BufferPick<CR>]], ns)
skm('n', '<M-/>', [[<CMD>BufferPick<CR>]], ns)
skm('n', '÷', [[<CMD>BufferPick<CR>]], ns)

for i = 1, 9 do
  skm('n', '<M-' .. i .. '>', [[<CMD>BufferGoto ]] .. i .. [[<CR>]], ns)
end
skm('n', '<M-,>', [[<CMD>BufferMovePrevious<CR>]], ns)
skm('n', '<M-.>', [[<CMD>BufferMoveNext<CR>]], ns)

skm('n', '<leader>"', [[<CMD>sbn<CR>]], ns)
skm('n', '<leader>#', [[<C-^>]], ns)
skm('n', '<leader>%', [[<CMD>vert sbn<CR>]], ns)
skm('n', '<leader>bD',
  [[<CMD>lua require('mod.functions').buffer_close_all_but_visible()<CR>]], ns)
skm('n', '<leader>be', [[<CMD>enew<CR>]], ns)
skm('n', '<leader>bd', [[<CMD>BufferClose<CR>]], ns)
skm('n', '<leader>bb', [[<CMD>BufferPick<CR>]], ns)

-- resize
local function resize_window_str(p, c)
  return p .. [[lua require('utl.util').resize_window(']] .. c .. [[')<CR>]]
end

skm('n', '<C-M-h>', resize_window_str('<Cmd>', 'h'), ns)
skm('n', '<C-M-j>', resize_window_str('<Cmd>', 'j'), ns)
skm('n', '<C-M-k>', resize_window_str('<Cmd>', 'k'), ns)
skm('n', '<C-M-l>', resize_window_str('<Cmd>', 'l'), ns)
skm('t', '<C-M-h>', resize_window_str('<C-\\><C-n>:', 'h'), ns)
skm('t', '<C-M-j>', resize_window_str('<C-\\><C-n>:', 'j'), ns)
skm('t', '<C-M-k>', resize_window_str('<C-\\><C-n>:', 'k'), ns)
skm('t', '<C-M-l>', resize_window_str('<C-\\><C-n>:', 'l'), ns)

-- line movement
skm('n', '<S-down>', [[<CMD>m+<CR>]], ns)
skm('n', '<S-up>', [[<CMD>m-2<CR>]], ns)
skm('n', '<S-Tab>', [[<CMD>bp<CR>]], ns)
skm('n', '<Tab>', [[<CMD>bn<CR>]], ns)
skm('i', '<S-down>', [[<C-o>:m+<CR>]], n)
skm('i', '<S-up>', [[<C-o>:m-2<CR>]], n)
skm('x', '<S-down>', [[:m'>+<CR>gv=gv]], n)
skm('x', '<S-up>', [[:m-2<CR>gv=gv]], n)

skm('x', '>', [[>gv]], n)
skm('x', '<', [[<gv]], n)
skm('x', '<Tab>', [[>gv]], n)
skm('x', '<S-Tab>', [[<gv]], n)

-- git
skm('n', '<leader>gg', [[<CMD>Git<CR>]], ns)
skm('n', '<leader>gl', [[<CMD>ToggleLazyGit<CR>]], ns)
skm('n', '<leader>ge', [[<CMD>Ge:<CR>]], ns)
skm('n', '<leader>z', [[<CMD>ZoomToggle<CR>]], ns)
skm('n', '<leader>}', [[zf}]], ns)

skm('n', '<leader>i',
  [[<CMD>lua require('utl.util').toggle_bool_option('o', 'ignorecase')<CR>]], ns)

skm('n', ';', [[<Plug>(clever-f-repeat-forward)]], {})
skm('n', ',', [[<Plug>(clever-f-repeat-back)]], {})

skm('n', '<leader>ea', [[vip:EasyAlign<CR>]], ns)
skm('x', '<leader>ea', [[:EasyAlign<CR>]], ns)

skm('n', '<leader>H',
  [[<CMD>lua require('mod.terminal').floating_help(vim.fn.expand('<cword>'))<CR>]],
  ns)

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

skm('i', '<BS>', [[<C-r>=MasterBS()<CR>]], ns)

skm('i', '<M-w>', [[<C-r>=AutoPairsFastWrap()<CR>]], ns)
skm('i', '∑', [[<C-r>=AutoPairsFastWrap()<CR>]], ns)
