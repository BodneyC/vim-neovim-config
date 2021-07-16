local vim = vim
local skm = vim.api.nvim_set_keymap

local lang = require 'utl.lang'
local util = require 'utl.util'
local fs = require 'utl.fs'

vim.g.vim_markdown_folding_disabled = true
vim.g.vim_markdown_no_default_key_mappings = true

vim.g.AutoPairsMapBS = false
vim.g.AutoPairsMultilineClose = false

-- Bufferline <3
vim.g.bufferline = {
  icons = true,
  closable = true,
  animation = true,
  letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
  clickable = true,
  shadow = true,
  semantic_letters = true,
  maximum_padding = 4,
  icon_separator_active = ' ',
  icon_separator_inactive = '  ',
  icon_close_tab = ' ',
  icon_close_tab_modified = '● ',
}

-- Relies on this file being loaded after the plugins itself
util.augroup({
  name = 'bufferline_update__custom',
  autocmds = {
    {
      event = 'BufNew,BufEnter,BufWinEnter,SessionLoadPost,WinEnter',
      glob = '*',
      cmd = 'BufferOrderByBufnr',
    },
  },
})

vim.g.vcoolor_disable_mappings = false

vim.g.move_map_keys = false
vim.g.asynctasks_term_pos = 'bottom'
vim.g.asyncrun_open = 15

vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/vsnip'

vim.g.vimade = {fadelevel = 0.6, enablesigns = 0}

vim.g.twiggy_local_branch_sort = 'mru'
vim.g.twiggy_remote_branch_sort = 'date'

vim.g['conjure#mapping#prefix'] = '\\'

vim.g.Hexokinase_virtualText = ' '
vim.g.Hexokinase_highlighters = {'backgroundfull'}
vim.g.Hexokinase_optInPatterns = {'full_hex', 'triple_hex', 'rgb', 'rgba', 'hsl', 'hsla'}

-- fzf
-- Weird behaviour with os.setenv...
-- vim.fn.execute('let $FZF_PREVIEW_COMMAND = "bat --italic-text=always ' ..
--                    '--style=numbers --color=always {} || highlight -O ansi -l {} || ' ..
--                    'coderay {} || rougify {} || cat {}"')
-- vim.fn.execute('let $FZF_DEFAULT_OPTS="--layout=reverse --margin=1,1"')
-- vim.g.fzf_preview_command = 'bat --color=always --plain {-1}'
-- vim.g.fzf_layout = {window = 'lua require\'mod.terminal\'.floating_centred()'}
-- vim.g.fzf_history_dir = os.getenv('HOME') .. '/.fzf/.fzf_history_dir'
-- vim.g.fzf_preview_git_status_preview_command =
--     '[[ $(git diff --cached -- {-1}) != "" ]] && git diff --cached --color=always -- {-1} | delta || ' ..
--         '[[ $(git diff -- {-1}) != "" ]] && git diff --color=always -- {-1} | delta || ' ..
--         vim.g.fzf_preview_command

-- terminal window manager
local pane_manager = 'Tmux'
if os.getenv('KITTY_WINDOW_ID') then
  pane_manager = 'Kitty'
  local kitty_listen = os.getenv('KITTY_LISTEN_ON')
  if kitty_listen then
    vim.g.kitty_navigator_listening_on_address = kitty_listen
  else
    print('KittyNavigate will not work, no KITTY_LISTEN_ON')
  end
end
vim.g[string.lower(pane_manager) .. '_navigator_no_mappings'] = 1
local n_s = {noremap = true, silent = true}
skm('n', '<M-k>', ':' .. pane_manager .. 'NavigateUp<CR>', n_s)
skm('n', '<M-h>', ':' .. pane_manager .. 'NavigateLeft<CR>', n_s)
skm('n', '<M-j>', ':' .. pane_manager .. 'NavigateDown<CR>', n_s)
skm('n', '<M-l>', ':' .. pane_manager .. 'NavigateRight<CR>', n_s)
skm('n', '<M-\\>', ':' .. pane_manager .. 'NavigatePrevious<CR>', n_s)
skm('i', '<M-k>', '<C-o>:' .. pane_manager .. 'NavigateUp<CR>', n_s)
skm('i', '<M-h>', '<C-o>:' .. pane_manager .. 'NavigateLeft<CR>', n_s)
skm('i', '<M-j>', '<C-o>:' .. pane_manager .. 'NavigateDown<CR>', n_s)
skm('i', '<M-l>', '<C-o>:' .. pane_manager .. 'NavigateRight<CR>', n_s)
skm('i', '<M-\\>', '<C-o>:' .. pane_manager .. 'NavigatePrevious<CR>', n_s)
skm('t', '<M-h>', '<C-\\><C-n>:' .. pane_manager .. 'NavigateLeft<CR>', n_s)
skm('t', '<M-j>', '<C-\\><C-n>:' .. pane_manager .. 'NavigateDown<CR>', n_s)
skm('t', '<M-k>', '<C-\\><C-n>:' .. pane_manager .. 'NavigateUp<CR>', n_s)
skm('t', '<M-l>', '<C-\\><C-n>:' .. pane_manager .. 'NavigateRight<CR>', n_s)
skm('t', '<M-\\>', '<C-\\><C-n>:' .. pane_manager .. 'NavigatePrevious<CR>', n_s)

