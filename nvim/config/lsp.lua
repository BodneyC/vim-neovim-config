local vim = vim
local nvim_lsp = require('nvim_lsp')
local diagnostic = require('diagnostic')
local lsp_status = require('lsp-status')

vim.fn.sign_define('LspDiagnosticsErrorSign',       { text = ' ', texthl = 'LspDiagnosticsError' })
vim.fn.sign_define('LspDiagnosticsWarningSign',     { text = ' ', texthl = 'LspDiagnosticsWarning' })
vim.fn.sign_define('LspDiagnosticsInformationSign', { text = ' ', texthl = 'LspDiagnosticsInformation' })
vim.fn.sign_define('LspDiagnosticsHintSign',        { text = 'ﯦ ', texthl = 'LspDiagnosticsHint' })

lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '',
  indicator_hint = 'ﯦ',
  indicator_ok = '',
})

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  diagnostic.on_attach(client, bufnr)
end

--- LSPs
nvim_lsp.dockerls.setup    { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.html.setup        { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.sumneko_lua.setup { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.tsserver.setup    { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.vimls.setup       { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.yamlls.setup      { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.jsonls.setup      { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.bashls.setup      { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.pyls.setup        { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.rls.setup         { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.gopls.setup       { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.kotlin_language_server.setup { on_attach = on_attach, capabilities = lsp_status.capabilities }

local lombok_path = ''
nvim_lsp.jdtls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  init_options = {
    jvm_args = {
      "-noverify",
      "-Xmx1G",
      "-XX:+UseG1GC",
      "-XX:+UseStringDeduplication",
      "-javaagent:" .. lombok_path,
      "-Xbootclasspath/a:" .. lombok_path,
    }
  }
}

nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  filetypes = { 'groovy', 'pkgbuild', 'terraform', 'zsh', 'markdown' },
  init_options = {
    filetypes = {
      pkgbuild = 'pkgbuild',
      terraform = 'terraform',
      zsh = 'shellcheck_zsh',
      groovy = 'groovy',
      markdown = 'markdown',
    },
    formatFiletypes = {
      sh = 'shfmt',
      zsh = 'shfmt'
    },
    formatters = {
      shfmt = {
        args = { '-i', 0, '-bn', '-ci', '-sr', '-kp' },
        command = 'shfmt'
      }
    },
    linters = {
      markdown = {
        command = 'markdownlint',
        args = { '--stdin' },
        isStderr = true,
        isStdout = false,
        formatPattern = {
          -- README.md:3:81 MD013/line-length Line length [Expected: 80; Actual: 282]
          '^[^:]+(:)(\\d+):?(\\d*)\\s+(.*)$',
          { security = 1, line = 2, column = 3, message = 4 }
        },
        offsetColumn = 0,
        offsetLine = 0,
        securities = { error = 'error', note = 'info', warning = ':' },
        sourceName = 'markdown',
      },
      pkgbuild  = {
        args  = { '%file' },
        command = '/home-link/.local/share/nvim/plugged/vim-pkgbuild/scripts/shellcheck_pkgbuild.sh',
        formatPattern = {
          '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
          { column = 2, line = 1, message = 4, security = 3 }
        },
        securities = { error = 'error', note = 'info', warning = 'warning' },
        sourceName = 'pkgbuild'
      },
      shellcheck_zsh = {
        args = { '--shell=bash', '--format=gcc', '-x', '-' },
        command = 'shellcheck',
        debounce = 100,
        formatLines = 1,
        formatPattern = {
          '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
          { column = 2, endColumn = 2, endLine = 1, line = 1, message = 4, security = 3 }
        },
        offsetColumn = 0,
        offsetLine = 0,
        securities = { error = 'error', note = 'info', warning = 'warning' },
        sourceName = 'shellcheck_zsh'
      },
      groovy = {
        args = { '-jar', '/link-home/gitclones/groovy-language-server/build/libs/groovy-language-server.jar' },
        command = 'java',
        filetypes = { 'groovy' },
        settings = {
          groovy = {
            classpath = { '/link-home/.m2/repository/org/spockframework/spock-core/1.1-groovy-2.4' }
          }
        }
      }
    },
  }
}
