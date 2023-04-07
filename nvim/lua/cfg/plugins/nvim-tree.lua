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
  vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    group = group,
    callback = function(data)
      if vim.fn.isdirectory(data.file) == 1 then
        vim.cmd.enew()
        vim.cmd.bw(data.buf)
        vim.cmd.cd(data.file)
      else
        return -- unsure if i want this yet
      end
      require('mod.nvim-tree').resize { refocus = true }
    end
  })
  vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    group = group,
    callback = function()
      vim.cmd([[bw NvimTree_*]])
    end
  })
end

local icons = require('mod.theme').icons

require('nvim-tree').setup {

  disable_netrw = true,
  hijack_netrw = true,
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
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
  },

  view = {
    width = require('mod.nvim-tree').min_width,
    hide_root_folder = false,
    side = 'left',
  },

  on_attach = require('mod.nvim-tree').on_attach,
}
