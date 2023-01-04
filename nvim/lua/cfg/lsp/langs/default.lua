local M = {}

local lspconfig = require 'lspconfig'

M.on_attach = function(client, bufnr)
  require 'cfg.lsp.keymaps'.set_keymaps(client, bufnr)
end

local default_opts = {
  on_attach = M.on_attach,
  root_dir = vim.loop.cwd,
  capabilities = require 'cfg.lsp.capabilities'.capabilities,
  settings = { telemetry = { enable = false } },
  offset_encoding = 'utf-8',
}

M.default_opts = default_opts

M.add_to_default = function(opts)
  return vim.tbl_deep_extend('force', default_opts, opts)
end

M.setup = function(server_name) lspconfig[server_name].setup(default_opts) end

return M
