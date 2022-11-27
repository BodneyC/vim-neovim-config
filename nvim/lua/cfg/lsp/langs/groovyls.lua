local lspconfig = require 'lspconfig'
local home = vim.loop.os_homedir()
local add_to_default = require 'cfg.lsp.langs.default'.add_to_default
--[[
mkdir -p "$HOME/software" && cd "$HOME/software"
gcl https://github.com/prominic/groovy-language-server
cd groovy-language-server
./gradlew build
]]
return function()
  lspconfig.groovyls.setup(add_to_default {
    cmd = {
      'java',
      '-jar',
      home ..
          '/software/groovy-language-server/build/libs/groovy-language-server-all.jar',
    },
    filetypes = { 'groovy' },
    root_dir = require('lspconfig.util').root_pattern('.git') or home,
    settings = {
      groovy = {
        classpath = {
          home .. '/.m2/repository/org/spockframework/spock-core/1.1-groovy-2.4',
        },
      },
    },
  })
end
