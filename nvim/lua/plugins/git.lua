return {
  {
    'tpope/vim-fugitive',
    keys = { { '<leader>ge', '<Cmd>Gedit :<CR>', desc = 'Git status' } },
    lazy = false,
  },

  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<Cmd>DiffviewOpen<CR>', desc = 'Diff working tree' },
      { '<leader>gD', '<Cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>', desc = 'Diff branch' },
      { '<leader>gh', '<Cmd>DiffviewFileHistory %<CR>', desc = 'File history' },
      { '<leader>gh', ':DiffviewFileHistory<CR>', mode = 'x', desc = 'Range history' },
      { '<leader>gH', '<Cmd>DiffviewFileHistory<CR>', desc = 'Branch history' },
      { '<leader>gq', '<Cmd>DiffviewClose<CR>', desc = 'Close diffview' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = 'diff3_mixed',
          disable_diagnostics = true,
        },
      },
    },
  },

  {
    'akinsho/git-conflict.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { '<leader>gx', '<Cmd>GitConflictListQf<CR>', desc = 'List conflicts' },
    },
    opts = {
      -- leader-prefixed to match diffview and keep c{motion} free; both is <leader>ca since diffview's <leader>cb is base
      default_mappings = {
        ours = '<leader>co',
        theirs = '<leader>ct',
        both = '<leader>ca',
        none = '<leader>c0',
        next = ']x',
        prev = '[x',
      },
    },
    config = function(_, opts)
      require('git-conflict').setup(opts)

      -- the plugin's disable_diagnostics option uses vim.diagnostic.disable, removed in 0.12
      local group = vim.api.nvim_create_augroup('config_git_conflict', { clear = true })
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'GitConflictDetected',
        callback = function(args)
          vim.diagnostic.enable(false, { bufnr = args.buf })
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'GitConflictResolved',
        callback = function(args)
          vim.diagnostic.enable(true, { bufnr = args.buf })
        end,
      })
    end,
  },

  { 'oguzbilgic/vim-gdiff', cmd = { 'Gdiff', 'Gdiffsplit' } },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame_opts = {
        virt_text_pos = 'right_align',
        delay = 1000,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      on_attach = function(buf)
        local gs = require('gitsigns')

        local function map(lhs, rhs, desc, opts)
          opts = vim.tbl_extend('force', { buffer = buf, desc = desc }, opts or {})
          vim.keymap.set('n', lhs, rhs, opts)
        end

        map(']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.nav_hunk('next')
          end)
          return '<Ignore>'
        end, 'Next hunk', { expr = true })
        map('[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.nav_hunk('prev')
          end)
          return '<Ignore>'
        end, 'Prev hunk', { expr = true })

        map('<leader>hs', gs.stage_hunk, 'Stage hunk')
        map('<leader>hS', gs.undo_stage_hunk, 'Undo stage hunk')
        map('<leader>hu', gs.reset_hunk, 'Reset hunk')
        map('<leader>hU', gs.reset_buffer, 'Reset buffer')
        map('<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('<leader>hb', gs.blame_line, 'Blame line')
      end,
    },
  },
}
