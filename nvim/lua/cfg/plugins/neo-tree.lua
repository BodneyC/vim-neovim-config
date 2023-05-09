vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local silent = require('utl.maps').flags.s
vim.keymap.set('n', '<Leader>d', require('neo-tree').focus, silent)
vim.keymap.set('n', '<Leader>D', require('neo-tree').show, silent)

do
  local group = vim.api.nvim_create_augroup('__NEO_TREE__', {
    clear = true,
  })
  vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    group = group,
    callback = function()
      vim.cmd([[bw neo-tree\ *]])
    end
  })
end

local function system(cmd, opts)
  local manager = require("neo-tree.sources.manager")
  opts = vim.tbl_extend('keep', opts or {}, {
    run_on_dirs = false,
    append_filepath = true,
    echo_cmd = true,
  })
  return function(state)
    local tree = state.tree
    local node = tree:get_node()
    vim.pretty_print(node)
    if not node then
      return
    end
    if not opts.run_on_dirs and node.type == 'directory' then
      print('Not running for directories')
      return
    end
    local cmd_str = cmd
    if opts.append_filepath then
      cmd_str = cmd_str .. ' ' .. node.path
    end
    if opts.echo_cmd then
      print(cmd_str)
    end
    local fd = io.popen(cmd_str .. ' 2>&1')
    if fd ~= nil then
      local stdout = fd:read("*a"):gsub('[\n\r]', ' ')
      fd:close()
      print(stdout)
    else
      print("Couldn't run command: " .. cmd_str)
    end
    -- this function alway refreshes all so putting 'filesystem' here would make as much sense as 'all'
    manager.refresh('all')
  end
end

