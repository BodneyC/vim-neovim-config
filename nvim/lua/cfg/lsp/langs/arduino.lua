local home = vim.loop.os_homedir()
local lspconfig = require('lspconfig')
local add_to_default = require('cfg.lsp.langs.default').add_to_default
--[[
go get github.com/arduino/arduino-language-server
package-manager arduino-cli
arduino-cli core install arduino:avr # or other platform
]]
return function()
  lspconfig.arduino_language_server.setup(add_to_default({
    cmd = {
      'arduino-language-server',
      '-cli-config=' .. home .. '/.arduino15/arduino-cli.yaml',
      '-log',
      '-logpath=' .. home .. '/.arduino15/lsp-logs',
    },
  }))
end
