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
      hint = icons.hint,
      info = icons.info,
      warning = icons.warning,
      error = icons.error,
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
          key = 'l',
          cb = tree_cb('open_node'),
        },
        {
          key = 'h',
          cb = tree_cb('close_node'),
        },
      },
    },
  },
}
