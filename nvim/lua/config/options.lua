vim.g.mapleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.autowrite = true
vim.o.breakindent = true
vim.o.breakindentopt = 'shift:3'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.equalalways = false
vim.o.expandtab = true
vim.o.exrc = true
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.o.guifont = 'Iosevka Nerd Font:h14'
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.pumheight = 20
vim.o.report = 10000
vim.o.scrolloff = 1
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,terminal,localoptions'
vim.o.shiftwidth = 0
vim.o.showmode = false
vim.o.showtabline = 0
vim.o.signcolumn = 'yes'
vim.o.smartindent = true
vim.o.smoothscroll = true
vim.o.spelllang = 'en_gb'
vim.o.splitbelow = true
vim.o.splitkeep = 'screen'
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.tags = ''
vim.o.termguicolors = true
vim.o.title = true
vim.o.titlestring = vim.fs.basename(vim.fn.getcwd())
vim.o.ttimeoutlen = 50
vim.o.undodir = vim.fn.stdpath('config') .. '/undo'
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.updatetime = 250
vim.o.wildmode = 'longest:full,full'

vim.opt.diffopt:append('algorithm:histogram')
vim.opt.fillchars:append({ diff = '╱' })
vim.opt.matchpairs:append('<:>')
vim.opt.shortmess:append('c')
