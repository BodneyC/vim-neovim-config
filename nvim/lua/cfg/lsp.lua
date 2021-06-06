local vim = vim
local skm = vim.api.nvim_set_keymap
local util = require 'utl.util'

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local lsp_status = require 'lsp-status'

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = false,
      virtual_text = false, -- {space = 2, prefix = ' '},
      signs = true,
      update_in_insert = false,
    })
vim.g.diagnostic_auto_popup_while_jump = false

util.augroup({
  name = '__LSP__',
  autocmds = {{event = 'FileType', glob = 'java', cmd = [[lua require'mod.jdtls'.init()]]}},
})

-- LSP Mappings

local n_s = {noremap = true, silent = true}
local s_e = {silent = true, expr = true}

skm('n', 'K', '<CMD>lua require\'utl.util\'.show_documentation()<CR>', n_s)
skm('n', '<C-]>', '<CMD>lua require\'utl.util\'.go_to_definition()<CR>', n_s)

skm('n', 'gD', '<CMD>lua vim.lsp.buf.implementation()<CR>', n_s)
skm('n', '<C-k>', '<CMD>lua vim.lsp.buf.signature_help()<CR>', n_s)
skm('n', '1gD', '<CMD>lua vim.lsp.buf.type_definition()<CR>', n_s)
skm('n', ']w', [[<cmd>lua require'mod.tmp-diagnostics'.lsp_jump_diagnostic_next()<CR>]], n_s)
skm('n', '[w', [[<cmd>lua require'mod.tmp-diagnostics'.lsp_jump_diagnostic_prev()<CR>]], n_s)
skm('n', '<Leader>F', '<CMD>lua require\'utl.util\'.document_formatting()<CR>', n_s)

local lsp_leader = [[<leader>l]]

skm('n', lsp_leader .. 'h', '<CMD>lua vim.lsp.buf.hover()<CR>', n_s)
skm('n', lsp_leader .. 's', '<CMD>lua vim.lsp.buf.document_symbol()<CR>', n_s)
skm('n', lsp_leader .. 'q', '<CMD>lua vim.lsp.buf.workspace_symbol()<CR>', n_s)
skm('n', lsp_leader .. 'f', [[<cmd>Lspsaga lsp_finder<CR>]], n_s)
skm('n', lsp_leader .. 'a', [[<cmd>Lspsaga code_action<CR>]], n_s)
skm('n', lsp_leader .. 'd', [[<cmd>Lspsaga hover_doc<CR>]], n_s)
skm('n', lsp_leader .. 'D', [[<cmd>Lspsaga preview_definition<CR>]], n_s)
skm('n', '<Leader>R', '<CMD>Lspsaga rename<CR>', n_s)

skm('i', '<C-j>', [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>']], s_e)
skm('i', '<C-k>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>']], s_e)
skm('s', '<C-j>', [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>']], s_e)
skm('s', '<C-k>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>']], s_e)

util.command('LspStopAll', 'lua vim.lsp.stop_client(vim.lsp.get_active_clients())', {})
util.command('LspBufStopAll', 'lua vim.lsp.stop_client(vim.lsp.buf_get_clients())', {})

-- Diagnostics
vim.fn.sign_define('LspDiagnosticsSignError', {text = ' ', texthl = 'LspDiagnosticsError'})
vim.fn.sign_define('LspDiagnosticsSignWarning', {text = ' ', texthl = 'LspDiagnosticsWarning'})
vim.fn.sign_define('LspDiagnosticsSignInformation',
    {text = ' ', texthl = 'LspDiagnosticsInformation'})
vim.fn.sign_define('LspDiagnosticsSignHint', {text = 'ﯦ ', texthl = 'LspDiagnosticsHint'})

lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '',
  indicator_hint = 'ﯦ',
  indicator_ok = '',
})

local function on_attach(client, bufnr)
  lsp_status.on_attach(client, bufnr)
end

-- npm i -g typescript-language-server
lspconfig.tsserver.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- npm i -g dockerfile-language-server-nodejs
lspconfig.dockerls.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- npm i -g bash-language-server
lspconfig.bashls.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- package-manager - clang
lspconfig.clangd.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- manual - https://github.com/snoe/clojure-lsp
lspconfig.clojure_lsp.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- go get golang.org/x/tools/gopls@latest
lspconfig.gopls.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- npm i -g vscode-html-languageserver-bin
lspconfig.html.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- npm i -g vscode-json-languageserver
lspconfig.jsonls.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- npm i -g vim-language-server
lspconfig.vimls.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- npm i -g yaml-language-server
lspconfig.yamlls.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- rustup component add rls rust-{analysis,src}
lspconfig.rls.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- pip3 i --user 'python-language-sever[all]'
lspconfig.pyls.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

