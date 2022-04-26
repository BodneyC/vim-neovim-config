local util = require('utl.util')
local fn_store = require('utl.fn_store')

local lspconfig = require('lspconfig')
-- local configs = require('lspconfig/configs')
local lsp_status = require('lsp-status')

local home = vim.loop.os_homedir()

vim.lsp.handlers['textDocument/publishDiagnostics'] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false, -- {space = 2, prefix = ' '},
    signs = true,
    update_in_insert = false,
  })
vim.g.diagnostic_auto_popup_while_jump = false

do
  local group = vim.api.nvim_create_augroup('__LSP__', {
    clear = true,
  })
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = 'java',
    callback = require('mod.jdtls').init,
  })
end

local icons = require('mod.theme').icons

lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  indicator_errors = icons.error,
  indicator_warnings = icons.warning,
  indicator_info = icons.info,
  indicator_hint = icons.hint,
  indicator_ok = icons.ok,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local completionItem = capabilities.textDocument.completion.completionItem
completionItem.snippetSupport = true
completionItem.preselectSupport = true
completionItem.insertReplaceSupport = true
completionItem.labelDetailsSupport = true
completionItem.deprecatedSupport = true
completionItem.commitCharactersSupport = true
completionItem.tagSupport = {
  valueSet = {1},
}
completionItem.resolveSupport = {
  properties = {'documentation', 'detail', 'additionalTextEdits'},
}
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function on_attach(client, bufnr)
  if vim.bo[bufnr].buftype ~= '' or vim.bo[bufnr].filetype == 'helm' then
    vim.diagnostic.disable()
  end
  lsp_status.on_attach(client)
end

for _, lsp in ipairs({
  'tsserver', -- npm i -g typescript-language-server
  'dockerls', -- npm i -g dockerfile-language-server-nodejs
  'bashls', -- npm i -g bash-language-server
  'clangd', -- package-manager - clang
  -- 'clojure_lsp', -- manual - https://github.com/snoe/clojure-lsp
  -- 'gopls', -- go get golang.org/x/tools/gopls@latest
  'html', -- npm i -g vscode-html-languageserver-bin
  'jsonls', -- npm i -g vscode-json-languageserver
  -- 'vimls', -- npm i -g vim-language-server
  'yamlls', -- npm i -g yaml-language-server
  -- 'rls', -- rustup component add rls rust-{analysis,src}
  -- 'rust_analyzer', -- code --install-extension /path/.vsix
  'pylsp', -- pip3 install --user 'python-lsp-sever[all]'
  -- 'pyright', -- pip3 install --user pyright
  'texlab', -- package-manager - texlab
  'terraformls', -- system install
}) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local system_name
if vim.fn.has('mac') == 1 then
  system_name = 'macOS'
elseif vim.fn.has('unix') == 1 then
  system_name = 'Linux'
elseif vim.fn.has('win32') == 1 then
  system_name = 'Windows'
else
  print('Unsupported system for sumneko')
end

local sumneko_root_path = vim.fn.expand('$HOME') ..
                            '/software/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name ..
                         '/lua-language-server'

local path = vim.split(package.path, ';')
table.insert(path, 'lua/?.lua')
table.insert(path, 'lua/?/init.lua')

--[[
mkdir -p "$HOME/software" && cd "$HOME/software"
gcl https://github.com/sumneko/lua-language-server.git
cd lua-language-server
git submodule update --init --recursive
cd 3rd/luamake && compile/install.sh
cd -
./3rd/luamake/luamake rebuild
--]]
lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('', true),
        -- library = {
        --   [vim.fn.expand('$VIMRUNTIME')] = true,
        --   [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        --   [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        --   [home .. '/.local/share/nvim/runtime/lua/vim/lsp'] = true,
        --   [home .. '/gitclones/vim-neovim-config/nvim/lua'] = true,
        -- },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

--[[
go get github.com/arduino/arduino-language-server
package-manager arduino-cli
arduino-cli core install arduino:avr # or other platform
]]
-- if not lspconfig.arduino_lsp then
--   configs.arduino_lsp = {
--     default_config = {
--       cmd = {
--         'arduino-language-server',
--         '-cli-config=' .. home .. '/.arduino15/arduino-cli.yaml',
--         '-log',
--         '-logpath=' .. home .. '/.arduino15/lsp-logs',
--       },
--       filetypes = {'arduino'},
--       root_dir = function(fname)
--         return lspconfig.util.find_git_ancestor(fname) or home
--       end,
--       settings = {},
--     },
--   }
-- end
-- lspconfig.arduino_lsp.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

--[[
mkdir -p "$HOME/software" && cd "$HOME/software"
gcl https://github.com/prominic/groovy-language-server
cd groovy-language-server
./gradlew build
]]
lspconfig.groovyls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    'java',
    '-jar',
    home ..
      '/software/groovy-language-server/build/libs/groovy-language-server-all.jar',
  },
  filetypes = {'groovy'},
  root_dir = require('lspconfig.util').root_pattern('.git') or home,
  settings = {
    groovy = {
      classpath = {
        home .. '/.m2/repository/org/spockframework/spock-core/1.1-groovy-2.4',
      },
    },
  },
}

