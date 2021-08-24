local util = require('utl.util')

-- o-options
util.opt('o', {
  tags = '',
  hls = true,
  mouse = 'a',
  tabstop = 2,
  ruler = true,
  hidden = true,
  icm = 'split',
  scrolloff = 1,
  textwidth = 0,
  pumheight = 20,
  laststatus = 2,
  shiftwidth = 0,
  softtabstop = 0,
  ttimeout = true,
  updatetime = 250,
  expandtab = true,
  showmode = false,
  ttimeoutlen = 50,
  autoindent = true,
  autowrite = true,
  splitbelow = true,
  splitright = true,
  smartindent = true,
  equalalways = false,
  spelllang = 'en_gb',
  spell = false,
  fillchars = 'vert:|',
  wildmode = 'longest,full',
  backspace = 'indent,eol,start',
  shortmess = vim.o.shortmess .. 'c',
  guifont = 'VictorMono Nerd Font:h11',
  matchpairs = vim.o.matchpairs .. ',<:>',
  title = true,
  titlestring = 'bodneyc - nvim',
  showtabline = 2,
  foldmethod = 'manual',
  grepprg = 'rg --vimgrep --no-heading --smart-case',
  grepformat = '%f:%l:%c:%m',
})

local undodir = os.getenv('HOME') .. '/.config/nvim/undo'
os.execute('test -d ' .. undodir .. ' || mkdir -p ' .. undodir)
util.opt('o', {
  undodir = undodir,
  undofile = true,
  undolevels = 10000,
  undoreload = 10000,
})

local notags = os.getenv('HOME') .. '/.notags'
os.execute('test -e ' .. notags .. ' || touch ' .. notags)

-- wo-options
util.opt('wo', {
  nu = true,
  cul = true,
  rnu = true,
  wrap = true,
  winblend = 10,
  linebreak = true,
  foldenable = true,
  cursorline = true,
  breakindent = true,
  signcolumn = 'yes',
  cursorcolumn = false,
  breakindentopt = 'shift:3',
})

-- g-options
util.opt('g', {
  netrw_banner = 0,
  netrw_liststyle = 3,
  netrw_browse_split = 4,
  netrw_altv = 1,
  netrw_winsize = 14,
  large_file = 524288, -- 512k
})

-- __CONFIG_GENERAL__
util.augroup({
  name = '__CONFIG_GENERAL__',
  autocmds = {
    {
      event = 'BufReadPost',
      glob = '*',
      cmd = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | end]],
    }, {
      event = 'BufReadPre',
      glob = '*',
      cmd = [[lua require('mod.functions').handle_large_file()]],
    }, {
      event = 'FileType,BufEnter',
      glob = '*',
      cmd = [[lua require('ftplugin')(vim.bo.ft)]],
    }, {event = 'TermEnter', glob = '*', cmd = [[startinsert]]},
    {event = 'BufRead,BufNewFile', glob = '*.MD,*.md', cmd = [[setf markdown]]},
    {event = 'BufRead,BufNewFile', glob = '*.rasi', cmd = [[setf css]]},
    {
      event = 'BufRead,BufNewFile',
      glob = 'Dockerfile*',
      cmd = [[setf dockerfile]],
    }, {
      event = 'BufRead,BufNewFile',
      glob = 'Jenkinsfile*',
      cmd = [[set ft=groovy et ts=4 sw=4]],
    }, {
      event = 'BufRead,BufNewFile',
      glob = '*.xml',
      cmd = [[set ft=xml et ts=4 sw=4]],
    },
  },
})

-- vim.fn.execute('syntax on')