--[[
mkdir -p "$HOME/software" && cd "$HOME/software"
gcl https://github.com/sumneko/lua-language-server.git
cd lua-language-server
git submodule update --init --recursive
cd 3rd/luamake && compile/install.sh
cd -
./3rd/luamake/luamake rebuild
--]]
local lua_ls_root_dir = vim.fn.expand('$HOME') .. '/software/lua-language-server'
lspconfig.sumneko_lua.setup {
  cmd = {
    lua_ls_root_dir .. '/bin/' .. (util.basic_os_info() == 'Darwin' and 'macOS' or 'Linux') ..
        '/lua-language-server', '-E', lua_ls_root_dir .. '/main.lua',
  },
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
      diagnostics = {globals = {'vim'}},
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

--[[
go get github.com/arduino/arduino-language-server
package-manager arduino-cli
arduino-cli core install arduino:avr # or other platform
]]
if not lspconfig.arduino_lsp then
  configs.arduino_lsp = {
    default_config = {
      cmd = {
        'arduino-language-server',
        '-cli-config=' .. os.getenv('HOME') .. '/.arduino15/arduino-cli.yaml', '-log',
        '-logpath=' .. os.getenv('HOME') .. '/.arduino15/lsp-logs',
      },
      filetypes = {'arduino'},
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end,
      settings = {},
    },
  }
end
lspconfig.arduino_lsp.setup {on_attach = on_attach, capabilities = lsp_status.capabilities}

--[[
mkdir -p "$HOME/software" && cd "$HOME/software"
gcl https://github.com/prominic/groovy-language-server
cd groovy-language-server
./gradlew build
]]
lspconfig.groovyls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  cmd = {
    'java', '-jar',
    os.getenv('HOME') ..
        '/software/groovy-language-server/build/libs/groovy-language-server-all.jar',
  },
  filetypes = {'groovy'},
  root_dir = require'lspconfig.util'.root_pattern('.git') or vim.loop.os_homedir(),
  settings = {
    groovy = {
      classpath = {
        os.getenv('HOME') .. '/.m2/repository/org/spockframework/spock-core/1.1-groovy-2.4',
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
  capabilities = lsp_status.capabilities,
  cmd = {
    os.getenv('HOME') ..
        '/software/kotlin-language-server/server/build/install/server/bin/kotlin-language-server',
  },
}

-- npm i -g diagnostic-languageserver
lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  filetypes = {'pkgbuild', 'terraform', 'sh', 'zsh', 'markdown'},
  init_options = {
    filetypes = {
      pkgbuild = 'pkgbuild',
      terraform = 'terraform',
      zsh = 'shellcheck_zsh',
      sh = 'shellcheck',
      markdown = 'markdown',
    },
    formatFiletypes = {sh = 'shfmt', zsh = 'shfmt'},
    -- package-manager - shfmt
    formatters = {shfmt = {args = {'-i=2', '-bn', '-ci', '-sr'}, command = 'shfmt'}},
    linters = {
      markdown = {
        -- npm i -g markdownlint
        command = 'markdownlint',
        args = {'--stdin'},
        isStderr = true,
        isStdout = false,
        formatPattern = {
          -- README.md:3:81 MD013/line-length Line length [Expected: 80; Actual: 282]
          '^[^:]+(:)(\\d+):?(\\d*)\\s+(.*)$', {security = 1, line = 2, column = 3, message = 4},
        },
        offsetColumn = 0,
        offsetLine = 0,
        securities = {error = 'error', note = 'info', warning = ':'},
        sourceName = 'markdown',
      },
      pkgbuild = {
        args = {'%file'},
        -- manual - vim-pkgbuild
        command = os.getenv('HOME') ..
            '/.local/share/nvim/plugged/vim-pkgbuild/scripts/shellcheck_pkgbuild.sh',
        formatPattern = {
          '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
          {column = 2, line = 1, message = 4, security = 3},
        },
        securities = {error = 'error', note = 'info', warning = 'warning'},
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
          {column = 2, endColumn = 2, endLine = 1, line = 1, message = 4, security = 3},
        },
        offsetColumn = 0,
        offsetLine = 0,
        securities = {error = 'error', note = 'info', warning = 'warning'},
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
          {column = 2, endColumn = 2, endLine = 1, line = 1, message = 4, security = 3},
        },
        offsetColumn = 0,
        offsetLine = 0,
        securities = {error = 'error', note = 'info', warning = 'warning'},
        sourceName = 'shellcheck_zsh',
      },
    },
  },
}

require('symbols-outline').setup({highlight_hover_item = true, show_guides = true})

require'lspkind'.init({
  with_text = false,
  symbol_map = {
    Text = '',
    Method = 'ƒ',
    Function = 'f',
    Constructor = '',
    Variable = '',
    Class = '',
    Interface = 'ﰮ',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '了',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
  },
})
