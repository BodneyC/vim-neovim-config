local vim = vim
local cfg = require'util.cfg'

vim.o.nu = true
vim.o.cul = true
vim.o.hls = true
vim.o.rnu = true
vim.o.mouse = 'a'
vim.o.tabstop = 2
vim.o.wrap = true
vim.o.winblend = 6
vim.o.ruler = true
vim.o.hidden = true
vim.o.icm = 'split'
vim.o.scrolloff = 1
vim.o.textwidth = 0
vim.o.laststatus = 2
vim.o.shiftwidth = 0
vim.o.softtabstop = 0
vim.o.ttimeout = true
vim.o.updatetime = 50
vim.o.expandtab = true
vim.o.linebreak = true
vim.o.showmode = false
vim.o.ttimeoutlen = 50
vim.o.autoindent = true
vim.o.cursorline = true
vim.o.foldenable = true
vim.o.autowrite = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.breakindent = true
vim.o.smartindent = true
vim.o.signcolumn = 'yes'
vim.o.cursorcolumn = true
vim.o.equalalways = false
vim.o.spelllang = 'en_gb'
vim.o.fillchars = 'vert:|'
vim.o.foldmethod = 'manual'
vim.o.wildmode = 'longest,full'
vim.o.breakindentopt = 'shift:3'
vim.o.backspace = 'indent,eol,start'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.guifont = 'VictorMono Nerd Font:h11'
vim.o.matchpairs = vim.o.matchpairs .. ',<:>'

vim.g.large_file = 1048576 -- 1MB
cfg.augroup([[
  augroup __CONFIG_GENERAL__
    au!
    au BufReadPost *        if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | end
    au FileType    startify if exists(":IndentLinesDisable") | exe "IndentLinesDisable" | end
    au WinEnter    *        if &nu && ! &rnu | setlocal rnu   | end
    au WinLeave    *        if &nu &&   &rnu | setlocal nornu | end
    au BufReadPre  *        lua require'util.functions'.handle_large_file()
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
