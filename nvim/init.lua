local util = require('utl.util')

vim.cmd 'filetype off'

util.safe_require('cfg.plugins')
util.safe_require('cfg.options')
util.safe_require('cfg.augroups')
util.safe_require('cfg.pack-conf')
util.safe_require('cfg.remappings')
util.safe_require('cfg.commands')

util.safe_require('cfg.lualine')
util.safe_require('cfg.vimspector')
util.safe_require('cfg.format')
util.safe_require('cfg.gitsigns')
util.safe_require('cfg.lsp')

util.safe_require_and_init('mod.terminal')
util.safe_require_and_init('mod.defx')
util.safe_require_and_init('mod.telescope')
