--- Impatient
require('utl.util').safe_require('impatient')

--- Packer

local install_path = vim.fn.stdpath('data') ..
                       '/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                   install_path)
end

vim.cmd('packadd packer.nvim')
require('packer_compiled')

local packer = require('packer')

return packer.startup({
  function()
    local use = packer.use

    use {'lewis6991/impatient.nvim'}
    use {
      'wbthomason/packer.nvim',
      opt = true,
    }

    --- Lsp
    use {'tami5/lspsaga.nvim'}
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},
        {'hrsh7th/cmp-vsnip'},
        {'hrsh7th/cmp-calc'},
      },
    }
    use {'mfussenegger/nvim-jdtls'}
    use {'neovim/nvim-lspconfig'}
    use {'nvim-lua/lsp-status.nvim'}
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-packer.nvim'},
        {
          'nvim-telescope/telescope-fzy-native.nvim',
          run = {'make'},
        },
        -- One to track
        {'nvim-telescope/telescope-rg.nvim'},
      },
    }
    use {'onsails/lspkind-nvim'}

    --- DAP
    use {'mfussenegger/nvim-dap'}
    use {'theHamsta/nvim-dap-virtual-text'}
    use {'rcarriga/nvim-dap-ui'}
    use {'jbyuki/one-small-step-for-vimkind'}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'Pocco81/DAPInstall.nvim'}
    use {'mfussenegger/nvim-dap-python'}

    --- Added functionality
    use {'BodneyC/hex-this-vim'}
    use {'BodneyC/pic-vim'}
    use {'bodneyc/Comrade'}
    use {'windwp/nvim-spectre'}
    use {
      'christoomey/vim-tmux-navigator',
      cond = os.getenv('TMUX'),
    }
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn',
      ft = 'markdown',
    }
    use {
      'itchyny/calendar.vim',
      cmd = 'Cal',
    }
    use {
      'knubie/vim-kitty-navigator',
      cond = os.getenv('KITTY_WINDOW_ID'),
    }
    use {
      'nicwest/vim-http',
      cmd = 'Http',
    }
    use {'windwp/nvim-ts-autotag'}
    use {'nvim-treesitter/nvim-treesitter'}
    use {'nvim-treesitter/nvim-treesitter-refactor'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    use {
      'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle',
    }
    use {'JoosepAlviste/nvim-ts-context-commentstring'}
    use {'vigoux/treesitter-context.nvim'}
    use {'RRethy/nvim-treesitter-textsubjects'}
    use {
      'p00f/nvim-ts-rainbow',
      config = function()
        require('nvim-treesitter.configs').setup {
          rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 1000,
          },
        }
      end,
    }

    --- QOL
    use {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup {
          triggers_blacklist = {
            n = {'"'}, -- slow for "+
          },
        }
      end,
    }
    -- use {'spinks/vim-leader-guide'}
    -- NOTE:
    use {
      'folke/todo-comments.nvim',
      config = function()
        require('todo-comments').setup {
          signs = false,
          colors = {
            error = {'LspDiagnosticsDefaultError', 'ErrorMsg', '#D75F5F'},
            warning = {'LspDiagnosticsDefaultWarning', 'WarningMsg', '#AFAF5F'},
            info = {'LspDiagnosticsDefaultInformation', '#78BCAF'},
            hint = {'LspDiagnosticsDefaultHint', '#8AD1C3'},
            default = {'Identifier', '#87AFD7'},
          },
        }
      end,
    }
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
    use {
      'luukvbaal/stabilize.nvim',
      config = function()
        require('stabilize').setup {
          ignore = {
            filetype = {'help', 'list', 'Trouble', 'NvimTree', 'Outline'},
            buftype = {'terminal', 'quickfix', 'loclist'},
          },
        }
      end,
    }
    use {
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('trouble').setup()
      end,
    }
    use {'ludovicchabant/vim-gutentags'}
    use {'lukas-reineke/format.nvim'}
    use {'machakann/vim-swap'}
    use {
      'rhysd/vim-grammarous',
      ft = {'markdown', 'tex'},
    }
    use {'tpope/vim-commentary'}
    use {'simnalamburt/vim-mundo'}
    use {'zirrostig/vim-schlepp'}
    use {'voldikss/vim-floaterm'}

    --- Vim internal wrappers
    use {'BodneyC/At-Zed-vim'}
    use {'BodneyC/flocho'}
    use {'BodneyC/togool.vim'}
    use {
      'alvan/vim-closetag',
      ft = {'html', 'xml', 'markdown'},
    }
    use {'andymass/vim-matchup'}
    use {'moll/vim-bbye'}
    use {'ggandor/lightspeed.nvim'}
    use {'tpope/vim-repeat'}
    use {'tpope/vim-surround'}
    use {'tpope/vim-unimpaired'}
    use {'vim-utils/vim-all'}

    --- Prettiness
    -- use {'BodneyC/bolorscheme'}

    use {'KabbAmine/vCoolor.vim'}
    use {'lukas-reineke/indent-blankline.nvim'}
    use {'amdt/vim-niji'}
    use {'dstein64/nvim-scrollview'}
    use {
      'junegunn/goyo.vim',
      cmd = 'Goyo',
    }
    use {
      'junegunn/limelight.vim',
      cmd = 'Limelight',
    }
    use {
      'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
    }
    use {'rktjmp/lush.nvim'}
    use {
      'rrethy/vim-hexokinase',
      run = 'make hexokinase',
    }
    use {'nvim-lualine/lualine.nvim'}
    use {'wellle/targets.vim'}
    use {'wellle/visual-split.vim'}

    --- SDL
    use {'BodneyC/VirkSpaces'}
    use {'kyazdani42/nvim-tree.lua'}
    use {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
    }
    use {'f-person/git-blame.nvim'}
    use {
      'gregsexton/gitv',
      cmd = 'Gitv',
      requires = 'tpope/vim-fugitive',
    }
    use {
      'oguzbilgic/vim-gdiff',
      cmd = {'Gdiff', 'Gdiffsplit'},
    }

    --- Language support
    use {'hashivim/vim-terraform'}
    use {'BodneyC/sood-vim'}
    use {'BodneyC/knit-vim'}
    use {'drmingdrmer/vim-indent-lua'}
    use {'janko/vim-test'}
    use {'justinmk/vim-syntax-extra'}
    use {'leafgarland/typescript-vim'}
    use {
      'm-pilia/vim-pkgbuild',
      ft = 'pkgbuild',
    }
    use {'michaeljsmith/vim-indent-object'}
    use {'plasticboy/vim-markdown'}

    --- Local
    -- use {'~/Documents/knit-vim'}
    -- use {'~/gitclones/VirkSpaces'}
    -- use {'~/gitclones/barbar.nvim', branch = 'master', requires = {{'romgrk/lib.kom'}}}
    use {'~/gitclones/bolorscheme'}

  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
  },
})
