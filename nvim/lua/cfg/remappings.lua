local vim = vim
local skm = vim.api.nvim_set_keymap
local util = require 'utl.util'

local n_s = {noremap = true, silent = true}

util.exec('let mapleader=" "')
skm('n', '<leader>', '<NOP>', {})

skm('n', 'j', 'gj', n_s)
skm('n', 'k', 'gk', n_s)

skm('n', '<leader>E', '<CMD>e!<CR>', n_s)
skm('n', '<leader>Q', '<CMD>qa!<CR>', n_s)
skm('n', '<leader>W', [[<CMD>lua require'mod.functions'.wqa()<CR>]], n_s)
skm('n', '<leader>e', '<CMD>e<CR>', n_s)
skm('n', '<leader>q', '<CMD>q<CR>', n_s)
skm('n', '<leader>w', '<CMD>w<CR>', n_s)
skm('n', '<A-s>', '<CMD>w<CR>', n_s)
skm('n', 'Q', 'q', {noremap = true})
skm('n', 'Q!', 'q!', {noremap = true})
skm('n', '<F1>', '<CMD>H <C-r><C-w><CR>', n_s)
skm('n', '<F2>', '<CMD>syn sync fromstart<CR>', n_s)
skm('n', '<F7>', '<CMD>set spell!<CR>', n_s)
skm('i', '<F7>', '<C-o>:set spell!<CR>', n_s)

skm('n', '', '<Plug>NERDCommenterToggle', {})
skm('x', '', '<Plug>NERDCommenterToggle', {})
skm('i', '', '<C-o><C-_>', {})

skm('n', '<leader>bp', '<CMD>BufferPick<CR>', n_s)
skm('n', '<M-/>', '<CMD>BufferPick<CR>', n_s)
skm('n', '÷', '<CMD>BufferPick<CR>', n_s)

skm('n', '<M-o>', '<CMD>BufferOrderByBufnr<CR>', n_s)
skm('n', '<M-1>', '<CMD>BufferGoto 1<CR>', n_s)
skm('n', '<M-2>', '<CMD>BufferGoto 2<CR>', n_s)
skm('n', '<M-3>', '<CMD>BufferGoto 3<CR>', n_s)
skm('n', '<M-4>', '<CMD>BufferGoto 4<CR>', n_s)
skm('n', '<M-5>', '<CMD>BufferGoto 5<CR>', n_s)
skm('n', '<M-6>', '<CMD>BufferGoto 6<CR>', n_s)
skm('n', '<M-7>', '<CMD>BufferGoto 7<CR>', n_s)
skm('n', '<M-8>', '<CMD>BufferGoto 8<CR>', n_s)
skm('n', '<M-9>', '<CMD>BufferGoto 9<CR>', n_s)
skm('n', '<M-,>', '<CMD>BufferMovePrevious<CR>', n_s)
skm('n', '<M-.>', '<CMD>BufferMoveNext<CR>', n_s)

skm('n', '<C-p>', '<Tab>', {noremap = true})
skm('n', '<leader>*', ':%s/\\<<C-r><C-w>\\>//g<left><left>', {noremap = true})
skm('n', '<leader>/', '<CMD>noh<CR>', n_s)
skm('n', '<leader>;', '<CMD>Commands<CR>', n_s)
skm('n', '<leader>t', '<CMD>Twiggy<CR>', n_s)
skm('n', '<leader>T', '<CMD>TagbarToggle<CR>', n_s)
skm('n', '<leader>U', '<CMD>MundoToggle<CR>', n_s)
skm('n', '<leader>V', '<CMD>Vista!!<CR>', n_s)

skm('n', '<C-M-h>', ':lua require\'utl.util\'.resize_window(\'h\')<CR>', n_s)
skm('n', '<C-M-j>', ':lua require\'utl.util\'.resize_window(\'j\')<CR>', n_s)
skm('n', '<C-M-k>', ':lua require\'utl.util\'.resize_window(\'k\')<CR>', n_s)
skm('n', '<C-M-l>', ':lua require\'utl.util\'.resize_window(\'l\')<CR>', n_s)

