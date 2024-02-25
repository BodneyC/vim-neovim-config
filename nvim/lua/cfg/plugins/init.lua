local util = require('utl.util')

local confs = {
  'cfg.plugins.vim-script-plugins',
  -- 'cfg.plugins.nvim-tree',
  'cfg.plugins.neo-tree',
  -- 'cfg.plugins.neotest',
  -- 'cfg.plugins.telescope',
  'cfg.plugins.luasnip',
}

for _, conf in ipairs(confs) do
  util.safe_require(conf)
end
