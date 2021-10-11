local util = require('utl.util')

require('bolorscheme').setup {
  theme = 'bronzage',
  light = false,
}

util.opt('g', {
  -- Relies on this file being loaded after the plugin itself
  __buffer_first_refreshed = false,

  AutoPairsMapBS = false,
  AutoPairsMultilineClose = false,

  Hexokinase_virtualText = ' ',
  Hexokinase_highlighters = {'backgroundfull'},

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

  ['conjure#mapping#prefix'] = '\\',

  bufferline = {
    animation = true,
    auto_hide = false,
    tabpages = false,
    closable = true,
    clickable = true,
    -- exclude_ft = {},
    -- exclude_name = {},
    icons = true,
    icon_custom_colors = false,
    icon_separator_active = ' ',
    icon_separator_inactive = '  ',
    icon_close_tab = ' ',
    icon_close_tab_modified = '● ',
    insert_at_end = false,
    maximum_padding = 4,
    maximum_length = 200,
    semantic_letters = true,
    letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
    no_name_title = nil,
  },

  gutentags_cache_dir = os.getenv('HOME') .. '/.cache/vim/tags',
  gutentags_modules = {'ctags'},
  gutentags_add_default_project_roots = 0,
  gutentags_ctags_auto_set_tags = 1,
  gutentags_project_root = {'.git', '.vim'},
  gutentags_generate_on_write = 1,
  gutentags_generate_on_missing = 1,
  gutentags_generate_on_new = 1,
  gutentags_generate_on_empty_buffer = 0,
  gutentags_ctags_exclude = {'*.json'},
  gutentags_ctags_extra_args = {
    '--tag-relative=' ..
      (vim.fn.isdirectory(os.getenv('HOME') .. '/Library') == 1 and 'yes' or
        'always'),
    '--fields=+ailmnS',
  },

  indentLine_char = '│',
  indentLine_first_char = '│',
  indentLine_fileTypeExclude = {
    'packer',
    'dashboard',
    'nerdtree',
    'twiggy',
    'startify',
    'help',
    'defx',
    '',
  },

  matchup_matchparen_offscreen = {
    method = 'popup',
  },

  move_map_keys = false,

  mundo_right = 1,

  spelunker_disable_auto_group = 1,

  scrollview_excluded_filetypes = {'defx'},

  tagbar_auto_close = 1,
  tagbar_compact = 1,
  tagbar_iconchars = {'\\ua0', '\\ua0'},

  ['test#java#maventest#file_pattern'] = '\v([Tt]est.*|.*[Tt]est(s|Case)?).(java|kt)$',

  togool_extras = {{'<', '+'}, {'>', '-'}},

  twiggy_local_branch_sort = 'mru',
  twiggy_remote_branch_sort = 'date',

  vcoolor_disable_mappings = false,

  vim_markdown_folding_disabled = true,
  vim_markdown_no_default_key_mappings = true,

  vimade = {
    fadelevel = 0.6,
    enablesigns = 0,
  },

  virk_close_regexes = {
    '^$',
    'FAR.*',
    'MERGE MSG',
    'git-.*',
    'COMMIT.*',
    '.*Plugins.*',
    '^.defx].*',
  },
  virk_close_by_ft = {
    -- ["coc-explorer"] = "CocCommand explorer --no-focus --toggle " .. vim.fn.getcwd(),
    tagbar = 'TagbarOpen',
    vista = 'Vista!! | wincmd p',
    defx = 'exe \'DefxOpen\' | setlocal nobuflisted | wincmd p',
    Mundo = 'MundoShow',
  },
  virk_tags_enable = 0,

  vista_icon_indent = {'╰─▸ ', '├─▸ '},
  vista_default_executive = 'ctags',
  ['vista#renderer#icons'] = {
    variable = '\\u71b',
    ['function'] = '\\uf794',
  },
  vista_executive_for = {
    vim = 'ctags',
  },

  vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/vsnip',

})

os.execute('test -d ' .. vim.g.gutentags_cache_dir .. ' || mkdir -p ' ..
             vim.g.gutentags_cache_dir)

util.augroup({
  name = 'spelunker',
  autocmds = {
    {
      event = 'BufWinEnter,BufWritePost',
      glob = '*.md,*.txt,*.tex',
      cmd = [[call spelunker#check()]],
    },
  },
})

util.augroup({
  name = 'bufferline_update__custom',
  autocmds = {
    {
      event = 'BufEnter,BufWinEnter,SessionLoadPost,WinEnter,VimEnter',
      glob = '*',
      cmd = 'BufferOrderByBufferNumber',
    },
    {
      -- Temporary as bufferline not updating at the mo
      event = 'CursorMoved',
      glob = '*',
      cmd = [[ lua if not vim.g.__buffer_first_refreshed then ]] ..
        [[ vim.g.__buffer_first_refreshed = true; ]] ..
        [[ vim.cmd('BufferOrderByBufferNumber') end ]],
    },
  },
})

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

local mappings = {
  mode_pairs = {
    {
      mode = 'n',
      cmd = ':',
    },
    {
      mode = 'i',
      cmd = '<C-o>:',
    },
    {
      mode = 't',
      cmd = [[<C-\><C-n>:]],
    },
  },
  dir_pairs = {
    {
      key = '<M-k>',
      txt = 'Up',
    },
    {
      key = '<M-h>',
      txt = 'Left',
    },
    {
      key = '<M-j>',
      txt = 'Down',
    },
    {
      key = '<M-l>',
      txt = 'Right',
    },
    {
      key = [[<M-\>]],
      txt = 'Previous',
    },
    -- MacOS
    {
      key = '˚',
      txt = 'Up',
    },
    {
      key = '˙',
      txt = 'Left',
    },
    {
      key = '∆',
      txt = 'Down',
    },
    {
      key = '¬',
      txt = 'Right',
    },
  },
}

for _, mode in ipairs(mappings.mode_pairs) do
  for _, dir in ipairs(mappings.dir_pairs) do
    vim.api.nvim_set_keymap(mode.mode, dir.key, mode.cmd .. pane_manager ..
      'Navigate' .. dir.txt .. '<CR>', {
      noremap = true,
      silent = true,
    })
  end
end
