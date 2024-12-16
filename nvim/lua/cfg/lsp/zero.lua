local lsp_zero = require('lsp-zero')
-- local util = require('utl.util')

lsp_zero.extend_lspconfig({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  lsp_attach = require('cfg.lsp.keymaps').set_keymaps,
  float_border = 'rounded',
  sign_text = true,

  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
})

lsp_zero.set_sign_icons(require('mod.theme').icons.diagnostics.glyph)

require('cfg.lsp.cmp').zero_cmp_config()

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
    -- 'vimls', -- npm i -g vim-language-server
    'yamlls',        -- npm i -g yaml-language-server
    -- 'rls', -- rustup component add rls rust-{analysis,src}
    'rust_analyzer', -- code --install-extension /path/.vsix
    -- 'pylsp', -- pip3 install --user 'python-lsp-sever[all]'
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
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            telemetry = {
              enable = false
            },
          },
        },
        on_init = function(client)
          local join = vim.fs.joinpath
          local path = client.workspace_folders[1].name

          -- Don't do anything if there is project local config
          ---@diagnostic disable-next-line: undefined-field
          if vim.uv.fs_stat(join(path, '.luarc.json'))
              ---@diagnostic disable-next-line: undefined-field
              or vim.uv.fs_stat(join(path, '.luarc.jsonc'))
          then
            return
          end

          -- Apply neovim specific settings
          local runtime_path = vim.split(package.path, ';')
          table.insert(runtime_path, join('lua', '?.lua'))
          table.insert(runtime_path, join('lua', '?', 'init.lua'))

          local nvim_settings = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              version = 'LuaJIT',
              path = runtime_path
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' }
            },
            workspace = {
              checkThirdParty = false,
              library = {
                -- Make the server aware of Neovim runtime files
                vim.env.VIMRUNTIME,
                vim.fn.stdpath('config'),
              },
            },
          }

          client.config.settings.Lua = vim.tbl_deep_extend(
            'force',
            client.config.settings.Lua,
            nvim_settings
          )
        end,
      })
    end,
    rust_analyzer = lsp_zero.noop,
    -- tsserver = lsp.noop,
    diagnosticls = lsp_zero.noop,
  }
})

lsp_zero.configure('diagnosticls', require('cfg.lsp.langs.diagnosticls'))

-- lsp.configure('groovyls', require('cfg.lsp.langs.groovyls'))

-- util.safe_require('cfg.lsp.langs.rust-tools')
-- util.safe_require('cfg.lsp.langs.typescript')

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
    })