require('neo-tree').setup {
  sources = { 'filesystem', 'buffers', 'git_status', }, -- 'document_symbols' },
  -- source_selector = {
  --   winbar = true,                         -- toggle to show selector on winbar
  --   statusline = false,                    -- toggle to show selector on statusline
  --   show_scrolled_off_parent_node = false, -- boolean
  --   sources = {                            -- table
  --     {
  --       source = "filesystem",             -- string
  --       display_name = "   "            -- string | nil
  --     },
  --     {
  --       source = "buffers",  -- string
  --       display_name = "  " -- string | nil
  --     },
  --     {
  --       source = "git_status", -- string
  --       display_name = "  " -- string | nil
  --     },
  --     {
  --       source = "document_symbols", -- string
  --       display_name = " s "         -- string | nil
  --     },
  --   },
  --   content_layout = "start",                                 -- string
  --   tabs_layout = "equal",                                    -- string
  --   truncation_character = "…",                             -- string
  --   tabs_min_width = nil,                                     -- int | nil
  --   tabs_max_width = nil,                                     -- int | nil
  --   padding = 0,                                              -- int | { left: int, right: int }
  --   separator = { left = "▏", right = "▕" },              -- string | { left: string, right: string, override: string | nil }
  --   separator_active = nil,                                   -- string | { left: string, right: string, override: string | nil } | nil
  --   show_separator_on_edge = false,                           -- boolean
  --   highlight_tab = "NeoTreeTabInactive",                     -- string
  --   highlight_tab_active = "NeoTreeTabActive",                -- string
  --   highlight_background = "NeoTreeTabInactive",              -- string
  --   highlight_separator = "NeoTreeTabSeparatorInactive",      -- string
  --   highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
  -- },
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = 'rounded',
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' }, -- when opening files, do not use windows containing these filetypes or buftypes
  sort_case_insensitive = false,                                     -- used when sorting files and directories in the tree
  sort_function = nil,                                               -- use a custom function for sorting files and directories in the tree
  -- sort_function = function (a,b)
  --       if a.type == b.type then
  --           return a.path > b.path
  --       else
  --           return a.type > b.type
  --       end
  --   end , -- this sorts files and directories descendantly
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = ' ',      -- '│',
      last_indent_marker = ' ', -- '└',
      highlight = 'NeoTreeIndentMarker',
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = '',
      expander_expanded = '',
      expander_highlight = 'NeoTreeExpander',
    },
    icon = {
      folder_closed = '',
      folder_open = '',
      folder_empty = 'ﰊ',
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = '*',
      highlight = 'NeoTreeFileIcon'
    },
    modified = {
      symbol = '[+]',
      highlight = 'NeoTreeModified',
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = 'NeoTreeFileName',
    },
    git_status = {
      symbols = {
        -- Change type
        added     = '',  -- or '✚', but this is redundant info if you use git_status_colors on the name
        modified  = '',  -- or '', but this is redundant info if you use git_status_colors on the name
        deleted   = '✖', -- this can only be used in the git_status source
        renamed   = '', -- this can only be used in the git_status source
        -- Status type
        untracked = '',
        ignored   = '',
        unstaged  = '',
        staged    = '',
        conflict  = '',
      }
    },
  },
  -- A list of functions, each representing a global custom command
  -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
  -- see `:h neo-tree-global-custom-commands`
  commands = {
    ['set_executable'] = system('chmod +x', {}),
    ['unset_executable'] = system('chmod -x', {}),
    ['rem'] = system('rem --', {}),
    ['rem_dir'] = system('rem --', { run_on_dirs = true }),
    ['rem_undo'] = system('NO_COLOR==true rem last', {
      run_on_dirs = true,
      append_filepath = false,
    }),
  },
  window = {
    position = 'left',
    width = 35,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['<space>'] = {
        'toggle_node',
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ['<2-LeftMouse>'] = 'open',
      ['<cr>'] = 'open',
      ['l'] = 'open',
      ['<esc>'] = 'revert_preview',
      ['P'] = { 'toggle_preview', config = { use_float = true } },
      ['o'] = 'focus_preview',
      ['S'] = 'open_split',
      ['s'] = 'open_vsplit',
      -- ['S'] = 'split_with_window_picker',
      -- ['s'] = 'vsplit_with_window_picker',
      ['t'] = 'open_tabnew',
      -- ['<cr>'] = 'open_drop',
      -- ['t'] = 'open_tab_drop',
      ['w'] = 'open_with_window_picker',
      --['P'] = 'toggle_preview', -- enter preview mode, which shows the current node without focusing
      ['h'] = 'close_node',
      ['C'] = 'close_node',
      -- ['C'] = 'close_all_subnodes',
      ['z'] = 'close_all_nodes',
      --['Z'] = 'expand_all_nodes',
      ['a'] = {
        'add',
        -- this command supports BASH style brace expansion ('x{a,b,c}' -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = 'relative' -- 'none', 'relative', 'absolute'
        }
      },
      ['A'] = 'add_directory', -- also accepts the optional config.show_path option like 'add'. this also supports BASH style brace expansion.
      ['r'] = 'rename',
      ['y'] = 'copy_to_clipboard',
      ['x'] = 'cut_to_clipboard',
      ['p'] = 'paste_from_clipboard',
      ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like 'add':
      -- ['c'] = {
      --  'copy',
      --  config = {
      --    show_path = 'none' -- 'none', 'relative', 'absolute'
      --  }
      --}
      ['m'] = { 'move', config = { show_path = 'relative' } },
      ['q'] = 'close_window',
      ['R'] = 'refresh',
      ['?'] = 'show_help',
      ['<S-Tab>'] = 'prev_source',
      ['<Tab>'] = 'next_source',
      ['<'] = 'prev_source',
      ['>'] = 'next_source',
      ['+x'] = 'set_executable',
      ['-x'] = 'unset_executable',
    }
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = true, -- only works on Windows for hidden files/directories
      hide_by_name = {
        --'node_modules'
      },
      hide_by_pattern = { -- uses glob style patterns
        --'*.meta',
        --'*/src/*/tsconfig.json',
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --'.gitignored',
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --'.DS_Store',
        --'thumbs.db'
      },
      never_show_by_pattern = { -- uses glob style patterns
        --'.null-ls_*',
      },
    },
    follow_current_file = true,             -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    group_empty_dirs = true,                -- when true, empty folders will be grouped together
    hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- 'open_current',  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- 'disabled',    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
        ['H'] = 'toggle_hidden',
        ['/'] = '', --fuzzy_finder',
        -- ['D'] = 'fuzzy_finder_directory',
        ['#'] = '', --'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
        -- ['D'] = 'fuzzy_sorter_directory',
        ['f'] = 'fuzzy_finder',
        ['F'] = 'filter_on_submit',
        ['<c-x>'] = 'clear_filter',
        ['[c'] = 'prev_git_modified',
        [']c'] = 'next_git_modified',
        ['d'] = 'rem',
        ['D'] = 'rem_dir',
        ['u'] = 'rem_undo',
      },
      fuzzy_finder_mappings = {
        -- define keymaps for filter popup window in fuzzy_finder_mode
        ['<down>'] = 'move_cursor_down',
        ['<C-n>'] = 'move_cursor_down',
        ['<up>'] = 'move_cursor_up',
        ['<C-p>'] = 'move_cursor_up',
      },
    },
    commands = {} -- Add a custom command or override a global one using the same function name
  },
  buffers = {
    follow_current_file = true, -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    group_empty_dirs = true,    -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = {
        ['bd'] = 'buffer_delete',
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
        ['d'] = 'rem',
        ['D'] = 'rem_dir',
        ['u'] = 'rem_undo',
      }
    },
  },
  git_status = {
    window = {
      position = 'float',
      mappings = {
        ['A']  = 'git_add_all',
        ['a']  = 'git_add_file',
        ['s']  = 'git_add_file',
        ['u']  = 'git_unstage_file',
        ['gr'] = 'git_revert_file',
        ['gc'] = 'git_commit',
        ['gp'] = 'git_push',
        ['gg'] = 'git_commit_and_push',
        ['d']  = 'diff',
      }
    },
    commands = {
      ['diff'] = function(state)
        local tree = state.tree
        local node = tree:get_node()
        vim.cmd([[FloatermNew --autoclose=0 --width=0.9 --height=0.9 git diff ]] .. node.path)
      end
    }
  }
}
