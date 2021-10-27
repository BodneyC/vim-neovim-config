-- Nicked from cosmic

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = 'always',
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    -- todo: icons for diagnostics?
    --[[ format = function(diagnostic)
        if diagnostic.severity == vim.diagnostic.severity.ERROR then
          return string.format('E: %s', diagnostic.message)
        end
        return diagnostic.message
      end, ]]
  },
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
    Error = icons.diagnostics.error,
    Warn =  icons.diagnostics.warn,
    Hint =  icons.diagnostics.hint,
    Info =  icons.diagnostics.info,
  }

  local t = vim.fn.sign_getdefined('DiagnosticSignWarn')
  -- print("WANK " .. vim.inspect(signs))
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
    Error = icons.diagnostics.error,
    Warning =  icons.diagnostics.warn,
    Hint =  icons.diagnostics.hint,
    Information =  icons.diagnostics.info,
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
