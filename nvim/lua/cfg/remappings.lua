local vim = vim
local skm = vim.api.nvim_set_keymap
local util = require 'utl.util'

local n = {noremap = true}
local n_s = {noremap = true, silent = true}

util.exec('let mapleader=" "')
skm('n', '<leader>', '<NOP>', {})

-- skm('n', 'j', 'gj', n_s)
-- skm('n', 'k', 'gk', n_s)
-- skm('n', 'gj', 'j', n_s)
-- skm('n', 'gk', 'k', n_s)

skm('n', '<leader>E', [[<CMD>e!<CR>]], n_s)
skm('n', '<leader>Q', [[<CMD>qa!<CR>]], n_s)
skm('n', '<leader>W', [[<CMD>lua require'mod.functions'.wqa()<CR>]], n_s)
skm('n', '<leader>e', [[<CMD>e<CR>]], n_s)
skm('n', '<leader>q', [[<CMD>q<CR>]], n_s)
skm('n', '<leader>w', [[<CMD>w<CR>]], n_s)
skm('n', '<A-s>', [[<CMD>w<CR>]], n_s)
skm('n', 'Q', [[q]], n)
skm('n', 'Q!', [[q!]], n)
skm('n', '<F1>', [[<CMD>H <C-r><C-w><CR>]], n_s)
skm('n', '<F2>', [[<CMD>syn sync fromstart<CR>]], n_s)
skm('n', '<F7>', [[<CMD>set spell!<CR>]], n_s)
skm('i', '<F7>', [[<C-o>:set spell!<CR>]], n_s)

skm('n', '', [[<Plug>NERDCommenterToggle]], {})
skm('x', '', [[<Plug>NERDCommenterToggle]], {})
skm('i', '', [[<C-o><C-_>]], {})

skm('n', '<leader>bp', [[<CMD>BufferPick<CR>]], n_s)
skm('n', '<M-/>', [[<CMD>BufferPick<CR>]], n_s)
skm('n', '÷', [[<CMD>BufferPick<CR>]], n_s)

skm('n', '<M-o>', [[<CMD>BufferOrderByBufnr<CR>]], n_s)
skm('n', 'ø', [[<CMD>BufferOrderByBufnr<CR>]], n_s)
for i = 1, 9 do skm('n', '<M-' .. i .. '>', [[<CMD>BufferGoto ]] .. i .. [[<CR>]], n_s) end
skm('n', '<M-,>', [[<CMD>BufferMovePrevious<CR>]], n_s)
skm('n', '<M-.>', [[<CMD>BufferMoveNext<CR>]], n_s)

