local vim = vim
local skm = vim.api.nvim_set_keymap
local util = require'utl.util'

util.exec('let mapleader=" "')
skm('n', '<leader>', '<NOP>', {})

skm('n', '<leader>E', '<CMD>e!<CR>',                 { noremap = true, silent = true })
skm('n', '<leader>Q', '<CMD>qa!<CR>',                { noremap = true, silent = true })
skm('n', '<leader>W', '<CMD>wqa<CR>',                { noremap = true, silent = true })
skm('n', '<leader>e', '<CMD>e<CR>',                  { noremap = true, silent = true })
skm('n', '<leader>q', '<CMD>q<CR>',                  { noremap = true, silent = true })
skm('n', '<leader>w', '<CMD>w<CR>',                  { noremap = true, silent = true })
skm('n', 'Q',         'q',                           { noremap = true })
skm('n', 'Q!',        'q!',                          { noremap = true })
skm('n', '<F1>',      '<CMD>H <C-r><C-w><CR>',       { noremap = true, silent = true })
skm('n', '<F2>',      '<CMD>syn sync fromstart<CR>', { noremap = true, silent = true })
skm('n', '<F7>',      '<CMD>set spell!<CR>',         { noremap = true, silent = true })
skm('i', '<F7>',      '<C-o>:set spell!<CR>',        { noremap = true, silent = true })

skm('n', '', '<Plug>NERDCommenterToggle', {})
skm('x', '', '<Plug>NERDCommenterToggle', {})
skm('i', '', '<C-o><C-_>',                {})

skm('n', '<C-p>',     '<Tab>',                               { noremap = true })
skm('n', '<leader>*', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { noremap = true })
skm('n', '<leader>/', '<CMD>noh<CR>',                        { noremap = true, silent = true })
skm('n', '<leader>;', '<CMD>Commands<CR>',                   { noremap = true, silent = true })
skm('n', '<leader>t', '<CMD>Twiggy<CR>',                     { noremap = true, silent = true })
skm('n', '<leader>T', '<CMD>TagbarToggle<CR>',               { noremap = true, silent = true })
skm('n', '<leader>U', '<CMD>MundoToggle<CR>',                { noremap = true, silent = true })
skm('n', '<leader>V', '<CMD>Vista!!<CR>',                    { noremap = true, silent = true })

skm('n', '<C-M-h>', ":lua require'utl.util'.resize_window('h')<CR>", { noremap = true, silent = true })
skm('n', '<C-M-j>', ":lua require'utl.util'.resize_window('j')<CR>", { noremap = true, silent = true })
skm('n', '<C-M-k>', ":lua require'utl.util'.resize_window('k')<CR>", { noremap = true, silent = true })
skm('n', '<C-M-l>', ":lua require'utl.util'.resize_window('l')<CR>", { noremap = true, silent = true })

skm('t', '<C-M-h>', "<C-\\><C-n>:lua require'utl.util'.resize_window('h')<CR>", { noremap = true, silent = true })
skm('t', '<C-M-j>', "<C-\\><C-n>:lua require'utl.util'.resize_window('j')<CR>", { noremap = true, silent = true })
skm('t', '<C-M-k>', "<C-\\><C-n>:lua require'utl.util'.resize_window('k')<CR>", { noremap = true, silent = true })
skm('t', '<C-M-l>', "<C-\\><C-n>:lua require'utl.util'.resize_window('l')<CR>", { noremap = true, silent = true })

skm('n', '<leader>"',  '<CMD>sbn<CR>',      { noremap = true, silent = true })
skm('n', '<leader>#',  '<C-^>',             { noremap = true, silent = true })
skm('n', '<leader>%',  '<CMD>vert sbn<CR>', { noremap = true, silent = true })
skm('n', '<leader>bD', '<CMD>BufOnly<CR>',  { noremap = true, silent = true })
skm('n', '<leader>be', '<CMD>enew<CR>',     { noremap = true, silent = true })
skm('n', '<leader>bd', 'Bclose',            { noremap = true, silent = true, expr = true })

skm('n', '<S-down>',  '<CMD>m+<CR>',     { noremap = true, silent = true })
skm('n', '<S-up>',    '<CMD>m-2<CR>',    { noremap = true, silent = true })
skm('n', '<S-Tab>',   '<CMD>bp<CR>',     { noremap = true, silent = true })
skm('n', '<Tab>',     '<CMD>bn<CR>',     { noremap = true, silent = true })
skm('x', '<',         '<gv',             { noremap = true })
skm('x', '>',         '>gv',             { noremap = true })
skm('x', '<S-tab>',   '<gv',             { noremap = true })
skm('x', '<Tab>',     '>gv',             { noremap = true })
skm('i', '<S-down>',  '<C-o>:m+<CR>',    { noremap = true })
skm('i', '<S-up>',    '<C-o>:m-2<CR>',   { noremap = true })
skm('x', '<S-down>',  ':m\'>+<CR>gv=gv', { noremap = true })
skm('x', '<S-up>',    ':m-2<CR>gv=gv',   { noremap = true })

