local null_ls = require 'null-ls'
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
null_ls.setup {
  debug = true,
  sources = {
    formatting.stylua.with {
      extra_args = {
        '--quote-style',
        'ForceSingle',
        '--indent-width',
        '4',
        '--column-width',
        '80',
       },
     },
    formatting.black,
    formatting.prettier,
    -- diagnostics.eslint,
    diagnostics.flake8,
    -- null_ls.builtins.completion.spell,
   },
  on_init = function(new_client, _) new_client.offset_encoding = 'utf-32' end,
 }
