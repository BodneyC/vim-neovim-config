local util = require('utl.util')

util.safe_require('cfg.lsp.diagnostics')
util.safe_require('cfg.lsp.cmp')
util.safe_require('cfg.lsp.lsp')
util.safe_require('cfg.lsp.ts')
util.safe_require('cfg.lsp.formatter')

local s = require('utl.maps').flags.s

vim.keymap.set('n', 'K', require('utl.util').show_documentation, s)
vim.keymap.set('n', '<C-]>', require('utl.util').go_to_definition, s)

vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, s)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, s)
vim.keymap.set('n', '1gD', vim.lsp.buf.type_definition, s)
vim.keymap.set('n', ']w', require('mod.diagnostics').navigate('next'), s)
vim.keymap.set('n', '[w', require('mod.diagnostics').navigate('prev'), s)
vim.keymap.set('n', '<Leader>F', require('utl.util').document_formatting, s)
vim.keymap.set('n', '<Leader>R', '<CMD>Lspsaga rename<CR>', s)

vim.keymap.set('n', [[\h]], vim.lsp.buf.hover, s)
vim.keymap.set('n', [[\s]], vim.lsp.buf.document_symbol, s)
vim.keymap.set('n', [[\q]], vim.lsp.buf.workspace_symbol, s)
vim.keymap.set('n', [[\f]], '<CMD>Lspsaga lsp_finder<CR>', s)
vim.keymap.set('n', [[\a]], function()
  local ok = pcall(require'lspsaga.command'.load_command, 'code_action')
  if not ok then
    vim.lsp.buf.code_action()
  end
end, s)
vim.keymap.set('n', [[\d]], '<CMD>Lspsaga hover_doc<CR>', s)
vim.keymap.set('n', [[\D]], '<CMD>Lspsaga preview_definition<CR>', s)
vim.keymap.set('n', [[\r]], '<CMD>Lspsaga rename<CR>', s)

