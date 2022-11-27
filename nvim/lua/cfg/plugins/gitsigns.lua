require('gitsigns').setup {
  signs = {
    add = {
      hl = 'GitSignsAdd',
      text = '│',
      numhl = 'GitSignsAddNr',
      linehl = 'GitSignsAddLn',
    },
    change = {
      hl = 'GitSignsChange',
      text = '│',
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
    delete = {
      hl = 'GitSignsDelete',
      text = '_',
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '‾',
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    changedelete = {
      hl = 'GitSignsChange',
      text = '~',
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]c'] = {
      expr = true,
      '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\'',
    },
    ['n [c'] = {
      expr = true,
      '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\'',
    },

    ['n <Leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <Leader>hS'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <Leader>hu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <Leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <Leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <Leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  watch_gitdir = {
    interval = 1000,
  },
  diff_opts = {
    internal = true,
  },
}
