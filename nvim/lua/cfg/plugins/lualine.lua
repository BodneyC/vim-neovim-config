local icons = require('mod.theme').icons

require('lualine').setup {
  options = {
    globalstatus = 3,
    icons_enabled = true,
    symbols = {
      modified = '*',
      readonly = '-',
    },
    -- theme = 'bolorscheme',
    theme = 'everforest',
    component_separators = {
      left = '',
      right = '',
    },
    section_separators = {
      left = '',
      right = '',
    },
    disabled_filetypes = {'defx', ''},
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    lualine_b = {'branch'},
    lualine_c = {'filename', [[require('mod.treesitter').statusline()]]},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {
      {
        'diagnostics',
        sources = {'nvim_diagnostic'},
        sections = {'error', 'warn', 'info'},
        symbols = {
          error = icons.diagnostics.glyph.error,
          warn = icons.diagnostics.glyph.warning,
          info = icons.diagnostics.glyph.info,
        },
      },
    },
    lualine_z = {'location'},
  },
  extensions = {'fugitive', 'nvim-tree', 'quickfix', 'symbols-outline'},
}
