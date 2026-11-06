local function on_move(data)
  Snacks.rename.on_rename_file(data.source, data.destination)
end

local function is_float(win)
  return vim.api.nvim_win_get_config(win).relative ~= ''
end

local function close_tree_before_quit()
  local current = vim.api.nvim_get_current_win()
  if vim.bo.filetype == 'neo-tree' or is_float(current) or vim.bo.modified then
    return
  end

  local trees = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win ~= current and not is_float(win) then
      if vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'neo-tree' then
        return
      end
      table.insert(trees, win)
    end
  end

  for _, win in ipairs(trees) do
    pcall(vim.api.nvim_win_close, win, true)
  end
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      opts = {
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          bo = {
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
            buftype = { 'terminal', 'quickfix' },
          },
        },
        other_win_hl_color = '#e35e4f',
      },
    },
  },
  keys = {
    { '<leader>\\', '<Cmd>Neotree focus<CR>', desc = 'Focus neo-tree' },
    { '<leader>|', '<Cmd>Neotree close<CR>', desc = 'Close neo-tree' },
  },
  lazy = false,
  config = function()
    local events = require('neo-tree.events')
    local system = require('util.neotree').system
    local tree_win = { id = -1, width = -1 }

    require('neo-tree').setup({
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      close_if_last_window = true,
      popup_border_style = 'rounded',
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
      default_component_configs = {
        indent = {
          indent_marker = ' ',
          last_indent_marker = ' ',
          expander_collapsed = '',
          expander_expanded = '',
        },
        icon = { default = '*' },
        modified = { symbol = '+' },
        git_status = {
          symbols = {
            added = '',
            modified = '',
            deleted = '🗑',
            renamed = '',
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
      },
      commands = {
        set_executable = system('chmod +x'),
        unset_executable = system('chmod -x'),
        rem = system('rem --'),
        rem_dir = system('rem --', { run_on_dirs = true }),
        rem_undo = system('NO_COLOR=true rem last', {
          run_on_dirs = true,
          append_filepath = false,
          append_root_dir = true,
        }),
        diff = function(state)
          vim.cmd('FloatermNew --autoclose=0 --width=0.9 --height=0.9 git diff ' .. state.tree:get_node().path)
        end,
      },
      window = {
        width = 30,
        mapping_options = { noremap = true, nowait = true },
        mappings = {
          ['l'] = 'open',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
          ['w'] = 'open_with_window_picker',
          ['h'] = 'close_node',
          ['C'] = 'close_all_subnodes',
          ['z'] = 'close_all_nodes',
          ['Z'] = 'expand_all_nodes',
          ['A'] = 'add_directory',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
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
          ['d'] = 'rem',
          ['D'] = 'rem_dir',
          ['u'] = 'rem_undo',
          ['gd'] = 'diff',
        },
      },
      filesystem = {
        components = {
          name = function(config, node, state)
            local name = require('neo-tree.sources.common.components').name(config, node, state)
            if node:get_depth() == 1 then
              name.text = vim.fs.basename(vim.uv.cwd() or '')
            end
            return name
          end,
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = true,
        },
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        hijack_netrw_behavior = 'open_default',
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ['<BS>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['H'] = 'toggle_hidden',
            ['/'] = '',
            ['#'] = '',
            ['f'] = 'fuzzy_finder',
            ['F'] = 'filter_on_submit',
            ['<C-x>'] = 'clear_filter',
            ['[c'] = 'prev_git_modified',
            [']c'] = 'next_git_modified',
          },
          fuzzy_finder_mappings = {
            ['<Down>'] = 'move_cursor_down',
            ['<C-n>'] = 'move_cursor_down',
            ['<Up>'] = 'move_cursor_up',
            ['<C-p>'] = 'move_cursor_up',
          },
        },
      },
      buffers = {
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
          mappings = {
            ['d'] = 'buffer_delete',
            ['<BS>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['D'] = '',
            ['u'] = '',
          },
        },
      },
      git_status = {
        window = {
          position = 'float',
          mappings = {
            ['A'] = 'git_add_all',
            ['a'] = 'git_add_file',
            ['r'] = 'git_unstage_file',
            ['gr'] = 'git_revert_file',
            ['gc'] = 'git_commit',
            ['gp'] = 'git_push',
            ['gg'] = 'git_commit_and_push',
          },
        },
      },
      event_handlers = {
        { event = events.VIM_WIN_ENTER, handler = require('util.neotree').close_if_last_window },
        {
          event = events.NEO_TREE_WINDOW_AFTER_OPEN,
          handler = function(args)
            tree_win.id = args.winid
            tree_win.width = vim.api.nvim_win_get_width(args.winid)
          end,
        },
        {
          event = events.NEO_TREE_WINDOW_AFTER_CLOSE,
          handler = function()
            tree_win.id = -1
          end,
        },
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      },
    })

    local group = vim.api.nvim_create_augroup('config_neo_tree', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = group,
      callback = function()
        require('neo-tree.sources.manager').refresh()
      end,
    })
    vim.api.nvim_create_autocmd('VimResized', {
      group = group,
      callback = function()
        if vim.api.nvim_win_is_valid(tree_win.id) then
          vim.schedule(function()
            vim.api.nvim_win_set_width(tree_win.id, tree_win.width)
          end)
        end
      end,
    })
    vim.api.nvim_create_autocmd('WinResized', {
      group = group,
      callback = function()
        if vim.api.nvim_win_is_valid(tree_win.id) then
          tree_win.width = vim.api.nvim_win_get_width(tree_win.id)
        end
      end,
    })
    vim.api.nvim_create_autocmd('QuitPre', {
      group = group,
      desc = 'Close neo-tree before quitting the last file window',
      callback = close_tree_before_quit,
    })
  end,
}
