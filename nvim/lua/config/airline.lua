local vim = vim

local cfg = require'util.cfg'

vim.g.airline_symbols = {
  crypt      = ' 🔒',
  paste      = ' Þ',
  spell      = ' Ꞩ',
  notexists  = ' Ɇ',
  whitespace = '',
  branch     = '',
  readonly   = '',
  linenr     = '',
  maxlinenr  = '',
  dirty      = ' ⚡',
}

vim.g.airline_theme = 'bolorscheme'
vim.g.airline_powerline_fonts    = 1
vim.g.airline_left_sep           = ''
vim.g.airline_left_alt_sep       = ''
vim.g.airline_right_sep          = ''
vim.g.airline_right_alt_sep      = ''
vim.g.airline_skip_empty_sections = 1
vim.g['airline#extensions#tabline#enabled']                     = 1
vim.g['airline#extensions#tabline#show_buffers']                = 0
vim.g['airline#extensions#tabline#formatter']                   = 'unique_tail_improved'
vim.g['airline#extensions#tabline#buffer_min_count']            = 2
vim.g['airline#extensions#whitespace#trailing_format']          = 'Tra(%s)'
vim.g['airline#extensions#whitespace#mixed_indent_format']      = 'Ind(%s)'
vim.g['airline#extensions#whitespace#mixed_indent_file_format'] = 'FIn(%s)'
vim.g['airline#extensions#whitespace#long_format']              = 'Lng(%s)'
vim.g['airline#extensions#whitespace#conflicts_format']         = 'Con(%s)'
vim.g['airline#extensions#vista#enabled']                       = 0
vim.g['airline#extensions#nvimlsp#enabled']                     = 0
vim.g['airline#extensions#nvimlsp#error_symbol']                = ' '
vim.g['airline#extensions#nvimlsp#warning_symbol']              = ' '

cfg.exec([[
  func! AlFileInfo()
    return luaeval("require'util.airline'.file_info()")
  endfunc
  func! AlMode()
    return luaeval("require'util.airline'.mode()")
  endfunc
  func! AlModified()
    return luaeval("require'util.airline'.modified()")
  endfunc
  func! AlNvimLsp()
    return luaeval("require'util.airline'.nvim_lsp()")
  endfunc
]])

vim.fn['airline#parts#define_function']('FileInfo', 'AlFileInfo')
vim.fn['airline#parts#define_function']('Mode', 'AlMode')
vim.fn['airline#parts#define_function']('Modified', 'AlModified')
vim.fn['airline#parts#define_function']('NvimLsp', 'AlNvimLsp')
vim.fn['airline#parts#define_raw']('Fn', '%f')
vim.fn['airline#parts#define_raw']('Position', '%l:%v')
vim.fn['airline#parts#define_raw']('MaxLineNr', '%L')

cfg.augroup([[
  augroup __AIRLINE__
    au!
    au VimEnter * lua require'util.airline'.init()
  augroup END
]])
