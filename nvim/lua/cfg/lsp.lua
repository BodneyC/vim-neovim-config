local vim = vim
local skm = vim.api.nvim_set_keymap
local util = require'utl.util'

local nvim_lsp = require'nvim_lsp'
local diagnostic = require'diagnostic'
local lsp_status = require'lsp-status'

-- Options for LSP
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'

vim.g.completion_auto_change_source = 1
vim.g.completion_confirm_key = '\\<C-y>'
vim.g.completion_enable_auto_paren = 1
vim.g.completion_enable_auto_signature = 1
vim.g.completion_enable_snippet = 'vim-vsnip'
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' } -- Order is important here
vim.g.completion_sorting = 'none'
vim.g.completion_tabnine_max_num_results=3
vim.g.completion_trigger_keyword_length = 3
vim.g.completion_chain_complete_list = {
  default = {
    { complete_items = { 'lsp', 'path', 'snippet', 'buffers' } },
    -- { complete_items = { 'ts', 'tabnine' } },
    { mode = '<C-p>' }, { mode = '<C-n>' }
  },
}

vim.g.diagnostic_auto_popup_while_jump = false
vim.g.diagnostic_enable_underline = 1
vim.g.diagnostic_enable_virtual_text = false
vim.g.diagnostic_virtual_text_prefix = ' '
vim.g.space_before_virtual_text = 2

util.augroup([[
  augroup __LSP__
    au!
    au BufEnter   * silent lua require'completion'.on_attach()
    au CursorHold * silent lua vim.lsp.util.show_line_diagnostics()
  augroup END
]])

-- LSP Mappings

skm('n', 'K',     "<cmd>lua require'utl.util'.show_documentation()<CR>", { noremap = true, silent = true })
skm('n', '<C-]>', "<cmd>lua require'utl.util'.go_to_definition()<CR>",   { noremap = true, silent = true })

skm('n', 'ga',       '<CMD>lua vim.lsp.buf.code_action()<CR>',      { noremap = true, silent = true })
skm('n', 'gd',       '<CMD>lua vim.lsp.buf.definition()<CR>',       { noremap = true, silent = true })
skm('n', 'gh',       '<CMD>lua vim.lsp.buf.hover()<CR>',            { noremap = true, silent = true })
skm('n', 'gD',       '<CMD>lua vim.lsp.buf.implementation()<CR>',   { noremap = true, silent = true })
skm('n', '<C-k>',    '<CMD>lua vim.lsp.buf.signature_help()<CR>',   { noremap = true, silent = true })
skm('n', '1gD',      '<CMD>lua vim.lsp.buf.type_definition()<CR>',  { noremap = true, silent = true })
skm('n', 'gr',       '<CMD>lua vim.lsp.buf.references()<CR>',       { noremap = true, silent = true })
skm('n', 'g0',       '<CMD>lua vim.lsp.buf.document_symbol()<CR>',  { noremap = true, silent = true })
skm('n', 'gW',       '<CMD>lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
skm('n', ']c',       '<CMD>NextDiagnosticCycle<CR>',                { noremap = true, silent = true })
skm('n', '[c',       '<CMD>PrevDiagnosticCycle<CR>',                { noremap = true, silent = true })
skm('n', '<Leader>F','<CMD>lua vim.lsp.buf.formatting()<CR>',       { noremap = true, silent = true })

-- Well, this is awful
local function tab_string(e, k)
  return [[ pumvisible() ? "\]] .. e .. [[" ]] ..
    [[ : (!(col('.') - 1) || getline('.')[col('.') - 2]  =~ '\s') ]] ..
    [[   ? "\]] .. k .. [[" : completion#trigger_completion() ]]
end
skm('i', '<Tab>',   tab_string("<C-n>", "<Tab>"), { noremap = true, silent = true, expr = true })
skm('i', '<S-Tab>', tab_string("<C-p>", "<C-d>"), { noremap = true, silent = true, expr = true })

skm('i', '<C-j>', "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'", { silent = true, expr = true })
skm('i', '<C-k>', "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'", { silent = true, expr = true })
skm('s', '<C-j>', "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'", { silent = true, expr = true })
skm('s', '<C-k>', "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'", { silent = true, expr = true })

require'utl.util'.command('LspStopAll', 'lua vim.lsp.stop_client(vim.lsp.get_active_clients())', {})
require'utl.util'.command('LspBufStopAll', 'lua vim.lsp.stop_client(vim.lsp.buf_get_clients())', {})

-- Diagnostics
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
nvim_lsp.clangd.setup      { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.jdtls.setup       { on_attach = on_attach, capabilities = lsp_status.capabilities }
-- nvim_lsp.bashls.setup      { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.pyls.setup        { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.rls.setup         { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.gopls.setup       { on_attach = on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.jsonls.setup      { on_attach = diagnostic.on_attach, capabilities = lsp_status.capabilities }
nvim_lsp.kotlin_language_server.setup { on_attach = on_attach, capabilities = lsp_status.capabilities }

local lombok_path = ''
nvim_lsp.jdtls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  init_options = {
    jvm_args = {
      '-noverify',
      '-Xmx1G',
      '-XX:+UseG1GC',
      '-XX:+UseStringDeduplication',
      lombok_path and '-javaagent:' .. lombok_path or '',
      lombok_path and '-Xbootclasspath/a:' .. lombok_path or '',
    }
  }
}

nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  filetypes = { 'groovy', 'pkgbuild', 'terraform', 'sh', 'zsh', 'markdown' },
  init_options = {
    filetypes = {
      pkgbuild = 'pkgbuild',
      terraform = 'terraform',
      zsh = 'shellcheck_zsh',
      sh = 'shellcheck',
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
      shellcheck = {
        args = { '--format=gcc', '-x', '-' },
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
        sourceName = 'shellcheck'
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
        },
        sourceName = 'groovy'
      }
    },
  }
}
