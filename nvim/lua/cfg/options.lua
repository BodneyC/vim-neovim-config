vim.cmd('let mapleader=" "')

-- Disable builtins
local builtins = {
  'gzip',
  -- 'zip',
  -- 'zipPlugin',
  -- 'tar',
  -- 'tarPlugin',
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

vim.g.large_file = 524288 -- 512k
vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 14
vim.g.python3_host_prog = '/usr/local/bin/python3'
vim.g.python_host_prog = '/usr/local/bin/python2'
vim.g.onedark_termcolors = 256
vim.g.python_highlight_all = 1
vim.g.vimspectrItalicComment = 'on'

vim.o.autoindent = true
vim.o.autowrite = true
vim.o.backspace = 'indent,eol,start'
vim.o.equalalways = false
vim.o.expandtab = true
vim.o.fillchars = 'vert:│'
vim.o.foldmethod = 'manual'
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.o.guifont = 'Iosevka Nerd Font:h11'
vim.o.hidden = true
vim.o.hls = true
vim.o.icm = 'nosplit'
vim.o.laststatus = 3
vim.o.matchpairs = vim.o.matchpairs .. ',<:>'
vim.o.mouse = 'a'
vim.o.pumheight = 20
vim.o.ruler = true
vim.o.scrolloff = 1
vim.o.shiftwidth = 0
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.showmode = false
vim.o.showtabline = 0
vim.o.smartindent = true
vim.o.softtabstop = 0
vim.o.spell = false
vim.o.spelllang = 'en_gb'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.tags = ''
vim.o.termguicolors = true
vim.o.textwidth = 0
vim.o.title = true
vim.o.titlestring = os.getenv('PWD'):gsub('(.*/)(.*)', '%2')
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50
vim.o.undodir = os.getenv('HOME') .. '/.config/nvim/undo'
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.undoreload = 10000
vim.o.updatetime = 250
vim.o.wildmode = 'longest:full,full'
vim.o.breakindent = true
vim.o.breakindentopt = 'shift:3'
vim.o.cul = true
vim.o.cursorcolumn = false
vim.o.cursorline = false
vim.o.foldenable = true
vim.o.linebreak = true
vim.o.nu = true
vim.o.rnu = false
vim.o.signcolumn = 'yes'
vim.o.winblend = 0
vim.o.wrap = true
vim.o.report = 10000
