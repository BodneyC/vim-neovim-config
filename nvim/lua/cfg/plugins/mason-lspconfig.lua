return {
  'williamboman/mason-lspconfig.nvim',
  config = function()
    require('mason-lspconfig').setup({
      ensure_installed = {
        -- 'tsserver', -- npm i -g typescript-language-server
        -- 'prosemd_lsp', -- system install
        'dockerls', -- npm i -g dockerfile-language-server-nodejs
        -- Tree-sitter required
        --  npm i -g bash-language-server
        --  package-manager shellcheck
        'bashls',
        'clangd',        -- package-manager - clang
        'clojure_lsp',   -- manual - https://github.com/snoe/clojure-lsp
        'gopls',         -- go get golang.org/x/tools/gopls@latest
        'html',          -- npm i -g vscode-html-languageserver-bin
        'jsonls',        -- npm i -g vscode-json-languageserver
        -- 'vimls',         -- npm i -g vim-language-server
        'yamlls',        -- npm i -g yaml-language-server
        -- 'rls',        -- rustup component add rls rust-{analysis,src}
        'rust_analyzer', -- code --install-extension /path/.vsix
        -- 'pylsp',         -- pip3 install --user 'python-lsp-sever[all]'
        'pyright',       -- pip3 install --user pyright
        'ruff',          --
        'terraformls',   -- system install
        'lua_ls',
        'cssls',
        'jdtls',
        'diagnosticls',
        'ansiblels',
        -- 'groovyls',
        'helm_ls',
      },
    })
  end,
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
  }
}
