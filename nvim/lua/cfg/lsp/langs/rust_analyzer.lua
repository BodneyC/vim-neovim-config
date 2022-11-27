local add_to_default = require 'cfg.lsp.langs.default'.add_to_default
return function()
  local extension_path = vim.fn.glob(
    '$HOME/.vscode-oss/extensions/vadimcn.vscode-lldb-*/')
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

  require('rust-tools').setup(add_to_default {
    tools = {
      autoSetHints = true,
      hover_with_actions = true,
      inlay_hints = { show_parameter_hints = true },
    },
    server = {
      standalone = false,
      -- settings = {
      --   ['rust-analyzer'] = {
      --     -- enable clippy on save
      --     checkOnSave = {
      --       command = 'clippy',
      --     },
      --   },
      -- },
    },
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path,
        liblldb_path),
    },
  })
end
