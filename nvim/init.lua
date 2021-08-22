local util = require 'utl.util'

-- initial
vim.o.compatible = false
vim.cmd 'filetype off'

if not os.getenv 'TERMTHEME' then
  print '$TERMTHEME not set, defaulting to \'dark\''
  vim.cmd [[let $TERMTHEME = 'dark']]
end

local function command_v(b)
  local h = io.popen('command -v ' .. b)
  local s = h:read('*a'):match('^%s*(.-)%s*$')
  h:close()
  return s
end

vim.g.python_host_prog = command_v 'python2'
vim.g.python3_host_prog = '/usr/local/bin/python3'

vim.g.polyglot_disabled = {'autoload', 'typescript'}

util.safe_require 'cfg.plugins'
util.safe_require 'cfg.interface'
util.safe_require 'cfg.pack-conf'
util.safe_require 'cfg.remappings'
util.safe_require 'cfg.lualine'
-- util.safe_require 'cfg.dap'
util.safe_require 'cfg.vimspector'
util.safe_require 'cfg.format'
util.safe_require 'cfg.gitsigns'
util.safe_require 'cfg.arduino'

util.safe_require 'cfg.lsp'

util.safe_require_and_init 'mod.terminal'
util.safe_require_and_init 'mod.highlight'
util.safe_require_and_init 'mod.defx'
util.safe_require_and_init 'mod.telescope'
