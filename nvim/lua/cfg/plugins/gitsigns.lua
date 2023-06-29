return {
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
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})
    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})
    map('n','<Leader>hs', gs.stage_hunk, {})
    map('n','<Leader>hS', gs.undo_stage_hunk, {})
    map('n','<Leader>hu', gs.reset_hunk, {})
    map('n','<Leader>hU', gs.reset_buffer, {})
    map('n','<Leader>hp', gs.preview_hunk, {})
    map('n','<Leader>hb', gs.blame_line, {})

  end,
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
