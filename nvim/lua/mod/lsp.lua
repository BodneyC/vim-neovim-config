local lspconfig = require('lspconfig')

local home = vim.loop.os_homedir()

local function make_capabilities()
  -- local overrides = {
  --   textDocument = {
  --     completion = {
  --       completionItem = {
  --         snippetSupport = true,
  --         preselectSupport = true,
  --         insertReplaceSupport = true,
  --         labelDetailsSupport = true,
  --         deprecatedSupport = true,
  --         commitCharactersSupport = true,
  --         tagSupport = {
  --           valueSet = {1},
  --         },
  --         resolveSupport = {
  --           properties = {'documentation', 'detail', 'additionalTextEdits'},
  --         },
  --       },
  --     },
  --   },
  -- }
  return require('cmp_nvim_lsp').default_capabilities(overrides)
end

local capabilities = make_capabilities()

local function on_attach(_, bufnr)
  if vim.bo[bufnr].buftype ~= '' or vim.bo[bufnr].filetype == 'helm' then
    vim.diagnostic.disable()
  end
  -- NOTE: Awaiting https://github.com/nvim-lua/lsp-status.nvim/pull/78
  -- lsp_status.on_attach(client)
end

local custom_setups = {

  --[[
  mkdir -p "$HOME/software" && cd "$HOME/software"
  gcl https://github.com/sumneko/lua-language-server.git
  cd lua-language-server
  git submodule update --init --recursive
  cd 3rd/luamake && compile/install.sh
  cd -
  ./3rd/luamake/luamake rebuild
  --]]
  sumneko_lua = function()
    local system_name
    if vim.fn.has('mac') == 1 then
      system_name = 'macOS'
    elseif vim.fn.has('unix') == 1 then
      system_name = 'Linux'
    end

    local sumneko_root_path = vim.fn.expand('$HOME') ..
                                '/software/lua-language-server'
    local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name ..
                             '/lua-language-server'

    local path = vim.split(package.path, ';')
    table.insert(path, 'lua/?.lua')
    table.insert(path, 'lua/?/init.lua')

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
  end,

  --[[
  go get github.com/arduino/arduino-language-server
  package-manager arduino-cli
  arduino-cli core install arduino:avr # or other platform
  ]]
  arduino_language_server = function()
    lspconfig.arduino_language_server.setup {
      cmd = {
        'arduino-language-server',
        '-cli-config=' .. home .. '/.arduino15/arduino-cli.yaml',
        '-log',
        '-logpath=' .. home .. '/.arduino15/lsp-logs',
      },
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,

  --[[
  mkdir -p "$HOME/software" && cd "$HOME/software"
  gcl https://github.com/prominic/groovy-language-server
  cd groovy-language-server
  ./gradlew build
  ]]
  groovyls = function()
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
            home ..
              '/.m2/repository/org/spockframework/spock-core/1.1-groovy-2.4',
          },
        },
      },
    }
  end,

  --[[
  mkdir -p "$HOME/software" && cd "$HOME/software"
  gcl https://github.com/fwcd/kotlin-language-server.git
  cd kotlin-language-server
  ./gradlew :server:installDist
  ]]
  kotlin_language_server = function()
    lspconfig.kotlin_language_server.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {
        home ..
          '/software/kotlin-language-server/server/build/install/server/bin/kotlin-language-server',
      },
    }
  end,

  -- npm i -g diagnostic-languageserver
  diagnosticls = function()
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
  end,

  rust_analyzer = function()
    local extension_path = vim.fn.glob(
      '$HOME/.vscode-oss/extensions/vadimcn.vscode-lldb-*/')
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

    require('rust-tools').setup({
      tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
          show_parameter_hints = true,
        },
      },
      server = {
        standalone = false,
        -- on_attach = on_attach,
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
  end,

}

