local M = {}

local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.offsetEncoding = { 'utf-8' }

local default_opts = {
  on_attach = function(client, bufnr)
    require('cfg.lsp.keymaps').set_keymaps(client, bufnr)
  end,
  root_dir = vim.loop.cwd,
  capabilities = capabilities,
  settings = { telemetry = { enable = false } },
  offset_encoding = 'utf-8',
}

M.default_opts = default_opts

function M.add_to_default(opts)
  return vim.tbl_deep_extend('force', default_opts, opts)
end

function M.setup(server_name)
  lspconfig[server_name].setup(default_opts)
end

return M
