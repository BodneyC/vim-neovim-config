return {
  {
    'tpope/vim-fugitive',
    keys = { { '<leader>ge', '<Cmd>Gedit :<CR>', desc = 'Git status' } },
    lazy = false,
  },

  { 'sindrets/diffview.nvim', cmd = { 'DiffviewOpen', 'DiffviewFileHistory' } },
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
