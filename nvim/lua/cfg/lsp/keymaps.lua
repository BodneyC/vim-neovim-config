local util = require('utl.util')
local km = require('utl.mapper')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      print('No such client for bufnr: ' .. bufnr)
      return
    end
    -----@diagnostic disable-next-line need-check-nil
    --if client.server_capabilities.completionProvider then
    --  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    --  -- vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    --end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'
    end

    -- -- nightly has inbuilt completions, this can replace all completion plugins
    -- if client:supports_method('textDocument/completion', bufnr) then
    --   -- Enable auto-completion
    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end

    --- Disable semantic tokens
    ---@diagnostic disable-next-line need-check-nil
    client.server_capabilities.semanticTokensProvider = nil

    local map = km({ buffer = bufnr, noremap = true, silent = true })

    if client.server_capabilities.documentHighlightProvider then
      local group = 'lsp_document_highlight'
      vim.api.nvim_create_augroup(group, { clear = true })
      -- vim.api.nvim_create_autocmd('CursorHold', {
      --   callback = vim.lsp.buf.document_highlight,
      --   buffer = vim.api.nvim_get_current_buf(),
      --   group = group,
      -- })
      vim.api.nvim_create_autocmd('CursorMoved', {
        callback = vim.lsp.buf.clear_references,
        buffer = vim.api.nvim_get_current_buf(),
        group = group,
      })
    end

    ---@diagnostic disable-next-line: deprecated
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    map('n', 'K', vim.lsp.buf.hover, 'Show documentation')

    -- Bit of a hack considering all the other nonsense that's gone into setting
    --  this bitch up for Helm
    if client.config.name ~= 'helm_ls' then
      map('n', '<C-]>', vim.lsp.buf.definition, 'Go to definition')
    end

    map('n', 'gD', vim.lsp.buf.implementation, 'Implementation')
    map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
    map('n', '1gD', vim.lsp.buf.type_definition, 'Type definition')

    if client.server_capabilities.documentFormattingProvider then
      map('n', '<leader>F', function()
        if client.name == 'gopls' then
          util.safe_require('cfg.lsp.langs.gopls').format()
        else
          vim.lsp.buf.format({ async = true })
        end
      end)
    end

    -- \ls
    -- map('n', [[\s]], vim.lsp.buf.document_symbol, 'Document symbol')
    map('n', [[\q]], vim.lsp.buf.workspace_symbol, 'Workspace symbol')

    -- map('n', [[\f]], '<CMD>Lspsaga finder<CR>', 'Lsp finder')
    -- map('n', [[\a]], vim.lsp.buf.code_action, 'Code action')
    -- map('n', [[\d]], '<CMD>Lspsaga hover_doc<CR>', 'Hover doc')
    map('n', [[\D]], '<CMD>Lspsaga peek_definition<CR>', 'Preview definition')
    map('n', '<Leader>R', '<CMD>lua vim.lsp.buf.rename()<CR>', 'Rename')

    map('n', '[w', function() vim.diagnostic.jump({ count = -1 }) end, 'Prev warning')
    map('n', ']w', function() vim.diagnostic.jump({ count = 1 }) end, 'Next warning')
    map('n', '[W', function()
      vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
    end, 'Prev diagnostic')
    map('n', ']W', function()
      vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
    end, 'Next diagnostic')

    -- km.which_key.register({ ['<leader>w'] = { name = 'Workspace' } },
    -- { mode = 'n', buffer = bufnr })
    -- map('n', [[\wa]], vim.lsp.buf.add_workspace_folder, 'Add folder')
    -- map('n', [[\wr]], vim.lsp.buf.remove_workspace_folder, 'Remove folder')
    -- map('n', [[\wl]], function()
    -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, 'List folders')
    map('n', '<Leader>dq', vim.diagnostic.setloclist, 'Set LocList')
    map('n', '<Leader>dv', function()
      vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
    end, 'Toggle diagnostic virtual_lines')
    -- stylua: ignore end
  end
})
