local M = {}

-- base capabilities + cmp
-- should contain vim.lsp.protocol.make_client_capabilities()
M.capabilities = require'cmp_nvim_lsp'.default_capabilities()

M.capabilities.textDocument.completion.completionItem.snippetSupport = true

-- ufo (folding) related capabilities
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
 }
M.capabilities.offsetEncoding = { 'utf-8' }

return M
