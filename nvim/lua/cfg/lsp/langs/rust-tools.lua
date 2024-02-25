local lsp = require('lsp-zero')

local extension_path =
  vim.fn.glob('$HOME/.vscode-oss/extensions/vadimcn.vscode-lldb-*/')
require('rust-tools').setup({
  tools = {
    autoSetHints = true,
    -- hover_with_actions = true,
    inlay_hints = { show_parameter_hints = true },
  },
  server = lsp.build_options('rust_analyzer', {}),
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      extension_path .. 'adapter/codelldb',
      extension_path .. 'lldb/lib/liblldb.so'
    ),
  },
})
