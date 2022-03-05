local util = require('utl.util')

vim.api.nvim_set_keymap('n', '<Leader>d',
  [[<CMD>lua require('mod.nvim-tree').resize {refocus = false}<CR>]], {
    silent = true,
    noremap = true,
  })

vim.api.nvim_set_keymap('n', '<Leader>D',
  [[<CMD>lua require('mod.nvim-tree').resize {refocus = true}<CR>]], {
    silent = true,
    noremap = true,
  })

local icons = require('mod.theme').icons

util.augroup({
  name = '__NVIM_TREE__',
  autocommands = {
    {
      event = 'VimResized',
      glob = '*',
      lua_fn = function()
        if require('nvim-tree.view').is_visible() then
          require('mod.nvim-tree').resize {
            refocus = true,
          }
        end
      end,
      silent = false,
    },
  },
})

util.opt('g', {
  nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = icons.git.unstaged,
      staged = icons.git.staged,
      unmerged = icons.git.unmerged,
      renamed = icons.git.renamed,
      untracked = icons.git.untracked,
      deleted = icons.git.deleted,
      ignored = icons.git.ignored,
    },
    folder = {
      arrow_open = '',
      arrow_closed = '',
      default = '',
      open = '',
      empty = '',
      empty_open = '',
      symlink = '',
      symlink_open = '',
    },
  },
  nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
  },
})

local system_cb = require('mod.nvim-tree').system_cb
local tree_cb = require('nvim-tree.config').nvim_tree_callback

require('nvim-tree').setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  auto_close = true,
  open_on_tab = false,
  update_to_buf_dir = {
    enable = true,
    auto_open = true,
  },
  hijack_cursor = false,
  update_cwd = false,
  diagnostics = {
    enable = true,
    icons = {
      hint = icons.diagnostics.sign.hint,
      info = icons.diagnostics.sign.info,
      warning = icons.diagnostics.sign.warning,
      error = icons.diagnostics.sign.error,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        exclude = {
          filetype = {
            'notify',
            'packer',
            'qf',
            'diff',
            'fugitive',
            'fugitiveblame',
            'Outline',
          },
          buftype = {'nofile', 'terminal', 'help'},
        },
      },
    },
  },
  view = {
    width = require('mod.nvim-tree').min_width,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        {
          key = 'Y',
          cb = tree_cb('copy'),
        },
        {
          key = 'l',
          cb = tree_cb('open_node'),
        },
        {
          key = 'h',
          cb = tree_cb('close_node'),
        },
        {
          key = '+x',
          cb = system_cb('chmod +x'),
        },
        {
          key = '-x',
          cb = system_cb('chmod -x'),
        },
        {
          key = 'd',
          cb = system_cb('rem -q --'),
        },
        {
          key = 'D',
          cb = system_cb('rem -q --', {
            directories = true,
          }),
        },
        {
          key = 'u',
          cb = system_cb('rem last -q', {
            directories = true,
            ignore_file = true,
          }),
        },
        {
          key = 'U',
          cb = system_cb('rem last -qy', {
            directories = true,
            ignore_file = true,
          }),
        },
      },
    },
  },
}