vim.g['test#java#maventest#file_pattern'] = '\v([Tt]est.*|.*[Tt]est(s|Case)?).(java|kt)$'

vim.g.matchup_matchparen_offscreen = {method = 'popup'}

vim.g.togool_extras = {{'<', '+'}, {'>', '-'}}

-- virk
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

vim.g.scrollview_excluded_filetypes = {'defx'}

vim.g.indentLine_char = '│'
vim.g.indentLine_first_char = '│'
vim.g.indentLine_fileTypeExclude = {
  'packer', 'dashboard', 'nerdtree', 'twiggy', 'startify', 'help', 'defx', '',
}

vim.g.NERDSpaceDelims = 1
vim.g.NERDDefaultAlign = 'left'

vim.g.mundo_right = 1
vim.g.tagbar_auto_close = 1

-- gutentags
-- vim.g.gutentags_trace = 1
vim.g.gutentags_cache_dir = os.getenv('HOME') .. '/.cache/vim/tags'
os.execute('test -d ' .. vim.g.gutentags_cache_dir .. ' || mkdir -p ' .. vim.g.gutentags_cache_dir)
vim.g.gutentags_modules = {'ctags'}
vim.g.gutentags_add_default_project_roots = 0
vim.g.gutentags_ctags_auto_set_tags = 1
vim.g.gutentags_project_root = {'.git', '.vim'}
vim.g.gutentags_generate_on_write = 1
vim.g.gutentags_generate_on_missing = 1
vim.g.gutentags_generate_on_new = 1
vim.g.gutentags_generate_on_empty_buffer = 0
vim.g.gutentags_ctags_exclude = {'*.json'}
vim.g.gutentags_ctags_extra_args = {
  '--tag-relative=' .. (fs.dir_exists(os.getenv('HOME') .. '/Library') and 'yes' or 'always'),
  '--fields=+ailmnS',
}

vim.g.vista_icon_indent = {'╰─▸ ', '├─▸ '}
vim.g.vista_default_executive = 'ctags'
vim.g['vista#renderer#icons'] = {variable = '\\u71b'}
vim.g['vista#renderer#icons']['function'] = '\\uf794'
vim.g.vista_executive_for = {vim = 'ctags'}

vim.g.tagbar_iconchars = {lang.utf8(0x00a0), lang.utf8(0x00a0)}
vim.g.tagbar_compact = 1

-- secp
vim.g.sexp_mappings = {
  sexp_outer_list = 'af',
  sexp_inner_list = 'if',
  sexp_outer_top_list = 'aF',
  sexp_inner_top_list = 'iF',
  sexp_outer_string = 'as',
  sexp_inner_string = 'is',
  sexp_outer_element = 'ae',
  sexp_inner_element = 'ie',
  sexp_move_to_prev_bracket = '(',
  sexp_move_to_next_bracket = ')',
  sexp_move_to_prev_top_element = '[[',
  sexp_move_to_next_top_element = ']]',
  sexp_select_prev_element = '[e',
  sexp_select_next_element = ']e',
  sexp_indent = '==',
  sexp_indent_top = '=-',
  sexp_round_head_wrap_list = '\\i',
  sexp_round_tail_wrap_list = '\\I',
  sexp_square_head_wrap_list = '\\[',
  sexp_square_tail_wrap_list = '\\]',
  sexp_curly_head_wrap_list = '\\{',
  sexp_curly_tail_wrap_list = '\\}',
  sexp_round_head_wrap_element = '\\w',
  sexp_round_tail_wrap_element = '\\W',
  sexp_square_head_wrap_element = '\\e[',
  sexp_square_tail_wrap_element = '\\e]',
  sexp_curly_head_wrap_element = '\\e{',
  sexp_curly_tail_wrap_element = '\\e}',
  sexp_insert_at_list_head = '\\h',
  sexp_insert_at_list_tail = '\\l',
  sexp_splice_list = '\\@',
  sexp_convolute = '\\?',
  sexp_raise_list = '\\o',
  sexp_raise_element = '\\O',
  sexp_move_to_prev_element_head = '',
  sexp_move_to_next_element_head = '',
  sexp_move_to_prev_element_tail = '',
  sexp_move_to_next_element_tail = '',
  sexp_flow_to_prev_close = '',
  sexp_flow_to_next_open = '',
  sexp_flow_to_prev_open = '',
  sexp_flow_to_next_close = '',
  sexp_flow_to_prev_leaf_head = '',
  sexp_flow_to_next_leaf_head = '',
  sexp_flow_to_prev_leaf_tail = '',
  sexp_flow_to_next_leaf_tail = '',
  sexp_swap_list_backward = '',
  sexp_swap_list_forward = '',
  sexp_swap_element_backward = '',
  sexp_swap_element_forward = '',
  sexp_emit_head_element = '',
  sexp_emit_tail_element = '',
  sexp_capture_prev_element = '',
  sexp_capture_next_element = '',
}
