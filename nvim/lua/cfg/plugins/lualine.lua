require('lualine').setup {
  options = {
    icons_enabled = true,
    symbols = {
      modified = '*',
      readonly = '-',
    },
    theme = 'bolorscheme',
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
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {
      {
        'diagnostics',
        sources = {'nvim_diagnostic'},
        sections = {'error', 'warn', 'info'},
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
        },
      },
    },
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype', 'location'},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    -- lualine_a = {'buffers'},
    -- lualine_x = {[[require('nvim-treesitter').statusline()]]},
  },
  extensions = {'fugitive'},
}
