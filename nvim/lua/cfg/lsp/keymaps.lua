local M = {}

local km = require 'utl.keymapper'

function M.set_keymaps(client, bufnr)
  local bkm = km.buf_keymapper(bufnr)

  if client.server_capabilities.documentHighlightProvider then
    local group = 'lsp_document_highlight'
    vim.api.nvim_create_augroup(group, { clear = true })
    vim.api.nvim_create_autocmd('CursorHold', {
      callback = vim.lsp.buf.document_highlight,
      buffer = vim.api.nvim_get_current_buf(),
      group = group,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = vim.lsp.buf.clear_references,
      buffer = vim.api.nvim_get_current_buf(),
      group = group,
    })
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  bkm.map('n', 'K', vim.lsp.buf.hover, 'Show documentation')
  bkm.map('n', '<C-]>', vim.lsp.buf.definition, 'Go to definition')

  bkm.map('n', 'gD', vim.lsp.buf.implementation, 'Implementation')
  bkm.map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
  bkm.map('n', '1gD', vim.lsp.buf.type_definition, 'Type definition')

  bkm.map("n", "[w", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  bkm.map("n", "]w", "<cmd>Lspsaga diagnostic_jump_next<CR>")

  bkm.map("n", "[W", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end)
  bkm.map("n", "]W", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end)

  if client.server_capabilities.documentFormattingProvider then
    bkm.map('n', '<space>F', function() vim.lsp.buf.format({ async = true }) end)
  end

  bkm.map('n', '<Leader>R', '<CMD>Lspsaga rename<CR>', 'Rename')

  bkm.map('n', [[\h]], vim.lsp.buf.hover, 'Hover')
  bkm.map('n', [[\s]], vim.lsp.buf.document_symbol, 'Document symbol')
  bkm.map('n', [[\q]], vim.lsp.buf.workspace_symbol, 'Workspace symbol')
  bkm.map('n', [[\f]], '<CMD>Lspsaga lsp_finder<CR>', 'Lsp finder')
  bkm.map('n', [[\a]], function()
    -- local ok = pcall(require 'lspsaga.command'.load_command, 'code_action')
    -- if not ok then
    vim.lsp.buf.code_action()
    -- end
  end, 'Code action')
  bkm.map('n', [[\d]], '<CMD>Lspsaga hover_doc<CR>', 'Hover doc')
  bkm.map('n', [[\D]], '<CMD>Lspsaga preview_definition<CR>',
    'Preview definition')
  bkm.map('n', [[\r]], '<CMD>Lspsaga rename<CR>', 'Rename')

  -- km.which_key.register({ ['<leader>w'] = { name = 'Workspace' } },
  -- { mode = 'n', buffer = bufnr })
  bkm.map('n', [[\wa]], vim.lsp.buf.add_workspace_folder, 'Add folder')
  bkm.map('n', [[\wr]], vim.lsp.buf.remove_workspace_folder,
    'Remove folder')
  bkm.map('n', [[\wl]], function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List folders')
end

return M
