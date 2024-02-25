local lsp = require('lsp-zero')
require('typescript').setup({ server = lsp.build_options('tsserver', {}) })
