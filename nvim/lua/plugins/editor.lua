return {
  {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup()
      local directions = {
        ['<M-k>'] = 'Up',
        ['<M-h>'] = 'Left',
        ['<M-j>'] = 'Down',
        ['<M-l>'] = 'Right',
        ['<M-\\>'] = 'Previous',
        ['˚'] = 'Up',
        ['˙'] = 'Left',
        ['∆'] = 'Down',
        ['¬'] = 'Right',
      }
      for lhs, dir in pairs(directions) do
        local cmd = '<Cmd>Navigator' .. dir .. '<CR>'
        vim.keymap.set({ 'n', 'i' }, lhs, cmd, { desc = 'Navigate ' .. dir:lower() })
        vim.keymap.set('t', lhs, '<C-\\><C-n>' .. cmd, { desc = 'Navigate ' .. dir:lower() })
      end
    end,
  },

  {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
      local mc = require('multicursor-nvim')
      mc.setup()

      local set = vim.keymap.set
      set('n', '<Up>', function()
        mc.lineAddCursor(-1)
      end, { desc = 'Add cursor above' })
      set('n', '<Down>', function()
        mc.lineAddCursor(1)
      end, { desc = 'Add cursor below' })
      set('n', '<leader><Up>', function()
        mc.lineSkipCursor(-1)
      end, { desc = 'Skip cursor above' })
      set('n', '<leader><Down>', function()
        mc.lineSkipCursor(1)
      end, { desc = 'Skip cursor below' })
      set({ 'n', 'x' }, '<leader>n', function()
        mc.matchAddCursor(1)
      end, { desc = 'Add cursor at next match' })
      set({ 'n', 'x' }, '<leader>s', function()
        mc.matchSkipCursor(1)
      end, { desc = 'Skip next match' })
      set({ 'n', 'x' }, '<leader>N', function()
        mc.matchAddCursor(-1)
      end, { desc = 'Add cursor at prev match' })
      set({ 'n', 'x' }, '<leader>S', function()
        mc.matchSkipCursor(-1)
      end, { desc = 'Skip prev match' })
      set('n', '<C-LeftMouse>', mc.handleMouse)
      set('n', '<C-LeftDrag>', mc.handleMouseDrag)
      set('n', '<C-LeftRelease>', mc.handleMouseRelease)

      mc.addKeymapLayer(function(layer)
        layer({ 'n', 'x' }, '<Left>', mc.prevCursor)
        layer({ 'n', 'x' }, '<Right>', mc.nextCursor)
        layer({ 'n', 'x' }, '<leader>x', mc.deleteCursor)
        layer('n', '<Esc>', function()
          if mc.cursorsEnabled() then
            mc.clearCursors()
          else
            mc.enableCursors()
          end
        end)
      end)

      local hl = vim.api.nvim_set_hl
      hl(0, 'MultiCursorCursor', { reverse = true })
      hl(0, 'MultiCursorVisual', { link = 'Visual' })
      hl(0, 'MultiCursorSign', { link = 'SignColumn' })
      hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
      hl(0, 'MultiCursorDisabledCursor', { reverse = true })
      hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
      hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
  },

  {
    'rhysd/clever-f.vim',
    init = function()
      vim.g.clever_f_mark_char_color = 'ModeMsg'
    end,
    config = function()
      vim.keymap.set('', ';', '<Plug>(clever-f-repeat-forward)')
      vim.keymap.set('', ',', '<Plug>(clever-f-repeat-back)')
      vim.keymap.set('n', '<Esc>', function()
        vim.fn['clever_f#reset']()
        return '<Esc>'
      end, { expr = true })
    end,
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '<leader>o', '<Cmd>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
      { '<leader>xx', '<Cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnostics (Trouble)' },
      { '\\x', '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer diagnostics (Trouble)' },
      { '\\s', '<Cmd>Trouble symbols toggle focus=false<CR>', desc = 'Symbols (Trouble)' },
      { '\\v', '<Cmd>Trouble lsp toggle focus=false win.position=right<CR>', desc = 'LSP (Trouble)' },
      { '<leader>xL', '<Cmd>Trouble loclist toggle<CR>', desc = 'Location list (Trouble)' },
      { '<leader>xQ', '<Cmd>Trouble qflist toggle<CR>', desc = 'Quickfix list (Trouble)' },
    },
  },

  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'rmagatti/auto-session',
    opts = {
      log_level = 'warn',
      suppressed_dirs = { '~/' },
      close_unsupported_windows = true,
      bypass_save_filetypes = { 'neo-tree' },
    },
  },

  {
    'kamykn/spelunker.vim',
    init = function()
      vim.g.spelunker_disable_auto_group = 1
      vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWritePost' }, {
        group = vim.api.nvim_create_augroup('config_spelunker', { clear = true }),
        pattern = { '*.md', '*.txt', '*.tex' },
        callback = function()
          vim.fn['spelunker#check']()
        end,
      })
    end,
  },

  {
    'andymass/vim-matchup',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'status' }
    end,
  },

  {
    'voldikss/vim-floaterm',
    init = function()
      vim.g.floaterm_rootmarkers = { '.project', '.git', '.hg', '.svn', '.root', '.vim' }
      vim.g.floaterm_autoclose = 1
    end,
  },

  {
    'junegunn/vim-easy-align',
    cmd = 'EasyAlign',
    keys = {
      { '<leader>ea', 'vip:EasyAlign<CR>', desc = 'Easy align paragraph' },
      { '<leader>ea', ':EasyAlign<CR>', mode = 'v', desc = 'Easy align' },
    },
  },

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = { { '<leader>U', '<Cmd>UndotreeToggle<CR>', desc = 'Undo tree' } },
  },

  {
    'zirrostig/vim-schlepp',
    keys = {
      { '<Up>', '<Plug>SchleppUp', mode = 'v' },
      { '<Down>', '<Plug>SchleppDown', mode = 'v' },
      { '<Left>', '<Plug>SchleppLeft', mode = 'v' },
      { '<Right>', '<Plug>SchleppRight', mode = 'v' },
    },
  },

  { 'nat-418/boole.nvim', opts = { mappings = { increment = '<C-a>', decrement = '<C-x>' } } },
  { 'windwp/nvim-spectre', cmd = 'Spectre', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'BodneyC/hex-this-vim', cmd = 'HexThis' },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  'bronson/vim-visual-star-search',
  'farmergreg/vim-lastplace',
  'machakann/vim-swap',
  'michaeljsmith/vim-indent-object',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'vim-utils/vim-all',
  'wellle/targets.vim',
  'wellle/visual-split.vim',

  { 'rktjmp/playtime.nvim', cmd = 'Playtime' },
  { 'seandewar/actually-doom.nvim', cmd = 'Doom' },
}
