local util = require('utl.util')

vim.cmd 'filetype off'

util.safe_require('cfg.packer')

util.safe_require('cfg.options')
util.safe_require('cfg.augroups')
util.safe_require('cfg.remappings')
util.safe_require('cfg.commands')

util.safe_require('cfg.plugins')
util.safe_require('cfg.lsp')

util.safe_require_and_init('mod.terminal')
