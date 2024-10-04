return {
  'VonHeikemen/lsp-zero.nvim',
  version = "v4.x",
  dependencies = {
    -- LSP Support
    'neovim/nvim-lspconfig',
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',

    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'ray-x/lsp_signature.nvim',

    -- Snippets
    { 'L3MON4D3/LuaSnip',        version = 'v2.*', build = 'make install_jsregexp' },
    -- Snippet Collection (Optional)
    'rafamadriz/friendly-snippets',
  },
}