skm('n', '<leader>ce', '<CMD>CocCommand explorer --toggle<CR>', { noremap = true, silent = true })
skm('n', '<leader>gg', '<CMD>Git<CR>',                          { noremap = true, silent = true })
skm('n', '<leader>gl', '<CMD>ToggleLazyGit<CR>',                { noremap = true, silent = true })
skm('n', '<leader>i',  '<CMD>IndentLinesToggle<CR>',            { noremap = true, silent = true })
skm('n', '<leader>z',  '<CMD>ZoomToggle<CR>',                   { noremap = true, silent = true })
skm('n', '<leader>}',  'zf}',                                   { noremap = true, silent = true })

skm('n', ';', '<Plug>(clever-f-repeat-forward)', {})
skm('n', ',', '<Plug>(clever-f-repeat-back)',    {})

skm('n', '<leader>ea', 'vip:EasyAlign<CR>', { noremap = true, silent = true })
skm('x', '<leader>ea', ':EasyAlign<CR>',    { noremap = true, silent = true })

-- Unimpaired covers this
-- skm('n', '[<Leader>',  '<CMD>call append(line(".") - 1, repeat([""], v:count1))<CR>', { noremap = true, silent = true })
-- skm('n', ']<Leader>',  '<CMD>call append(line("."), repeat([""], v:count1))<CR>',     { noremap = true, silent = true })

skm('n', '<leader>m',  "<CMD>lua require'mod.fzf'.run_cmd('Marks')<CR>",    { noremap = true, silent = true })
skm('n', '<leader>r',  "<CMD>lua require'mod.fzf'.run_cmd('Rg')<CR>",       { noremap = true, silent = true })
skm('n', '<leader>f',  "<CMD>lua require'mod.fzf'.run_cmd('FilesFzf')<CR>", { noremap = true, silent = true })
skm('n', '<leader>M',  "<CMD>lua require'mod.fzf'.run_cmd('Maps')<CR>",     { noremap = true, silent = true })
skm('n', '<leader>bl', "<CMD>lua require'mod.fzf'.run_cmd('Buffer')<CR>",   { noremap = true, silent = true })
skm('n', '<M-]>',      "<CMD>lua require'mod.fzf'.rg_under_cursor()<CR>",   { noremap = true, silent = true })
skm('n', '‘',          "<CMD>lua require'mod.fzf'.rg_under_cursor()<CR>",   { noremap = true, silent = true })

util.command('Rg',       "lua require'mod.fzf'.rg(<q-args>,    <bang>0)", { bang = true, nargs = '*' })
util.command('FilesFzf', "lua require'mod.fzf'.files(<q-args>, <bang>0)", { bang = true, nargs = '*' })

skm('n', '<leader>h',  "<CMD>lua require'mod.terminal'.floating_help(vim.fn.expand('<cword>'))<CR>",    { noremap = true, silent = true })

util.command('ToggleLazyGit', "w | lua require'mod.terminal'.floating_term('lazygit')", { nargs = '0' })

util.exec([[
  func! CopyForTerminal(...) range
    let reg = get(a:, 1, '"')
    let lines = getline(a:firstline, a:lastline)
    call map(lines, { i, l -> substitute(l, '^ *\(.*\)\\ *$', '\1 ', '') })
    exe "let @" . reg . " = join(lines, ' ')"
  endfunc
]])
util.command('CopyForTerminal', '<line1>,<line2>call CopyForTerminal(<f-args>)', { range = true, nargs = '?' })

util.command('Wqa',      'wqa',            { nargs = '0' })
util.command('WQa',      'wqa',            { nargs = '0' })
util.command('WQ',       'wq',             { nargs = '0' })
util.command('Wq',       'wq',             { nargs = '0' })
util.command('W',        'w',              { nargs = '0' })
util.command('Q',        'q',              { nargs = '0' })

util.command('DiffThis',        'windo diffthis', { nargs = '0' })
util.command('DiffOff',         'window diffoff', { nargs = '0' })
util.command('ConvLineEndings', '%s/<CR>//g',     { nargs = '0' })

util.command('HighlightUnderCursor', "lua require'mod.functions'.highlight_under_cursor()", { nargs = '0' })
util.command('SpellChecker',         "lua require'mod.functions'.spell_checker()",          { nargs = '0' })
util.command('ZoomToggle',           "lua require'mod.functions'.zoom_toggle()",            { nargs = '0' })
util.command('ChangeIndent',         "lua require'mod.functions'.change_indent(<f-args>)",  { nargs = '1' })
util.command('SetIndent',            "lua require'mod.functions'.set_indent(<f-args>)",     { nargs = '1' })
util.command('MatchOver',            "lua require'mod.functions'.match_over(<f-args>)",     { nargs = '?' })

util.exec('cabbrev PI PlugInstall')
util.exec('cabbrev PU PlugUpdate')
util.exec('cabbrev PC PlugClean')
