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

safe_require 'cfg.interface'
safe_require 'cfg.plugin-configuration'
safe_require 'cfg.remappings'
safe_require 'cfg.airline'
safe_require 'cfg.ts'
safe_require 'cfg.lsp'
safe_require 'cfg.format'

safe_require_and_init 'mod.terminal'
safe_require_and_init 'mod.highlight'
safe_require_and_init 'mod.defx'
