local lsp_status = require('lsp-status')
local icons = require('mod.theme').icons

lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  indicator_errors = icons.error,
  indicator_warnings = icons.warning,
  indicator_info = icons.info,
  indicator_hint = icons.hint,
  indicator_ok = icons.ok,
})

vim.lsp.handlers['textDocument/publishDiagnostics'] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false, -- {space = 2, prefix = ' '},
    signs = true,
    update_in_insert = false,
  })
vim.g.diagnostic_auto_popup_while_jump = false

do
  local group = vim.api.nvim_create_augroup('__LSP__', {
    clear = true,
  })
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = '*',
    callback = function()
      require('mod.lsp').filetype(vim.bo.ft)
    end,
  })
end
