local autotag_filetypes = {
  'html',
  'javascript',
  'javascriptreact',
  'typescriptreact',
  'svelte',
  'vue',
  'xml',
  'kotlin',
}

local ensure_installed = {
  'bash',
  -- 'bibtex',
  'c',
  'clojure',
  'cpp',
  'css',
  'editorconfig',
  'gitignore',
  'go',
  'html',
  'java',
  'javascript',
  'jsdoc',
  'json',
  -- 'latex',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'ruby',
  'toml',
  'tsx',
  'typescript',
  'vimdoc',
  'yaml',
}

return {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  config = function()
    vim.g.skip_ts_context_commentstring_module = true
    require('nvim-treesitter.configs').setup(
      {
        autotag = {
          enable = true,
          filetypes = autotag_filetypes,
        },
        disable = { 'tex' },
        ensure_installed = ensure_installed,
        indent = {
          enable = true,
          disable = { 'yaml', 'python' },
        },
        highlight = {
          enable = true,
          disable = { 'yaml' },
        },
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
          smart_rename = {
            enable = false,
            keymaps = {
              smart_rename = '<Leader>R',
            },
          },
          highlight_current_scope = {
            enable = false,
          },
          highlight_definitions = {
            enable = false,
          },
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
        -- textsubjects = {
        --   enable = false,
        --   keymaps = {
        --     ['.'] = 'textsubjects-smart',
        --   },
        -- },
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
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
        endwise = { enable = true },
      }
    )
    require('ts_context_commentstring').setup(
      {
        enable = true,
        enable_autocmd = true,
        config = {
          markdown = '<!-- %s -->',
          c = '// %s',
        },
      }
    )
  end,
  dependencies = {
    'RRethy/nvim-treesitter-endwise',
    -- 'RRethy/nvim-treesitter-textsubjects',
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'JoosepAlviste/nvim-ts-context-commentstring',
    { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
  },
}