skm('n', '<C-p>', [[<Tab>]], n)
skm('n', '<leader>*', [[:%s/\<<C-r><C-w>\>//g<left><left>]], n)
skm('n', '<leader>/', [[<Cmd>noh<CR>]], n_s)
skm('n', '<leader>;', [[<Cmd>Commands<CR>]], n_s)
skm('n', '<leader>t', [[<Cmd>Twiggy<CR>]], n_s)
skm('n', '<leader>T', [[<Cmd>Tagbar<CR>]], n_s)
skm('n', '<leader>U', [[<Cmd>MundoToggle<CR>]], n_s)
skm('n', '<leader>V', [[<Cmd>Vista!!<CR>]], n_s)

local req_util = [[lua require'utl.util']]

local function resize_window_str(p, c)
  return p .. req_util .. [[.resize_window(']] .. c .. [[')<CR>]]
end

skm('n', '<C-M-h>', resize_window_str('<Cmd>', 'h'), n_s)
skm('n', '<C-M-j>', resize_window_str('<Cmd>', 'j'), n_s)
skm('n', '<C-M-k>', resize_window_str('<Cmd>', 'k'), n_s)
skm('n', '<C-M-l>', resize_window_str('<Cmd>', 'l'), n_s)

skm('t', '<C-M-h>', resize_window_str('<C-\\><C-n>:', 'h'), n_s)
skm('t', '<C-M-j>', resize_window_str('<C-\\><C-n>:', 'j'), n_s)
skm('t', '<C-M-k>', resize_window_str('<C-\\><C-n>:', 'k'), n_s)
skm('t', '<C-M-l>', resize_window_str('<C-\\><C-n>:', 'l'), n_s)

skm('n', '<leader>"', [[<CMD>sbn<CR>]], n_s)
skm('n', '<leader>#', [[<C-^>]], n_s)
skm('n', '<leader>%', [[<CMD>vert sbn<CR>]], n_s)
skm('n', '<leader>bD', [[<CMD>lua require'mod.functions'.buffer_close_all_but_visible()<CR>]], n_s)
skm('n', '<leader>be', [[<CMD>enew<CR>]], n_s)
skm('n', '<leader>bd', [[<CMD>BufferClose<CR>]], n_s)
skm('n', '<leader>bb', [[<CMD>BufferPick<CR>]], n_s)

skm('n', '<S-down>', [[<CMD>m+<CR>]], n_s)
skm('n', '<S-up>', [[<CMD>m-2<CR>]], n_s)
skm('n', '<S-Tab>', [[<CMD>bp<CR>]], n_s)
skm('n', '<Tab>', [[<CMD>bn<CR>]], n_s)
skm('i', '<S-down>', [[<C-o>:m+<CR>]], n)
skm('i', '<S-up>', [[<C-o>:m-2<CR>]], n)
skm('x', '<S-down>', [[:m'>+<CR>gv=gv]], n)
skm('x', '<S-up>', [[:m-2<CR>gv=gv]], n)

skm('x', '>', [[>gv]], n)
skm('x', '<', [[<gv]], n)
skm('x', '<Tab>', [[>gv]], n)
skm('x', '<S-Tab>', [[<gv]], n)

skm('n', '<leader>ce', [[<CMD>CocCommand explorer --toggle<CR>]], n_s)
skm('n', '<leader>gg', [[<CMD>Git<CR>]], n_s)
skm('n', '<leader>gl', [[<CMD>ToggleLazyGit<CR>]], n_s)
skm('n', '<leader>ge', [[<CMD>Ge:<CR>]], n_s)
skm('n', '<leader>z', [[<CMD>ZoomToggle<CR>]], n_s)
skm('n', '<leader>}', [[zf}]], n_s)

skm('n', '<leader>i', [[<CMD>]] .. req_util .. [[.toggle_bool_option('o', 'ignorecase')<CR>]], n_s)

skm('n', ';', [[<Plug>(clever-f-repeat-forward)]], {})
skm('n', ',', [[<Plug>(clever-f-repeat-back)]], {})

skm('n', '<leader>ea', [[vip:EasyAlign<CR>]], n_s)
skm('x', '<leader>ea', [[:EasyAlign<CR>]], n_s)

skm('n', '<leader>hn', [[<CMD>GitGutterNextHunk<CR>]], n_s)
skm('n', '<leader>hN', [[<CMD>GitGutterPrevHunk<CR>]], n_s)

skm('n', '<leader>H',
    [[<CMD>lua require'mod.terminal'.floating_help(vim.fn.expand('<cword>'))<CR>]], n_s)

util.func([[
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

skm('i', '<BS>', [[<C-r>=MasterBS()<CR>]], n_s)
skm('i', '´', [[<C-r>=AutoPairsFastWrap()<CR>]], n_s)

util.command('ToggleLazyGit', [[w | lua require'mod.terminal'.floating_term('lazygit')]],
    {nargs = '0'})

util.exec([[
  func! CopyForTerminal(...) range
    let reg = get(a:, 1, '"')
    let lines = getline(a:firstline, a:lastline)
    call map(lines, { i, l -> substitute(l, '^ *\(.*\)\\ *$', '\1 ', '') })
    exe "let @" . reg . " = join(lines, ' ')"
  endfunc
]])
util.command('CopyForTerminal', [[<line1>,<line2>call CopyForTerminal(<f-args>)]],
    {range = true, nargs = '?'})

util.command('Wqa', [[wqa]], {nargs = '0'})
util.command('WQa', [[wqa]], {nargs = '0'})
util.command('WQ', [[wq]], {nargs = '0'})
util.command('Wq', [[wq]], {nargs = '0'})
util.command('W', [[w]], {nargs = '0'})
util.command('Q', [[q]], {nargs = '0'})

util.command('DiffThis', [[windo diffthis]], {nargs = '0'})
util.command('DiffOff', [[windo diffoff]], {nargs = '0'})
util.command('ConvLineEndings', [[%s/<CR>//g]], {nargs = '0'})

local req_funcs = [[lua require 'mod.functions']]
util.command('HighlightUnderCursor', req_funcs .. [[.highlight_under_cursor()]], {nargs = '0'})
util.command('SpellChecker', req_funcs .. [[.spell_checker()]], {nargs = '0'})
util.command('ZoomToggle', req_funcs .. [[.zoom_toggle()]], {nargs = '0'})
util.command('ChangeIndent', req_funcs .. [[.change_indent(<f-args>)]], {nargs = '1'})
util.command('SetIndent', req_funcs .. [[.set_indent(<f-args>)]], {nargs = '1'})
util.command('MatchOver', req_funcs .. [[.match_over(<f-args>)]], {nargs = '?'})

util.command('BufferOrderByBufnr', req_funcs .. [[.order_by_bufnr()]], {nargs = '0'})

util.exec('cabbrev PC PackerClean')
util.exec('cabbrev PI PackerInstall')
util.exec('cabbrev PS PackerSync')
util.exec('cabbrev PU PackerUpdate')
