-- local ts_utils = require 'nvim-treesitter.ts_utils'
require'nvim-treesitter.configs'.setup {
  context_commentstring = {enable = true, config = {css = '// %s', c = '// %s'}},
  autotag = {
    enable = true,
    filetypes = {
      'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte',
      'vue', 'xml', 'kotlin',
    },
  },
  ensure_installed = {
    'c', 'java', 'python', 'lua', 'go', 'yaml', 'json', 'clojure', 'html',
    'typescript', 'query', 'cpp', 'ruby', 'toml', 'bash', 'css', 'javascript',
    'tsx',
  },
  indent = {enable = true, disable = {'yaml', 'python'}},
  highlight = {enable = true, disable = {'yaml'}},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
  },
  refactor = {
    smart_rename = {enable = false, keymaps = {smart_rename = '<Leader>R'}},
    highlight_current_scope = {enable = false},
    highlight_definitions = {enable = false},
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = 'gnd',
        list_definitions = 'gnD',
        goto_next_usage = '<M-*>',
        goto_previous_usage = '<M-#>',
      },
    },
  },
  textsubjects = {enable = true, keymaps = {['.'] = 'textsubjects-smart'}},
  -- Currently unsupported by most
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {['<leader>a'] = '@parameter.inner'},
      swap_previous = {['<leader>A'] = '@parameter.inner'},
    },
    move = {
      enable = true,
      goto_next_start = {[']m'] = '@function.outer', [']]'] = '@class.outer'},
      goto_next_end = {[']M'] = '@function.outer', [']['] = '@class.outer'},
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {['[M'] = '@function.outer', ['[]'] = '@class.outer'},
    },
  },
}
-- require'nvim-treesitter.parsers'.get_parser_configs().markdown = nil
