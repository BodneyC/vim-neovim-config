local install_path = vim.fn.stdpath('data') ..
                       '/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                   install_path)
end

vim.cmd('packadd packer.nvim')

local packer = require('packer')

return packer.startup(function()
  local use = packer.use

  use {'wbthomason/packer.nvim', opt = true}

  --- Lsp
  -- use {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}
  -- use {'ray-x/navigator.lua'}
  -- use {'ray-x/lsp_signature.nvim'}

  use {'glepnir/lspsaga.nvim'}
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-path'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'}, {'hrsh7th/cmp-vsnip'}, {'hrsh7th/cmp-calc'},
    },
  }
  -- use {'hrsh7th/nvim-compe'}
  use {'mfussenegger/nvim-jdtls'}
  use {'neovim/nvim-lspconfig'}
  use {'nvim-lua/lsp-status.nvim'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-packer.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim', run = {'make'}},
    },
  }
  use {'onsails/lspkind-nvim'}
  use {
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end,
  }
  use {'junegunn/fzf.vim'}

  --- DAP
  -- use {'mfussenegger/nvim-dap'}
  -- use {'jbyuki/one-small-step-for-vimkind'}
  -- use {'Pocco81/DAPInstall.nvim'}
  -- use {'mfussenegger/nvim-dap-python'}

  --- Debug
  use {'puremourning/vimspector'}

  --- Added functionality
  use {'BodneyC/hex-this-vim', branch = 'master'}
  use {'BodneyC/pic-vim', branch = 'master'}
  use {'bodneyc/Comrade', branch = 'master'}
  use {'windwp/nvim-spectre'}
  use {'christoomey/vim-tmux-navigator', cond = os.getenv('TMUX')}
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn', ft = 'markdown'}
  use {'itchyny/calendar.vim', cmd = 'Cal'}
  use {'knubie/vim-kitty-navigator', cond = os.getenv('KITTY_WINDOW_ID')}
  use {'nicwest/vim-http', cmd = 'Http'}
  use {'windwp/nvim-ts-autotag'}
  use {'nvim-treesitter/nvim-treesitter'}
  use {'nvim-treesitter/nvim-treesitter-refactor'}
  use {'nvim-treesitter/nvim-treesitter-textobjects'}
  use {'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle'}
  use {'vigoux/treesitter-context.nvim'}
  use {'RRethy/nvim-treesitter-textsubjects'}
  use {
    'p00f/nvim-ts-rainbow',
    config = function()
      require('nvim-treesitter.configs').setup {
        rainbow = {enable = true, extended_mode = true, max_file_lines = 1000},
      }
    end,
  }

  --- QOL
  use {'folke/todo-comments.nvim'}
  use {'folke/trouble.nvim'}
  use {'simrat39/symbols-outline.nvim'}
  use {'bronson/vim-visual-star-search'}
  use {'dominikduda/vim_current_word'}
  use {'honza/vim-snippets'}
  use {'hrsh7th/vim-vsnip'}
  use {'hrsh7th/vim-vsnip-integ'}
  use {'jiangmiao/auto-pairs'}
  use {'junegunn/vim-easy-align'}
  use {'kamykn/spelunker.vim'}
  use {
    'kwkarlwang/bufresize.nvim',
    config = function()
      require('bufresize').setup()
    end,
  }
  use {'liuchengxu/vista.vim', cmd = 'Vista'}
  use {'ludovicchabant/vim-gutentags'}
  use {'lukas-reineke/format.nvim'}
  use {'machakann/vim-swap'}
  use {'majutsushi/tagbar', cmd = 'Tagbar'}
  use {'rhysd/vim-grammarous', ft = {'markdown', 'tex'}}
  -- use {'scrooloose/nerdcommenter'}
  use {'tpope/vim-commentary'}
  use {'simnalamburt/vim-mundo'}

  --- Vim internal wrappers
  use {'BodneyC/At-Zed-vim', branch = 'master'}
  use {'BodneyC/flocho', branch = 'master'}
  use {'BodneyC/togool.vim', branch = 'master'}
  use {'alvan/vim-closetag', ft = {'html', 'xml', 'markdown'}}
  use {'andymass/vim-matchup'}
  -- use {'chrisbra/recover.vim'}
  use {'moll/vim-bbye'}
  use {'radenling/vim-dispatch-neovim'}
  use {'rhysd/clever-f.vim'}
  use {'tpope/vim-dispatch'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-unimpaired'}
  use {'vim-scripts/BufOnly.vim'}
  use {'vim-utils/vim-all'}

  --- Prettiness
  use {'BodneyC/bolorscheme', branch = 'lua'}
  use {'KabbAmine/vCoolor.vim'}
  use {'lukas-reineke/indent-blankline.nvim'}
  use {'amdt/vim-niji'}
  use {'dstein64/nvim-scrollview'}
  use {'junegunn/goyo.vim', cmd = 'Goyo'}
  use {'junegunn/limelight.vim', cmd = 'Limelight'}
  use {'kristijanhusak/defx-icons'}
  use {'kyazdani42/nvim-web-devicons'}
  use {'romgrk/barbar.nvim', requires = {{'romgrk/lib.kom'}}}
  -- use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
  use {'rktjmp/lush.nvim'}
  use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
  use {'hoob3rt/lualine.nvim'}
  use {'wellle/targets.vim'}
  use {'wellle/visual-split.vim'}

  --- SDL
  use {'BodneyC/VirkSpaces', branch = 'master'}
  use {'Shougo/defx.nvim', run = ':UpdateRemotePlugins'}
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use {'f-person/git-blame.nvim'}
  use {'gregsexton/gitv', cmd = 'Gitv', requires = {{'tpope/vim-fugitive'}}}
  use {'junegunn/gv.vim', cmd = 'GV'}
  use {'kristijanhusak/defx-git'}
  use {'oguzbilgic/vim-gdiff', cmd = {'Gdiff', 'Gdiffsplit'}}
  use {'rbong/vim-flog', cmd = 'Flog'}
  use {'sodapopcan/vim-twiggy', cmd = 'Twiggy'}

  --- Language support
  use {'BodneyC/sood-vim', branch = 'master'}
  use {'BodneyC/knit-vim', branch = 'master'}
  use {'drmingdrmer/vim-indent-lua'}
  use {'janko/vim-test', cmd = 'TestFile'}
  use {'justinmk/vim-syntax-extra'}
  use {'leafgarland/typescript-vim'}
  use {'m-pilia/vim-pkgbuild', ft = 'pkgbuild'}
  use {'mboughaba/i3config.vim'}
  use {'michaeljsmith/vim-indent-object'}
  use {'NoorWachid/VimVLanguage'}
  use {'plasticboy/vim-markdown'}
  use {'uiiaoo/java-syntax.vim'}
  use {'stevearc/vim-arduino'}
  use {'rhysd/vim-llvm'}

  --- Local
  -- use {'~/Documents/knit-vim'}
  -- use {'~/gitclones/VirkSpaces', branch = 'master'}
  -- use {'~/gitclones/barbar.nvim', branch = 'master', requires = {{'romgrk/lib.kom'}}}
  -- use {'~/gitclones/bolorscheme'}

end)
