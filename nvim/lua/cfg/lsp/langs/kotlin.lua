local lspconfig = require('lspconfig')
local home = vim.loop.os_homedir()
local add_to_default = require('cfg.lsp.langs.default').add_to_default
--[[
mkdir -p "$HOME/software" && cd "$HOME/software"
gcl https://github.com/fwcd/kotlin-language-server.git
cd kotlin-language-server
./gradlew :server:installDist
]]
return function()
  lspconfig.kotlin_language_server.setup(add_to_default({
    cmd = {
      home
        .. '/software/kotlin-language-server/server/build/install/server/bin/kotlin-language-server',
    },
  }))
end
