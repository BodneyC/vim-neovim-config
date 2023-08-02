local util = require('utl.util')
local helm = require('mod.helm')
util.command('HelmLookup', helm.lookup)

local mapper = require('utl.mapper')
local map = mapper({ noremap = true, silent = true })
map('n', '<C-]>', '<CMD>HelmLookup<CR>', 'Go to definition')
