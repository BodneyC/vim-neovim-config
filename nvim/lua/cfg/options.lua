local util = require('utl.util')

-- Disable builtins
local builtins = {
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'matchit',
  'matchparen',
  'logiPat',
  'rrhelper',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
}

for _, plugin in ipairs(builtins) do
  vim.g['loaded_' .. plugin] = '1'
end

util.opt('g', {
  large_file = 524288, -- 512k
  netrw_altv = 1,
  netrw_banner = 0,
  netrw_browse_split = 4,
  netrw_liststyle = 3,
  netrw_winsize = 14,
  python3_host_prog = '/usr/local/bin/python3',
  python_host_prog = '/usr/local/bin/python2',
  onedark_termcolors = 256,
  python_highlight_all = 1,
  vimspectrItalicComment = 'on',
})

util.opt('o', {
  autoindent = true,
  autowrite = true,
  backspace = 'indent,eol,start',
  equalalways = false,
  expandtab = true,
  fillchars = 'vert:│',
  foldmethod = 'manual',
  grepformat = '%f:%l:%c:%m',
  grepprg = 'rg --vimgrep --no-heading --smart-case',
  guifont = 'Iosevka Nerd Font:h11',
  hidden = true,
  hls = true,
  icm = 'nosplit',
  laststatus = 3,
  matchpairs = vim.o.matchpairs .. ',<:>',
  mouse = 'a',
  pumheight = 20,
  ruler = true,
  scrolloff = 1,
  shiftwidth = 0,
  shortmess = vim.o.shortmess .. 'c',
  showmode = false,
  showtabline = 0,
  smartindent = true,
  softtabstop = 0,
  spell = false,
  spelllang = 'en_gb',
  splitbelow = true,
  splitright = true,
  tabstop = 2,
  tags = '',
  termguicolors = true,
  textwidth = 0,
  title = true,
  titlestring = os.getenv('PWD'):gsub('(.*/)(.*)', '%2'),
  ttimeout = true,
  ttimeoutlen = 50,
  undodir = os.getenv('HOME') .. '/.config/nvim/undo',
  undofile = true,
  undolevels = 10000,
  undoreload = 10000,
  updatetime = 250,
  wildmode = 'longest:full,full',
  breakindent = true,
  breakindentopt = 'shift:3',
  cul = true,
  cursorcolumn = false,
  cursorline = false,
  foldenable = true,
  linebreak = true,
  nu = true,
  rnu = false,
  signcolumn = 'yes',
  winblend = 0,
  wrap = true,
  report = 10000,
})
