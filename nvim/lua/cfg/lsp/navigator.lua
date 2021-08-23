require'navigator'.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
  end,
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = false,
  },
  icons = {
    -- Code action
    code_action_icon = ' ',
    -- code lens
    code_lens_action_icon = ' ',
    -- Diagnostics
    diagnostic_head = '🐛',
    diagnostic_head_severity_1 = '🈲',
    diagnostic_head_severity_2 = '☣️',
    diagnostic_head_severity_3 = '👎',
    diagnostic_head_description = '📛',
    diagnostic_virtual_text = '🦊',
    diagnostic_file = '🚑',
    -- Values
    value_changed = '📝',
    value_definition = '🦕',
    -- Treesitter
    match_kinds = {
      var = ' ', -- "👹", -- Vampaire
      method = 'ƒ ', --  "🍔", -- mac
      ['function'] = ' ', -- "🤣", -- Fun
      parameter = '  ', -- Pi
      associated = '🤝',
      namespace = '🚀',
      type = ' ',
      field = '🏈',
    },
    treesitter_defult = '🌲',
  },
  keymaps = {
    {key = '\\r', func = 'references()'},
    {mode = 'i', key = '<M-k>', func = 'signature_help()'},
    {key = '\\s', func = 'signature_help()'},
    {key = '\\0', func = 'document_symbol()'},
    {key = '\\W', func = 'workspace_symbol()'},
    {key = '<C-]>', func = 'definition()'},
    {key = '\\D', func = [[declaration({ border = 'single' })]]},
    {
      key = '\\p',
      func = [[require('navigator.definition').definition_preview()]],
    }, {key = '\\T', func = [[require([[navigator.treesitter').buf_ts()]]},
    {key = '<Leader>\\T', func = [[require([[navigator.treesitter').bufs_ts()]]},
    {key = 'K', func = 'hover({ popup_opts = { border = single }})'},
    {key = '<Space>ca', mode = 'n', func = 'code_action()'},
    {key = '<Space>cA', mode = 'v', func = 'range_code_action()'},
    {key = '\\R', func = 'rename()'},
    {key = '<Space>R', func = [[require('navigator.rename').rename()]]},
    -- {key = '<Leader>gi', func = 'incoming_calls()'},
    -- {key = '<Leader>go', func = 'outgoing_calls()'},
    {key = '\\i', func = 'implementation()'},
    {key = '<Space>D', func = 'type_definition()'}, {
      key = '\\L',
      func = [[diagnostic.show_line_diagnostics( { border = 'single' })]],
    },
    {key = 'gG', func = [[require('navigator.diagnostics').show_diagnostic()]]},
    {key = ']w', func = [[diagnostic.goto_next({ border = 'single' })]]},
    {key = '[w', func = [[diagnostic.goto_prev({ border = 'single' })]]},
    {key = ']r', func = [[require('navigator.treesitter').goto_next_usage()]]},
    {
      key = '[r',
      func = [[require('navigator.treesitter').goto_previous_usage()]],
    }, {key = '<C-LeftMouse>', func = 'definition()'},
    {key = 'g<LeftMouse>', func = 'implementation()'},
    {
      key = '<Leader>k',
      func = [[require('navigator.dochighlight').hi_symbol()]],
    }, {key = '\\wa', func = 'vim.lsp.buf.add_workspace_folder()'},
    {key = '\\wr', func = 'vim.lsp.buf.remove_workspace_folder()'}, {
      key = '\\wl',
      func = 'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))',
    }, {
      key = '<Space>la',
      mode = 'n',
      func = [[require('navigator.codelens').run_action()]],
    }, {
      mode = 'n',
      key = '<Leader>F',
      func = [[require'utl.util'.document_formatting()]],
    },
  },
}
