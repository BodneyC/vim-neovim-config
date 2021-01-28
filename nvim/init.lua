local vim = vim

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
vim.g.python3_host_prog = command_v 'python3'

vim.g.polyglot_disabled = {'autoload', 'typescript'}

local function safe_require(module)
  local ok, err = pcall(require, module)
  if not ok then
    print('Module \'' .. module .. '\' not required: ' .. err)
    err = nil
  end
  return err
end

local function safe_require_and_init(module)
  local mod = safe_require(module)
  if mod then mod.init() end
end

safe_require 'cfg.plugins'
safe_require 'cfg.interface'
safe_require 'cfg.pack-conf'
safe_require 'cfg.remappings'
safe_require 'cfg.airline'
safe_require 'cfg.ts'
safe_require 'cfg.lsp'
safe_require 'cfg.format'
safe_require 'cfg.compe'

safe_require_and_init 'mod.terminal'
safe_require_and_init 'mod.highlight'
safe_require_and_init 'mod.defx'
safe_require_and_init 'mod.telescope'
safe_require_and_init 'mod.dashboard'
