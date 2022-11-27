-- vim.opt.list = true
-- vim.opt.listchars:append('eol:↩')
require('indent_blankline').setup {
  char = '│',
  show_first_indent_level = true,
  -- show_end_of_line = true,
  filetype_exclude = { 'packer', 'floaterm', 'help', 'Outline', 'NvimTree', '' },
 }
