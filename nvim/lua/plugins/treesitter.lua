local parsers = {
  'bash',
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

local no_ts_indent = { python = true, html = true, yaml = true, markdown = true }

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local installed = require('nvim-treesitter.config').get_installed()
      local missing = vim.tbl_filter(function(parser)
        return not vim.list_contains(installed, parser)
      end, parsers)
      if #missing > 0 then
        require('nvim-treesitter').install(missing)
      end
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('config_treesitter', { clear = true }),
        callback = function(ev)
          if vim.bo[ev.buf].buftype ~= '' then
            return
          end
          if not no_ts_indent[ev.match] then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'xml', 'kotlin' },
    opts = {},
  },
}
