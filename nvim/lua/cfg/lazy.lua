local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', --[[ latest stable release --]] lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require('cfg.plugins.which-key'),

  --[[------------------------------------------------------------------------
  LSP Setup and configuration
  --------------------------------------------------------------------------]]

  require('cfg.plugins.nvim-lspconfig'),
  require('cfg.plugins.cmp'),
  require('cfg.plugins.luasnip'),
  require('cfg.plugins.mason-lspconfig'),
  require('cfg.plugins.lspsaga'),
  -- require('cfg.plugins.symbols-outline'),
  require('cfg.plugins.fzf-lua'),
  require('cfg.plugins.nvim-treesitter'),
  require('cfg.plugins.tiny-inline-diagnostic'),

  --[[------------------------------------------------------------------------
  DAP Setup and configuration
  --------------------------------------------------------------------------]]

  'mfussenegger/nvim-dap',
  'theHamsta/nvim-dap-virtual-text',
  'jbyuki/one-small-step-for-vimkind',

  require('cfg.plugins.nvim-dap-ui'),
  require('cfg.plugins.dap-buddy'),
  require('cfg.plugins.nvim-dap-vscode-js'),
  require('cfg.plugins.nvim-dap-python'),
  require('cfg.plugins.nvim-dap-go'),

  --[[------------------------------------------------------------------------
  Extra Functionality
  --------------------------------------------------------------------------]]

  'HiPhish/rainbow-delimiters.nvim',
  'vim-test/vim-test',
  'windwp/nvim-spectre',
  'windwp/nvim-ts-autotag', -- Setup in ts.lua
  'seandewar/actually-doom.nvim',

  require('cfg.plugins.neotest'),
  require('cfg.plugins.navigator'),
  require('cfg.plugins.hex-this-vim'),
  require('cfg.plugins.neotest'),
  require('cfg.plugins.multicursor'),

  --[[------------------------------------------------------------------------
  Quality of Life
  --------------------------------------------------------------------------]]

  require('cfg.plugins.snacks'),
  -- 'LunarVim/bigfile.nvim',
  'bronson/vim-visual-star-search',
  'dominikduda/vim_current_word',
  'farmergreg/vim-lastplace',
  'junegunn/vim-easy-align',
  'kamykn/spelunker.vim',
  'machakann/vim-swap',
  require('cfg.plugins.conform'),
  'tpope/vim-commentary',
  'zirrostig/vim-schlepp',
  'rktjmp/playtime.nvim',
  -- 'jiangmiao/auto-pairs',

  require('cfg.plugins.todo-comments'),
  require('cfg.plugins.trouble'),
  require('cfg.plugins.bufresize'),
  require('cfg.plugins.autopairs'),
  require('cfg.plugins.stabilize'),
  require('cfg.plugins.clever-f'),

  --[[------------------------------------------------------------------------
  Wrappers Around Vim Internal-ish Stuff
  --------------------------------------------------------------------------]]

  'andymass/vim-matchup', -- % on `end`s
  'moll/vim-bbye',        -- <leader>bd
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'mbbill/undotree',
  'tpope/vim-unimpaired',
  'tweekmonster/startuptime.vim',
  'vim-utils/vim-all', -- a<CR>

  require('cfg.plugins.boole'),
  require('cfg.plugins.noice'),

  --[[------------------------------------------------------------------------
  Colors Outside of Treesitter
  --------------------------------------------------------------------------]]

  require('cfg.plugins.nvim-scrollview'),
  'voldikss/vim-floaterm',
  'wellle/targets.vim',
  'wellle/visual-split.vim',

  require('cfg.plugins.vCoolor'),
  require('cfg.plugins.limelight'),
  require('cfg.plugins.lualine'),
  require('cfg.plugins.vim-hexokinase'),

  -- require('cfg.plugins.everforest'),
  -- require('cfg.plugins.material'),
  -- require('cfg.plugins.oldworld'),
  -- require('cfg.plugins.nightfox'),
  require('cfg.plugins.kanagawa'),
  -- require('cfg.plugins.github-nvim-theme'),

  require('cfg.plugins.indent-blankline'),
  require('cfg.plugins.zen'),
  require('cfg.plugins.twilight'),
  -- require('cfg.plugins.bufferline'),

  --[[------------------------------------------------------------------------
  SDLC-ish Stuff
  --------------------------------------------------------------------------]]

  'tpope/vim-fugitive',
  'sindrets/diffview.nvim',

  require('cfg.plugins.vim-gdiff'),
  require('cfg.plugins.auto-session'),
  require('cfg.plugins.gitsigns'),
  require('cfg.plugins.neo-tree'),
  require('cfg.plugins.oil'),

  --[[------------------------------------------------------------------------
  Support for Specific Languages
  --------------------------------------------------------------------------]]

  'jose-elias-alvarez/typescript.nvim',
  'michaeljsmith/vim-indent-object',
  'midchildan/ft-confluence.vim',
  'pearofducks/ansible-vim',
  'simrat39/rust-tools.nvim',
  'towolf/vim-helm',

  require('cfg.plugins.knit-vim'),
  require('cfg.plugins.sood-vim'),
  require('cfg.plugins.vim-terraform'),
  require('cfg.plugins.vim-syntax-extra'),
  require('cfg.plugins.vim-pkgbuild'),

  ----- Markdown -----
  require('cfg.plugins.bullets'),
  require('cfg.plugins.markdown-nvim'),
  -- require('cfg.plugins.vim-markdown'),
  require('cfg.plugins.vim-markdown-toc'),
  require('cfg.plugins.markdown-preview'),

  ----- Latex -----
  require('cfg.plugins.vimtex'),

  ----- Node -----
  -- require('cfg.plugins.import-cost'),

  ----- Python -----
  require('cfg.plugins.f-string-toggle'),

  --[[------------------------------------------------------------------------
  Note-taking
  --------------------------------------------------------------------------]]

  require('cfg.plugins.wiki'),

})
