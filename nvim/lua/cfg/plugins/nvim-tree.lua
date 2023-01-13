local s = require('utl.maps').flags.s

vim.keymap.set('n', '<Leader>d', function()
  return require('mod.nvim-tree').resize {
    refocus = false,
  }
end, s)

vim.keymap.set('n', '<Leader>D', function()
  return require('mod.nvim-tree').resize {
    refocus = true,
  }
end, s)

vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && ]] ..
          [[bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

do
  local group = vim.api.nvim_create_augroup('__NVIM_TREE__', {
    clear = true,
  })
  vim.api.nvim_create_autocmd('VimResized', {
    group = group,
    pattern = '*',
    callback = function()
      if require('nvim-tree.view').is_visible() then
        require('mod.nvim-tree').resize {
          refocus = true,
        }
      end
    end,
  })
end

local icons = require('mod.theme').icons

local system_cb = require('mod.nvim-tree').system_cb
local tree_cb = require('nvim-tree.config').nvim_tree_callback

require('nvim-tree').setup {

  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,

  hijack_directories = {
    enable = true,
    auto_open = true,
  },

  diagnostics = {
    enable = true,
    icons = {
      hint = icons.diagnostics.sign.hint,
      info = icons.diagnostics.sign.info,
      warning = icons.diagnostics.sign.warn,
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

  renderer = {
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = false,
      },
      glyphs = {
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
    },
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
    hide_root_folder = false,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {
        -- LuaFormatter off
        { key = 'Y', cb = tree_cb('copy'), },
        { key = 'l', cb = tree_cb('open_node'), },
        { key = 'h', cb = tree_cb('close_node'), },
        { key = '+x', cb = system_cb('chmod +x'), },
        { key = '-x', cb = system_cb('chmod -x'), },
        { key = 'd', cb = system_cb('rem -q --'), },
        { key = 'D', cb = system_cb('rem -q --', { directories = true, }), },
        { key = 'u', cb = system_cb('rem last -q', { directories = true, ignore_file = true, }), },
        { key = 'U', cb = system_cb('rem last -qy', { directories = true, ignore_file = true, }), },
        -- LuaFormatter on
      },
    },
  },
}
