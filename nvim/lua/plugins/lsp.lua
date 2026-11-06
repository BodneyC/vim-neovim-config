local servers = {
  'ansiblels',
  'bashls',
  'clangd',
  'clojure_lsp',
  'cssls',
  'dockerls',
  'gopls',
  'helm_ls',
  'html',
  'jdtls',
  'jsonls',
  'lua_ls',
  'pyright',
  'ruff',
  'rust_analyzer',
  'terraformls',
  'yamlls',
}

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason-lspconfig').setup({ ensure_installed = servers })
      vim.lsp.enable(servers)
    end,
  },

  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    opts = {
      diagnostic = { show_code_action = false },
      lightbulb = { enable = false, enable_in_insert = false, virtual_text = false },
      symbol_in_winbar = { enabled = true, separator = ' | ', respect_root = true, folder_level = 2 },
    },
  },

  {
    'pmizio/typescript-tools.nvim',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
}
