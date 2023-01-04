local on_attach = require 'cfg.lsp.langs.default'.on_attach
return function() require('typescript').setup { server = { on_attach = on_attach } } end
