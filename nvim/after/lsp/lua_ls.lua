return {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim', 'Snacks' } },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME, vim.fn.stdpath('config') },
      },
      telemetry = { enable = false },
    },
  },
}
