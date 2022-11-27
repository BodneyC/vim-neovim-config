local icons = require('mod.theme').icons

local signs = {
  { name = 'DiagnosticSignError', text = icons.diagnostics.sign.error },
  { name = 'DiagnosticSignWarn', text = icons.diagnostics.sign.warning },
  { name = 'DiagnosticSignHint', text = icons.diagnostics.sign.hint },
  { name = 'DiagnosticSignInfo', text = icons.diagnostics.sign.info },
 }

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name,
    { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config({
  underline = true,
  update_in_insert = true,
  virtual_lines = { only_current_line = true },
  virtual_text = false,
  -- virtual_text = {
  --  spacing = 4,
  --  source = 'always',
  --  severity = {
  --    min = vim.diagnostic.severity.HINT,
  --  },
  --  -- todo: icons for diagnostics?
  --  --[[ format = function(diagnostic)
  --      if diagnostic.severity == vim.diagnostic.severity.ERROR then
  --        return string.format('E: %s', diagnostic.message)
  --      end
  --      return diagnostic.message
  --    end, ]]
  -- },
  signs = { active = signs },
  severity_sort = true,
  float = { show_header = false, source = 'always', border = 'single' },
 })
