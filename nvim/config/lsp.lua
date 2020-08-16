local vim = vim
local nvim_lsp = require('nvim_lsp')
local diagnostic = require('diagnostic')
-- local completion = require('completion')
local lsp_status = require('lsp-status')

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  diagnostic.on_attach(client, bufnr)
  --- Completion handled in .vim
  -- completion.on_attach(client, bufnr)
end


--- General config
vim.fn.sign_define(
  "LspDiagnosticsErrorSign",       { text = " ", texthl = "LspDiagnosticsError" })
vim.fn.sign_define(
  "LspDiagnosticsWarningSign",     { text = " ", texthl = "LspDiagnosticsWarning" })
vim.fn.sign_define(
  "LspDiagnosticsInformationSign", { text = " ", texthl = "LspDiagnosticsInformation" })
vim.fn.sign_define(
  "LspDiagnosticsHintSign",        { text = "ﯦ ", texthl = "LspDiagnosticsHint" })

--- Vars
--- Status
lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '',
  indicator_hint = 'ﯦ',
  indicator_ok = '',
})

--- LSPs
nvim_lsp.pyls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
}
nvim_lsp.vimls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.html.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.rls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.dockerls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.gopls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.kotlin_language_server.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.yamlls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
-- nvim_lsp.diagnosticls.setup {
--   on_attach = on_attach,
--   capabilities = lsp_status.capabilities,
--   settings = {
--     languageserver = {
--       groovy = {
--         args = { "-jar", "/link-home/gitclones/groovy-language-server/build/libs/groovy-language-server.jar" },
--         command = "java",
--         filetypes = { "groovy" },
--         settings = {
--           groovy = {
--             classpath = { "/link-home/.m2/repository/org/spockframework/spock-core/1.1-groovy-2.4" }
--           }
--         }
--       }
--     }
--   }
-- }