skm('t', '<C-M-h>', '<C-\\><C-n>:lua require\'utl.util\'.resize_window(\'h\')<CR>', n_s)
skm('t', '<C-M-j>', '<C-\\><C-n>:lua require\'utl.util\'.resize_window(\'j\')<CR>', n_s)
skm('t', '<C-M-k>', '<C-\\><C-n>:lua require\'utl.util\'.resize_window(\'k\')<CR>', n_s)
skm('t', '<C-M-l>', '<C-\\><C-n>:lua require\'utl.util\'.resize_window(\'l\')<CR>', n_s)

skm('n', '<leader>"', '<CMD>sbn<CR>', n_s)
skm('n', '<leader>#', '<C-^>', n_s)
skm('n', '<leader>%', '<CMD>vert sbn<CR>', n_s)
skm('n', '<leader>bD', '<CMD>lua require\'mod.functions\'.buffer_close_all_but_visible()<CR>', n_s)
skm('n', '<leader>be', '<CMD>enew<CR>', n_s)
skm('n', '<leader>bd', '<CMD>BufferClose<CR>', n_s)
skm('n', '<leader>bb', '<CMD>BufferPick<CR>', n_s)

skm('i', '<CR>', string.gsub([[
  pumvisible()
  ? complete_info()["selected"] != "-1"
    ? "<Plug>(completion_confirm_completion)"
    : "<C-e><CR>"
  : "<CR><Plug>AutoPairsReturn"
]], '\n', ''), {noremap = false, silent = true, expr = true})

skm('n', '<S-down>', '<CMD>m+<CR>', n_s)
skm('n', '<S-up>', '<CMD>m-2<CR>', n_s)
skm('n', '<S-Tab>', '<CMD>bp<CR>', n_s)
skm('n', '<Tab>', '<CMD>bn<CR>', n_s)
skm('x', '<', '<gv', {noremap = true})
skm('x', '>', '>gv', {noremap = true})
skm('x', '<S-tab>', '<gv', {noremap = true})
skm('x', '<Tab>', '>gv', {noremap = true})
skm('i', '<S-down>', '<C-o>:m+<CR>', {noremap = true})
skm('i', '<S-up>', '<C-o>:m-2<CR>', {noremap = true})
skm('x', '<S-down>', ':m\'>+<CR>gv=gv', {noremap = true})
skm('x', '<S-up>', ':m-2<CR>gv=gv', {noremap = true})

skm('n', '<leader>ce', '<CMD>CocCommand explorer --toggle<CR>', n_s)
skm('n', '<leader>gg', '<CMD>Git<CR>', n_s)
skm('n', '<leader>gl', '<CMD>ToggleLazyGit<CR>', n_s)
skm('n', '<leader>z', '<CMD>ZoomToggle<CR>', n_s)
skm('n', '<leader>}', 'zf}', n_s)

skm('n', '<leader>i', '<CMD>lua require\'utl.util\'.toggle_bool_option(\'o\', \'ignorecase\')<CR>',
    n_s)

skm('n', ';', '<Plug>(clever-f-repeat-forward)', {})
skm('n', ',', '<Plug>(clever-f-repeat-back)', {})

skm('n', '<leader>ea', 'vip:EasyAlign<CR>', n_s)
skm('x', '<leader>ea', ':EasyAlign<CR>', n_s)
skm('x', 'ea', ':EasyAlign<CR>', n_s)

