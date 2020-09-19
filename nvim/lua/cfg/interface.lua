local vim = vim
local util = require'utl.util'

vim.o.tags = ''
vim.o.hls = true
vim.o.mouse = 'a'
vim.o.tabstop = 2
vim.o.ruler = true
vim.o.hidden = false
vim.o.icm = 'split'
vim.o.scrolloff = 1
vim.o.textwidth = 0
vim.o.pumheight = 20
vim.o.laststatus = 2
vim.o.shiftwidth = 0
vim.o.softtabstop = 0
vim.o.ttimeout = true
vim.o.updatetime = 50
vim.o.expandtab = true
vim.o.showmode = false
vim.o.ttimeoutlen = 50
vim.o.autoindent = true
vim.o.autowrite = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.smartindent = true
vim.o.equalalways = false
vim.o.spelllang = 'en_gb'
vim.o.fillchars = 'vert:|'
vim.o.wildmode = 'longest,full'
vim.o.backspace = 'indent,eol,start'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.guifont = 'VictorMono Nerd Font:h11'
vim.o.matchpairs = vim.o.matchpairs .. ',<:>'

-- Maybe a bug, but opening a file from the command line (e.g. 
--   `nvim .eslintrc.json`) causes the `.o.` options to be
--   ignored...
vim.bo.tabstop = 2
vim.bo.shiftwidth = 0
vim.bo.softtabstop = 0

vim.wo.nu = true
vim.wo.cul = true
vim.wo.rnu = true
vim.wo.wrap = true
vim.wo.winblend = 6
vim.wo.linebreak = true
vim.wo.foldenable = true
vim.wo.cursorline = true
vim.wo.breakindent = true
vim.wo.signcolumn = 'yes'
vim.wo.cursorcolumn = true
vim.wo.foldmethod = 'manual'
vim.wo.breakindentopt = 'shift:3'

vim.g.large_file = 1048576 -- 1MB
util.augroup([[
  augroup __CONFIG_GENERAL__
    au!
    au BufReadPost *        if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | end
    au WinEnter    *        if &nu && ! &rnu | setlocal rnu   | end
    au WinLeave    *        if &nu &&   &rnu | setlocal nornu | end
    au BufReadPre  *        lua require'mod.functions'.handle_large_file()
    au BufRead,BufNewFile *.MD set ft=markdown
  augroup END
]])

local undodir = os.getenv('HOME') .. '/.config/nvim/undo'
os.execute('test -d ' .. undodir .. ' || mkdir -p ' .. undodir)
vim.o.undodir = undodir
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.undoreload = 10000

local notags = os.getenv('HOME') .. '/.notags'
os.execute('test -e ' .. notags .. ' || touch ' .. notags)

vim.fn.execute('syntax on')
