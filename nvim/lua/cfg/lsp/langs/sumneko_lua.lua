local lspconfig = require 'lspconfig'
local add_to_default = require'cfg.lsp.langs.default'.add_to_default
--[[
  mkdir -p "$HOME/software" && cd "$HOME/software"
  gcl https://github.com/sumneko/lua-language-server.git
  cd lua-language-server
  git submodule update --init --recursive
  cd 3rd/luamake && compile/install.sh
  cd -
  ./3rd/luamake/luamake rebuild
  ]]
return function()
  lspconfig.sumneko_lua.setup (add_to_default{
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } },
        workspace = {
          checkThirdParty = false,
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
        telemetry = { enable = false },
      },
    },
  })
end
