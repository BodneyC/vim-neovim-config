local vim = vim
local skm = vim.api.nvim_set_keymap
local util = require'utl.util'

vim.fn.execute('let mapleader=" "')
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

skm('n', '',        '<Plug>NERDCommenterToggle',               {})
skm('x', '',        '<Plug>NERDCommenterToggle',               {})
skm('n', '<C-p>',     '<Tab>',                                   { noremap = true })
skm('n', '<leader>*', '<CMD>%s/\\<<C-r><C-w>\\>//g<left><left>', { noremap = true })
skm('n', '<leader>/', '<CMD>noh<CR>',                            { noremap = true, silent = true })
skm('n', '<leader>;', '<CMD>Commands<CR>',                       { noremap = true, silent = true })
skm('n', '<leader>t', '<CMD>Twiggy<CR>',                         { noremap = true, silent = true })
skm('n', '<leader>T', '<CMD>TagbarToggle<CR>',                   { noremap = true, silent = true })
skm('n', '<leader>U', '<CMD>MundoToggle<CR>',                    { noremap = true, silent = true })
skm('n', '<leader>V', '<CMD>Vista!!<CR>',                        { noremap = true, silent = true })

skm('n', '<C-M-h>', ":lua require'utl.util'.resize_window('h')<CR>", { noremap = true, silent = true })
skm('n', '<C-M-j>', ":lua require'utl.util'.resize_window('j')<CR>", { noremap = true, silent = true })
skm('n', '<C-M-k>', ":lua require'utl.util'.resize_window('k')<CR>", { noremap = true, silent = true })
skm('n', '<C-M-l>', ":lua require'utl.util'.resize_window('l')<CR>", { noremap = true, silent = true })

skm('n', '<leader>"',  '<CMD>sbn<CR>',      { noremap = true, silent = true })
skm('n', '<leader>#',  '<C-^>',             { noremap = true, silent = true })
skm('n', '<leader>%',  '<CMD>vert sbn<CR>', { noremap = true, silent = true })
skm('n', '<leader>bD', '<CMD>BufOnly<CR>',  { noremap = true, silent = true })
skm('n', '<leader>bd', 'Bclose',            { noremap = true, silent = true, expr = true })
skm('n', '<leader>be', '<CMD>enew<CR>',     { noremap = true, silent = true })

skm('n', '<S-down>',  '<CMD>m+<CR>',     { noremap = true, silent = true })
skm('n', '<S-up>',    '<CMD>m-2<CR>',    { noremap = true, silent = true })
skm('n', '<S-Tab>',   '<CMD>bp<CR>',     { noremap = true, silent = true })
skm('n', '<Tab>',     '<CMD>bn<CR>',     { noremap = true, silent = true })
skm('x', '<',         '<gv',             { noremap = true })
skm('x', '>',         '>gv',             { noremap = true })
skm('x', '<leader>e', ':EasyAlign<CR>',  { noremap = true })
skm('x', '<S-tab>',   '<gv',             { noremap = true })
skm('x', '<Tab>',     '>gv',             { noremap = true })
skm('i', '<S-down>',  '<C-o>:m+<CR>',    { noremap = true })
skm('i', '<S-up>',    '<C-o>:m-2<CR>',   { noremap = true })
skm('x', '<S-down>',  ':m\'>+<CR>gv=gv', { noremap = true })
skm('x', '<S-up>',    ':m-2<CR>gv=gv',   { noremap = true })

skm('n', '<leader>ce', '<CMD>CocCommand explorer --toggle<CR>', { noremap = true,               silent = true })
skm('n', '<leader>gg', '<CMD>Git<CR>',                          { noremap = true,               silent = true })
skm('n', '<leader>gl', '<CMD>ToggleLazyGit<CR>',                { noremap = true,               silent = true })
skm('n', '<leader>i',  '<CMD>IndentLinesToggle<CR>',            { noremap = true,               silent = true })
skm('n', '<leader>z',  '<CMD>ZoomToggle<CR>',                   { noremap = true,               silent = true })
skm('n', '<leader>}',  'zf}',                                   { noremap = true,               silent = true })
skm('n', ';',          '<Plug>(clever-f-repeat-forward)',       {})
skm('n', ',',          '<Plug>(clever-f-repeat-back)',          {})

skm('n', '[<Leader>',  '<CMD>call append(line(".") - 1, repeat([""], v:count1))<CR>', { noremap = true, silent = true })
skm('n', ']<Leader>',  '<CMD>call append(line("."), repeat([""], v:count1))<CR>',     { noremap = true, silent = true })

vim.fn.execute("command! -nargs=0       ToggleLazyGit w | lua require'mod.terminal'.floating_term('lazygit')")
vim.fn.execute('command!                Wqa           wqa')
vim.fn.execute('command!                WQa           wqa')
vim.fn.execute('command!                WQ            wq')
vim.fn.execute('command!                Wq            wq')
vim.fn.execute('command!                W             w')
vim.fn.execute('command!                Q             q')
vim.fn.execute('command! -nargs=0       DiffThis      windo diffthis')
vim.fn.execute('command! -nargs=0       DiffOff       windo diffoff')

vim.fn.execute('cabbrev pluginstall PlugInstall')
vim.fn.execute('cabbrev PLugInstall PlugInstall')
vim.fn.execute('cabbrev plugupdate PlugUpdate')
vim.fn.execute('cabbrev PLugUpdate PlugUpdate')

skm('n', '<leader>m',  ":lua require'mod.fzf'.run_cmd('Marks')<CR>",    { noremap = true, silent = true })
skm('n', '<leader>r',  ":lua require'mod.fzf'.run_cmd('Rg')<CR>",       { noremap = true, silent = true })
skm('n', '<leader>f',  ":lua require'mod.fzf'.run_cmd('FilesFzf')<CR>", { noremap = true, silent = true })
skm('n', '<leader>M',  ":lua require'mod.fzf'.run_cmd('Maps')<CR>",     { noremap = true, silent = true })
skm('n', '<leader>bl', ":lua require'mod.fzf'.run_cmd('Buffer')<CR>",   { noremap = true, silent = true })
skm('n', '<M-]>',      ":lua require'mod.fzf'.rg_under_cursor()<CR>",   { noremap = true, silent = true })
skm('n', '‘',          ":lua require'mod.fzf'.rg_under_cursor()<CR>",   { noremap = true, silent = true })

vim.fn.execute("command! -bang -nargs=* Rg            lua require'mod.fzf'.rg(<q-args>, <bang>0)")
vim.fn.execute("command! -bang -nargs=* FilesFzf      lua require'mod.fzf'.files(<q-args>)")

util.command('ConvLineEndings',      '%s/<CR>//g',                         { nargs = '0' })
util.command('HighlightUnderCursor', "lua require'mod.functions'.highlight_under_cursor()", { nargs = '0' })
util.command('SpellChecker',         "lua require'mod.functions'.spell_checker()",          { nargs = '0' })
util.command('ZoomToggle',           "lua require'mod.functions'.zoom_toggle()",            { nargs = '0' })
util.command('ChangeIndent',         "lua require'mod.functions'.change_indent(<f-args>)",  { nargs = '1' })
util.command('SetIndent',            "lua require'mod.functions'.set_indent(<f-args>)",     { nargs = '1' })
util.command('MatchOver',            "lua require'mod.functions'.match_over(<f-args>)",     { nargs = '?' })
