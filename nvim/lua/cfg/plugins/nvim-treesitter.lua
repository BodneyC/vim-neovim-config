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
  branch = 'main',
  build = ':TSUpdate',
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(_)
        if vim.bo.buftype ~= '' then return end
        if not vim.tbl_contains({ 'python', 'html', 'yaml', 'markdown' }, vim.bo.filetype) then
          vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end
        pcall(vim.treesitter.start)
      end
    })
    local already_installed = require('nvim-treesitter.config').get_installed()
    local parsers_to_install = vim.iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()
    require('nvim-treesitter').install(parsers_to_install._table)
  end
}