local function generate_lsp_map()
  local map = {
    diagnosticls = {
      filetypes = {
        'pkgbuild',
        'terraform',
        'shellcheck_zsh',
        'shellcheck',
        'markdown',
      },
      setup = custom_setups.diagnosticls,
    },
    rust_analyzer = {
      filetypes = lspconfig['rls'].document_config.default_config.filetypes,
      setup = custom_setups.rust_analyzer,
    },
    jdtls = {
      filetypes = lspconfig['jdtls'].document_config.default_config.filetypes,
      setup = require('mod.jdtls').init,
    },
  }

  for _, lsp in ipairs({
    'sumneko_lua',
    'arduino_language_server',
    'groovyls',
    'kotlin_language_server',
  }) do
    local config = lspconfig[lsp]
    if not config then
      print('No config for [' .. lsp .. ']')
    else
      map[lsp] = {
        filetypes = config.document_config.default_config.filetypes,
        setup = custom_setups[lsp],
      }
    end
  end

  for _, lsp in ipairs({
    'tsserver', -- npm i -g typescript-language-server
    'dockerls', -- npm i -g dockerfile-language-server-nodejs
    -- Tree-sitter required
    --  npm i -g bash-language-server
    --  package-manager shellcheck
    'bashls',
    'clangd', -- package-manager - clang
    'clojure_lsp', -- manual - https://github.com/snoe/clojure-lsp
    'gopls', -- go get golang.org/x/tools/gopls@latest
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
    local config = lspconfig[lsp]
    if not config then
      print('No config for [' .. lsp .. ']')
    else
      map[lsp] = {
        filetypes = config.document_config.default_config.filetypes,
        setup = function()
          lspconfig[lsp].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
      }
    end
  end

  return map
end

local lsp_map = generate_lsp_map()

local function find_lsp_for(ft)
  for lsp, details in pairs(lsp_map) do
    for _, _ft in ipairs(details.filetypes) do
      if _ft == ft then
        return lsp
      end
    end
  end
  return nil
end

local M = {}

-- Preloading this one is essentially an ft-ignore
local fts_loaded = {
  NvimTree = true,
  Outline = true,
  TelescopePrompt = true,
  TelescopeResults = true,
}
local lsps_loaded = {}

local function set_keymaps()

  local sb = {
    silent = true,
    buffer = true,
  }

  vim.keymap.set('n', 'K', require('mod.lsp').show_documentation, sb)
  vim.keymap.set('n', '<C-]>', require('mod.lsp').go_to_definition, sb)

  vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, sb)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, sb)
  vim.keymap.set('n', '1gD', vim.lsp.buf.type_definition, sb)
  vim.keymap.set('n', ']w', require('mod.diagnostics').navigate('next'), sb)
  vim.keymap.set('n', '[w', require('mod.diagnostics').navigate('prev'), sb)
  vim.keymap.set('n', '<Leader>F', require('mod.lsp').document_formatting, sb)
  vim.keymap.set('n', '<Leader>R', '<CMD>Lspsaga rename<CR>', sb)

  vim.keymap.set('n', [[\h]], vim.lsp.buf.hover, sb)
  vim.keymap.set('n', [[\s]], vim.lsp.buf.document_symbol, sb)
  vim.keymap.set('n', [[\q]], vim.lsp.buf.workspace_symbol, sb)
  vim.keymap.set('n', [[\f]], '<CMD>Lspsaga lsp_finder<CR>', sb)
  vim.keymap.set('n', [[\a]], function()
    local ok = pcall(require'lspsaga.command'.load_command, 'code_action')
    if not ok then
      vim.lsp.buf.code_action()
    end
  end, sb)
  vim.keymap.set('n', [[\d]], '<CMD>Lspsaga hover_doc<CR>', sb)
  vim.keymap.set('n', [[\D]], '<CMD>Lspsaga preview_definition<CR>', sb)
  vim.keymap.set('n', [[\r]], '<CMD>Lspsaga rename<CR>', sb)
end

function M.filetype(ft)
  if vim.bo.buftype ~= '' then
    return
  end
  if fts_loaded[ft] then
    set_keymaps()
    return
  end
  fts_loaded[ft] = true
  local lsp = find_lsp_for(ft)
  if not lsp then
    return
  end
  if lsps_loaded[lsp] then
    set_keymaps()
    return
  end
  lsps_loaded[lsp] = true
  lsp_map[lsp].setup()
  if #vim.lsp.buf_get_clients() == 0 then
    lspconfig[lsp].manager.try_add()
  end
  set_keymaps()
end

function M.document_formatting()
  local clients = vim.lsp.buf_get_clients()
  if #clients > 0 then
    for _, o in pairs(clients) do
      if o.server_capabilities.documentFormattingProvider then
        vim.lsp.buf.format()
        return
      end
    end
  end
  vim.cmd('w')
  vim.cmd('FormatWrite')
end

function M.show_documentation()
  if #vim.lsp.buf_get_clients() ~= 0 then
    vim.lsp.buf.hover()
  else
    if vim.bo.ft == 'vim' then
      vim.cmd('H ' .. vim.fn.expand('<cword>'))
    elseif string.match(vim.bo.ft, 'z?sh') then
      vim.cmd('M ' .. vim.fn.expand('<cword>'))
    else
      print('No hover candidate found')
    end
  end
end

function M.go_to_definition()
  if #vim.lsp.buf_get_clients() ~= 0 then
    vim.lsp.buf.definition()
  else
    for _, wrd in ipairs({'<cword>', '<cWORD>', '<cexpr>'}) do
      local word = vim.fn.expand(wrd)
      if #(vim.fn.taglist('^' .. word .. '$')) then
        vim.cmd('tag ' .. word)
        return
      end
    end
    vim.cmd('redraw')
    print('No definition found')
  end
end

return M
