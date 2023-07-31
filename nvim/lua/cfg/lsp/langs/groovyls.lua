local util = require 'lspconfig.util'
local add_to_default = require 'cfg.lsp.langs.default'.add_to_default
--[[
mkdir -p "$HOME/software" && cd "$HOME/software"
gcl https://github.com/prominic/groovy-language-server
cd groovy-language-server
./gradlew build
]]
return add_to_default {
  cmd = { 'groovy-language-server' },
  filetypes = { 'groovy' },
  root_dir = function(fname)
    return util.root_pattern 'Jenkinsfile' (fname) or util.find_git_ancestor(fname)
  end,
  settings = {
    groovy = {
      classpath = {
        [vim.fn.expand('/home/benjc/Documents/groovy-linting/groovyls/jars/WEB-INF/lib/*jenkins*.jar')] = true
      },
    },
  },
}
