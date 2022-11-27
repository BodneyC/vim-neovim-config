-- Nicked from cosmic
vim.diagnostic.config({
  underline = true,
  update_in_insert = true,
  virtual_lines = {
    only_current_line = true,
  },
  virtual_text = false,
  --virtual_text = {
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
  --},
  signs = true,
  severity_sort = true,
  float = {
    show_header = false,
    source = 'always',
    border = 'single',
  },
})

local icons = require('mod.theme').icons

do
  local signs = {
    Error = icons.diagnostics.sign.error,
    Warn = icons.diagnostics.sign.warning,
    Hint = icons.diagnostics.sign.hint,
    Info = icons.diagnostics.sign.info,
  }

  local t = vim.fn.sign_getdefined('DiagnosticSignWarn')
  if vim.tbl_isempty(t) then
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = '',
      })
    end
  end
end

do
  local signs = {
    Error = icons.diagnostics.sign.error,
    Warning = icons.diagnostics.sign.warning,
    Hint = icons.diagnostics.sign.hint,
    Information = icons.diagnostics.sign.info,
  }
  local h = vim.fn.sign_getdefined('LspDiagnosticsSignWarn')
  if vim.tbl_isempty(h) then
    for type, icon in pairs(signs) do
      local hl = 'LspDiagnosticsSign' .. type
      vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = '',
      })
    end
  end
end
