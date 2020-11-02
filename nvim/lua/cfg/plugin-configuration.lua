local vim = vim
local skm = vim.api.nvim_set_keymap

local util = require 'utl.util'
local lang = require 'utl.lang'

vim.g.bufferline = {
  icons = true,
  closable = true,
  animation = true,
  letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
  clickable = true,
  shadow = true,
  semantic_letters = true,
  maximum_padding = 6,
}

vim.g.icons = {
  bufferline_default_file = '',
  bufferline_separator_active = '',
  bufferline_separator_inactive = ' ',
  bufferline_close_tab = ' ',
  bufferline_close_tab_modified = '● ',
}

vim.g.vcoolor_disable_mappings = false

vim.g.move_map_keys = false
vim.g.asynctasks_term_pos = 'bottom'
vim.g.asyncrun_open = 15

vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/vsnip'

vim.g.vimade = {fadelevel = 0.6, enablesigns = 0}

vim.g.twiggy_local_branch_sort = 'mru'
vim.g.twiggy_remote_branch_sort = 'date'

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 14

vim.g['conjure#mapping#prefix'] = '\\'

vim.g.Hexokinase_virtualText = ' '
vim.g.Hexokinase_highlighters = {'virtual'}
vim.g.Hexokinase_optInPatterns = {
  'full_hex', 'triple_hex', 'rgb', 'rgba', 'hsl', 'hsla',
}

-- Weird behaviour with os.setenv...
vim.fn.execute('let $FZF_PREVIEW_COMMAND = "bat --italic-text=always ' ..
                   '--style=numbers --color=always {} || highlight -O ansi -l {} || ' ..
                   'coderay {} || rougify {} || cat {}"')
vim.fn.execute('let $FZF_DEFAULT_OPTS="--layout=reverse --margin=1,1"')
vim.g.fzf_layout = {window = 'lua require\'mod.terminal\'.floating_centred()'}
vim.g.fzf_history_dir = os.getenv('HOME') .. '/.fzf/.fzf_history_dir'

vim.g.tmux_navigator_no_mappings = 1
skm('n', '<M-k>', ':TmuxNavigateUp<CR>', {noremap = true, silent = true})
skm('n', '<M-h>', ':TmuxNavigateLeft<CR>', {noremap = true, silent = true})
skm('n', '<M-j>', ':TmuxNavigateDown<CR>', {noremap = true, silent = true})
skm('n', '<M-l>', ':TmuxNavigateRight<CR>', {noremap = true, silent = true})
skm('n', '<M-\\>', ':TmuxNavigatePrevious<CR>', {noremap = true, silent = true})
skm('i', '<M-k>', '<C-o>:TmuxNavigateUp<CR>', {noremap = true, silent = true})
skm('i', '<M-h>', '<C-o>:TmuxNavigateLeft<CR>', {noremap = true, silent = true})
skm('i', '<M-j>', '<C-o>:TmuxNavigateDown<CR>', {noremap = true, silent = true})
skm('i', '<M-l>', '<C-o>:TmuxNavigateRight<CR>', {noremap = true, silent = true})
skm('i', '<M-\\>', '<C-o>:TmuxNavigatePrevious<CR>',
    {noremap = true, silent = true})

vim.g['test#java#maventest#file_pattern'] =
    '\v([Tt]est.*|.*[Tt]est(s|Case)?).(java|kt)$'

vim.g.matchup_matchparen_offscreen = {method = 'popup'}

vim.g.togool_extras = {{'<', '+'}, {'>', '-'}}

vim.g.virk_tags_enable = 0
vim.g.virk_close_regexes = {
  '^$', 'FAR.*', 'MERGE MSG', 'git-.*', 'COMMIT.*', '.*Plugins.*', '^.defx].*',
}
vim.g.virk_close_by_ft = {
  -- ["coc-explorer"] = "CocCommand explorer --no-focus --toggle " .. vim.fn.getcwd(),
  tagbar = 'TagbarOpen',
  vista = 'Vista!! | wincmd p',
  defx = 'exe \'DefxOpen\' | setlocal nobuflisted | wincmd p',
  Mundo = 'MundoShow',
}

vim.g.indentLine_showFirstIndentLevel = 1
vim.g.indentLine_enabled = 1
vim.g.indentLine_char = '·'
vim.g.indentLine_first_char = '·'
vim.g.indentLine_fileTypeExclude = {
  'markdown', 'nerdtree', 'defx', 'twiggy', 'startify', 'help',
}

vim.g.NERDSpaceDelims = 1
vim.g.NERDDefaultAlign = 'left'

vim.g.mundo_right = 1
vim.g.tagbar_auto_close = 1

-- vim.g.gutentags_trace = 1
vim.g.gutentags_cache_dir = os.getenv('HOME') .. '/.cache/vim/tags'
os.execute('test -d ' .. vim.g.gutentags_cache_dir .. ' || mkdir -p ' ..
               vim.g.gutentags_cache_dir)
vim.g.gutentags_modules = {'ctags'}
vim.g.gutentags_add_default_project_roots = 0
vim.g.gutentags_ctags_auto_set_tags = 1
vim.g.gutentags_project_root = {'.git', '.vim'}
vim.g.gutentags_generate_on_write = 1
vim.g.gutentags_generate_on_missing = 1
vim.g.gutentags_generate_on_new = 1
vim.g.gutentags_generate_on_empty_buffer = 0
vim.g.gutentags_ctags_exclude = {'*.json'}
vim.g.gutentags_ctags_extra_args = {'--tag-relative=always', '--fields=+ailmnS'}

vim.g.vista_icon_indent = {'╰─▸ ', '├─▸ '}
vim.g.vista_default_executive = 'ctags'
vim.g['vista#renderer#icons'] = {variable = '\\u71b'}
vim.g['vista#renderer#icons']['function'] = '\\uf794'
vim.g.vista_executive_for = {vim = 'ctags'}

util.augroup([[
  augroup __STARTIFY__
    au!
    au VimEnter * lua require'cfg.startify'.init()
  augroup END
]])

vim.g.tagbar_iconchars = {lang.utf8(0x00a0), lang.utf8(0x00a0)}
vim.g.tagbar_compact = 1