util.command('Rg', 'lua require\'mod.telescope\'.grep(<f-args>)', {nargs = '1'})
skm('n', '<leader>gs', '<CMD>Telescope git_status<CR>', n_s)
skm('n', '<leader>gb', '<CMD>Telescope git_branches<CR>', n_s)
skm('n', '<leader>gc', '<CMD>Telescope git_commits<CR>', n_s)
skm('n', '<leader>gr', '<CMD>Telescope registers<CR>', n_s)
skm('n', '<leader>m', '<CMD>Telescope keymaps<CR>', n_s)
skm('n', '<leader>p', [[<CMD>lua require('telescope').extensions.packer.plugins(opts)<CR>]], n_s)
skm('n', '<leader>ld', '<CMD>Telescope lsp_document_symbols<CR>', n_s)
skm('n', '<leader>lw', '<CMD>Telescope lsp_workspace_symbols<CR>', n_s)
skm('n', '<leader>ga', '<CMD>Telescope lsp_code_actions<CR>', n_s)
skm('n', '<leader>M', '<CMD>Telescope marks<CR>', n_s)
skm('n', '<leader>r', [[<CMD>lua require'telescope.builtin'.grep_string { search = '' }<CR>]], n_s)
skm('n', '<leader>f', '<CMD>Telescope fd<CR>', n_s)
skm('n', '<leader>bl', '<CMD>Telescope buffers<CR>', n_s)

-- Gets better results than the builtin
local grep_string_under_cursor =
    [[ <CMD>lua require'telescope.builtin'.grep_string { search = vim.fn.expand('<cword>'), ]] ..
        [[ prompt_prefix = vim.fn.expand('<cword>') .. ' >' }<CR>]]
skm('n', '<M-]>', grep_string_under_cursor, n_s)
skm('n', '‘', grep_string_under_cursor, n_s)

skm('n', '<leader>h',
    '<CMD>lua require\'mod.terminal\'.floating_help(vim.fn.expand(\'<cword>\'))<CR>', n_s)

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

skm('i', '<BS>', '<C-r>=MasterBS()<CR>', n_s)
skm('i', '´', '<C-r>=AutoPairsFastWrap()<CR>', n_s)

util.command('ToggleLazyGit', 'w | lua require\'mod.terminal\'.floating_term(\'lazygit\')',
    {nargs = '0'})

util.exec([[
  func! CopyForTerminal(...) range
    let reg = get(a:, 1, '"')
    let lines = getline(a:firstline, a:lastline)
    call map(lines, { i, l -> substitute(l, '^ *\(.*\)\\ *$', '\1 ', '') })
    exe "let @" . reg . " = join(lines, ' ')"
  endfunc
]])
util.command('CopyForTerminal', '<line1>,<line2>call CopyForTerminal(<f-args>)',
    {range = true, nargs = '?'})

util.command('Wqa', 'wqa', {nargs = '0'})
util.command('WQa', 'wqa', {nargs = '0'})
util.command('WQ', 'wq', {nargs = '0'})
util.command('Wq', 'wq', {nargs = '0'})
util.command('W', 'w', {nargs = '0'})
util.command('Q', 'q', {nargs = '0'})

util.command('DiffThis', 'windo diffthis', {nargs = '0'})
util.command('DiffOff', 'window diffoff', {nargs = '0'})
util.command('ConvLineEndings', '%s/<CR>//g', {nargs = '0'})

util.command('HighlightUnderCursor', 'lua require\'mod.functions\'.highlight_under_cursor()',
    {nargs = '0'})
util.command('SpellChecker', 'lua require\'mod.functions\'.spell_checker()', {nargs = '0'})
util.command('ZoomToggle', 'lua require\'mod.functions\'.zoom_toggle()', {nargs = '0'})
util.command('ChangeIndent', 'lua require\'mod.functions\'.change_indent(<f-args>)', {nargs = '1'})
util.command('SetIndent', 'lua require\'mod.functions\'.set_indent(<f-args>)', {nargs = '1'})
util.command('MatchOver', 'lua require\'mod.functions\'.match_over(<f-args>)', {nargs = '?'})

util.command('BufferOrderByBufnr', 'lua require\'mod.functions\'.order_by_bufnr()', {nargs = '0'})

util.exec('cabbrev PC PackerClean')
util.exec('cabbrev PI PackerInstall')
util.exec('cabbrev PS PackerSync')
util.exec('cabbrev PU PackerUpdate')