--[[
mkdir -p "$HOME/software" && cd "$HOME/software"
gcl https://github.com/fwcd/kotlin-language-server.git
cd kotlin-language-server
./gradlew :server:installDist
]]
lspconfig.kotlin_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    home ..
      '/software/kotlin-language-server/server/build/install/server/bin/kotlin-language-server',
  },
}

-- npm i -g diagnostic-languageserver
lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {'pkgbuild', 'terraform', 'sh', 'zsh', 'markdown'},
  init_options = {
    filetypes = {
      pkgbuild = 'pkgbuild',
      terraform = 'terraform',
      zsh = 'shellcheck_zsh',
      sh = 'shellcheck',
      markdown = 'markdown',
    },
    formatFiletypes = {
      sh = 'shfmt',
      zsh = 'shfmt',
    },
    -- package-manager - shfmt
    formatters = {
      shfmt = {
        args = {'-i=2', '-bn', '-ci', '-sr'},
        command = 'shfmt',
      },
    },
    linters = {
      markdown = {
        -- npm i -g markdownlint
        command = 'markdownlint',
        args = {'--stdin'},
        isStderr = true,
        isStdout = false,
        formatPattern = {
          -- README.md:3:81 MD013/line-length Line length [Expected: 80; Actual: 282]
          '^[^:]+(:)(\\d+):?(\\d*)\\s+(.*)$',
          {
            security = 1,
            line = 2,
            column = 3,
            message = 4,
          },
        },
        offsetColumn = 0,
        offsetLine = 0,
        securities = {
          error = 'error',
          note = 'info',
          warning = ':',
        },
        sourceName = 'markdown',
      },
      pkgbuild = {
        args = {'%file'},
        -- manual - vim-pkgbuild
        command = home ..
          '/.local/share/nvim/plugged/vim-pkgbuild/scripts/shellcheck_pkgbuild.sh',
        formatPattern = {
          '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
          {
            column = 2,
            line = 1,
            message = 4,
            security = 3,
          },
        },
        securities = {
          error = 'error',
          note = 'info',
          warning = 'warning',
        },
        sourceName = 'pkgbuild',
      },
      shellcheck = {
        args = {'--format=gcc', '-x', '-'},
        -- package-manager - shellcheck
        command = 'shellcheck',
        debounce = 100,
        formatLines = 1,
        formatPattern = {
          '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
          {
            column = 2,
            endColumn = 2,
            endLine = 1,
            line = 1,
            message = 4,
            security = 3,
          },
        },
        offsetColumn = 0,
        offsetLine = 0,
        securities = {
          error = 'error',
          note = 'info',
          warning = 'warning',
        },
        sourceName = 'shellcheck',
      },
      shellcheck_zsh = {
        args = {'--shell=bash', '--format=gcc', '-x', '-'},
        -- package-manager - shellcheck
        command = 'shellcheck',
        debounce = 100,
        formatLines = 1,
        formatPattern = {
          '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
          {
            column = 2,
            endColumn = 2,
            endLine = 1,
            line = 1,
            message = 4,
            security = 3,
          },
        },
        offsetColumn = 0,
        offsetLine = 0,
        securities = {
          error = 'error',
          note = 'info',
          warning = 'warning',
        },
        sourceName = 'shellcheck_zsh',
      },
    },
  },
}

local extension_path = vim.fn.glob(
  '$HOME/.vscode-oss/extensions/vadimcn.vscode-lldb-*/')
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

require('rust-tools').setup({
  tools = {
    inlay_hints = {
      show_parameter_hints = false,
    },
  },
  server = {
    standalone = false,
    -- on_attach = on_attach,
  },
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path,
      liblldb_path),
  },
})

-- require('symbols-outline').setup({
--   highlight_hover_item = true,
--   show_guides = true,
-- })
