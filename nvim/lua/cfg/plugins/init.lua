local util = require('utl.util')

local confs = {
  'cfg.plugins.pack-conf',
  'cfg.plugins.auto-session',
  'cfg.plugins.boole',
  'cfg.plugins.bufferline',
  'cfg.plugins.bufresize',
  'cfg.plugins.everforest',
  'cfg.plugins.gitsigns',
  'cfg.plugins.indent-blankline',
  'cfg.plugins.lualine',
  'cfg.plugins.mason',
  'cfg.plugins.neotest',
  'cfg.plugins.nvim-autopairs',
  'cfg.plugins.nvim-dap-python',
  'cfg.plugins.nvim-tree',
  'cfg.plugins.nvim-treesitter-endwise',
  'cfg.plugins.nvim-ts-rainbow',
  'cfg.plugins.session-lens',
  'cfg.plugins.stabilize',
  'cfg.plugins.telescope',
  'cfg.plugins.tree-sitter',
  'cfg.plugins.todo-comments',
  'cfg.plugins.which-key',
 }

for _, conf in ipairs(confs) do util.safe_require(conf) end
