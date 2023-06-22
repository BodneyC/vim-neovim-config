local present, null_ls = pcall(require, 'null-ls')

if not present then return end

local b = null_ls.builtins

local sources = {
  -- b.formatting.prettierd.with { filetypes = { 'html', 'yaml', 'markdown' } },
  -- b.formatting.stylua,
  -- b.diagnostics.shellcheck,
  b.code_actions.shellcheck,
  b.diagnostics.markdownlint.with({
    diagnostic_config = {
      virtual_text = false,
    }
  }),
}

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local on_attach = function(client, bufnr)
  if client.supports_method 'textDocument/formatting' then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { bufnr = bufnr }
        -- vim.lsp.buf.formatting_sync()
      end
    })
  end
end

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = on_attach,
}
