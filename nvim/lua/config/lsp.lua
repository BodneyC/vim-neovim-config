vim.lsp.semantic_tokens.enable(false)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('config_lsp_attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    local function bmap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    if client.name ~= 'helm_ls' then
      bmap('n', '<C-]>', vim.lsp.buf.definition, 'Go to definition')
    end
    bmap('n', 'gD', vim.lsp.buf.implementation, 'Implementation')
    bmap('n', '1gD', vim.lsp.buf.type_definition, 'Type definition')
    bmap('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
    bmap('n', '<leader>R', vim.lsp.buf.rename, 'Rename')
    bmap('n', '\\q', vim.lsp.buf.workspace_symbol, 'Workspace symbol')
    bmap('n', '\\D', '<Cmd>Lspsaga peek_definition<CR>', 'Preview definition')
  end,
})
