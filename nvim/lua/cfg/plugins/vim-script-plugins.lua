local util = require('utl.util')

util.opt('g', {

  rainbow_delimiters = {
    highlight = {
      'TSRainbowRed',
      'TSRainbowYellow',
      'TSRainbowBlue',
      'TSRainbowOrange',
      'TSRainbowGreen',
      'TSRainbowViolet',
      'TSRainbowCyan',
    },
  },

  -- Relies on this file being loaded after the plugin itself
  __buffer_first_refreshed = false,

  AutoPairsMapBS = false,
  AutoPairsMultilineClose = false,

  Hexokinase_virtualText = ' ',
  Hexokinase_highlighters = { 'backgroundfull' },

  Hexokinase_optInPatterns = {
    'full_hex',
    'triple_hex',
    'rgb',
    'rgba',
    'hsl',
    'hsla',
  },

  NERDSpaceDelims = 1,
  NERDDefaultAlign = 'left',

  asynctasks_term_pos = 'bottom',
  asyncrun_open = 15,

  bullets_outline_levels = { 'ROM', 'ABC', 'num', 'abc', 'rom', 'std-' },

  ['conjure#mapping#prefix'] = '\\',

  -- bufferline = {
  --   animation = true,
  --   auto_hide = false,
  --   tabpages = false,
  --   closable = true,
  --   clickable = true,
  --   -- exclude_ft = {},
  --   -- exclude_name = {},
  --   icons = true,
  --   icon_custom_colors = false,
  --   icon_separator_active = ' ',
  --   icon_separator_inactive = '  ',
  --   icon_close_tab = ' ',
  --   icon_close_tab_modified = '● ',
  --   insert_at_end = false,
  --   maximum_padding = 4,
  --   maximum_length = 200,
  --   semantic_letters = true,
  --   letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
  --   no_name_title = nil,
  -- },

  -- floaterm_wintype = 'vsplit',
  floaterm_rootmarkers = { '.project', '.git', '.hg', '.svn', '.root', '.vim' },
  floaterm_autoclose = 1,

  fzf_history_dir = os.getenv('HOME') .. '/.cache/nvim/fzf/.fzf_history_dir',

  gitblame_ignored_filetypes = { 'Outline', 'NvimTree', 'neo-tree' },

  gutentags_cache_dir = os.getenv('HOME') .. '/.cache/vim/tags',
  gutentags_modules = { 'ctags' },
  gutentags_add_default_project_roots = 0,
  gutentags_ctags_auto_set_tags = 1,
  gutentags_project_root = { '.git', '.vim' },
  gutentags_generate_on_write = 1,
  gutentags_generate_on_missing = 1,
  gutentags_generate_on_new = 1,
  gutentags_generate_on_empty_buffer = 0,
  gutentags_ctags_exclude = { '*.json' },
  gutentags_ctags_extra_args = {
    '--exclude=node_modules',
    '--tag-relative='
      .. (
        vim.fn.isdirectory(os.getenv('HOME') .. '/Library') == 1 and 'yes'
        or 'always'
      ),
    '--fields=+ailmnS',
  },

  matchup_matchparen_offscreen = {
    method = 'status', -- popup if I get rid of the winbar at some point
  },

  move_map_keys = false,

  spelunker_disable_auto_group = 1,

  scrollview_excluded_filetypes = { 'defx', 'NvimTree', 'neo-tree' },

  tagbar_auto_close = 1,
  tagbar_compact = 1,
  tagbar_iconchars = { '\\ua0', '\\ua0' },

  ['test#strategy'] = 'neovim',
  ['test#java#maventest#file_pattern'] = [[\v([Tt]est.*|.*[Tt]est(s|Case)?).(java|kt)$]],
  ['test#javascript#ava#file_pattern'] = [[\v(tests|spec)?/.*\.(js|jsx|coffee|ts|tsx)$]],
  ['test#javascript#jest#file_pattern'] = [[\v(__tests__/.*|(spec|test))\.(js|jsx|coffee|ts|tsx)$]],

  togool_extras = { { '<', '+' }, { '>', '-' } },

  twiggy_local_branch_sort = 'mru',
  twiggy_remote_branch_sort = 'date',

  vcoolor_disable_mappings = false,
})

do
  local group = vim.api.nvim_create_augroup('spelunker', {
    clear = true,
  })
  vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWritePost' }, {
    group = group,
    pattern = { '*.md', '*.txt', '*.tex' },
    command = [[call spelunker#check()]],
  })
end

-- -- terminal window manager
-- local pane_manager = 'Tmux'
-- if os.getenv('KITTY_WINDOW_ID') then
--   pane_manager = 'Kitty'
--   local kitty_listen = os.getenv('KITTY_LISTEN_ON')
--   if kitty_listen then
--     vim.g.kitty_navigator_listening_on_address = kitty_listen
--   else
--     print('KittyNavigate will not work, no KITTY_LISTEN_ON')
--   end
-- end

-- vim.g[string.lower(pane_manager) .. '_navigator_no_mappings'] = 1

-- LuaFormatter off
local mappings = {
  mode_pairs = {
    { mode = 'n', cmd = ':' },
    { mode = 'i', cmd = '<C-o>:' },
    { mode = 't', cmd = [[<C-\><C-n>:]] },
  },
  dir_pairs = {
    { key = '<M-k>', txt = 'Up' },
    { key = '<M-h>', txt = 'Left' },
    { key = '<M-j>', txt = 'Down' },
    { key = '<M-l>', txt = 'Right' },
    { key = [[<M-\>]], txt = 'Previous' },
    -- MacOS
    { key = '˚', txt = 'Up' },
    { key = '˙', txt = 'Left' },
    { key = '∆', txt = 'Down' },
    { key = '¬', txt = 'Right' },
  },
}
-- LuaFormatter on

for _, mode in ipairs(mappings.mode_pairs) do
  for _, dir in ipairs(mappings.dir_pairs) do
    vim.api.nvim_set_keymap(
      mode.mode,
      dir.key,
      mode.cmd .. 'Navigator' .. dir.txt .. '<CR>',
      {
        noremap = true,
        silent = true,
      }
    )
  end
end
