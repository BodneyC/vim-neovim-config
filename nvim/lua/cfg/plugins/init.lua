local util = require('utl.util')

util.safe_require('cfg.plugins.pack-conf')
util.safe_require('cfg.plugins.lualine')
util.safe_require('cfg.plugins.bufferline')
util.safe_require('cfg.plugins.gitsigns')
util.safe_require('cfg.plugins.nvim-tree')
util.safe_require('cfg.plugins.floaterm')

util.safe_require_and_init('mod.telescope')
