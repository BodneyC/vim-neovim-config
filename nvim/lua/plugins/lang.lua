return {
  'midchildan/ft-confluence.vim',
  'pearofducks/ansible-vim',
  'towolf/vim-helm',
  { 'BodneyC/knit-vim', ft = 'knit' },
  { 'BodneyC/sood-vim', ft = 'sood' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  { 'justinmk/vim-syntax-extra', ft = { 'lex', 'yacc' } },
  { 'm-pilia/vim-pkgbuild', ft = 'pkgbuild' },

  {
    'dkarter/bullets.vim',
    ft = 'markdown',
    init = function()
      vim.g.bullets_outline_levels = { 'ROM', 'ABC', 'num', 'abc', 'rom', 'std-' }
    end,
  },

  -- {
  --   'MeanderingProgrammer/markdown.nvim',
  --   name = 'render-markdown',
  --   ft = 'markdown',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --   opts = {
  --     latex = { enabled = false },
  --     heading = { icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' } },
  --     bullet = { icons = { '●', '○', '◆', '◇' } },
  --     win_options = {
  --       conceallevel = { rendered = 0 },
  --       concealcursor = { rendered = 'nvic' },
  --     },
  --     code = { language_name = false },
  --   },
  -- },

  {
    'mzlogin/vim-markdown-toc',
    ft = 'markdown',
    init = function()
      vim.g.vmt_list_item_char = '-'
      vim.g.vmt_list_indent_text = '  '
      vim.g.vmt_dont_insert_fence = 1
    end,
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = 'markdown',
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
  },

  {
    'lervag/vimtex',
    ft = 'tex',
    init = function()
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = '.aux',
        out_dir = '',
        callback = 1,
        continuous = 1,
        executable = 'latexmk',
        hooks = {},
        options = { '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode' },
      }
    end,
  },

  {
    'roobert/f-string-toggle.nvim',
    ft = 'python',
    opts = { key_binding = '<leader>sf', key_binding_desc = 'Toggle f-string' },
  },

  {
    'lervag/wiki.vim',
    init = function()
      local root = vim.fs.normalize('~/.notes-wiki')
      vim.fn.mkdir(root, 'p')
      vim.g.wiki_root = root
      vim.g.wiki_mappings_prefix = [[\\w]]
      vim.g.wiki_global_load = 0
      vim.g.wiki_filetypes = { 'md', 'sh' }
    end,
  },
}
