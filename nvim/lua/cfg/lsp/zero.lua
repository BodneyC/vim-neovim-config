local lsp = require('lsp-zero')
local util = require('utl.util')

lsp.ensure_installed({
  'tsserver', -- npm i -g typescript-language-server
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
  -- 'vimls', -- npm i -g vim-language-server
  'yamlls',        -- npm i -g yaml-language-server
  -- 'rls', -- rustup component add rls rust-{analysis,src}
  'rust_analyzer', -- code --install-extension /path/.vsix
  'pylsp',         -- pip3 install --user 'python-lsp-sever[all]'
  -- 'pyright', -- pip3 install --user pyright
  'terraformls',   -- system install
  'lua_ls',
  'cssls',
  'jdtls',
  'diagnosticls',
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
})

lsp.set_sign_icons(require('mod.theme').icons.diagnostics.glyph)

-- setup sumneko_lua for lua, strangely named function
lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
  require('cfg.lsp.keymaps').set_keymaps(client, bufnr)
end)

lsp.setup_nvim_cmp(require('cfg.lsp.cmp').zero_cmp_config())

lsp.configure('diagnosticls', require('cfg.lsp.langs.diagnosticls'))

lsp.skip_server_setup({ 'rust_analyzer', 'tsserver' })

lsp.setup()

----------------------------------------- further configuration

util.safe_require('cfg.lsp.cmp').post_zero_setup()

----------------------------------------- lsps configured elsewhere

util.safe_require('cfg.lsp.langs.rust-tools')
util.safe_require('cfg.lsp.langs.typescript')
