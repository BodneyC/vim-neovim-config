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

  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = function(name, blame_info, opts)
    if blame_info.author == name then
      blame_info.author = 'You'
    end

    local text
    if blame_info.author == 'Not Committed Yet' then
      text = blame_info.author
    else
      local date_time

      if opts.relative_time then
        date_time = require('gitsigns.util').get_relative_time(tonumber(blame_info['author_time']))
      else
        date_time = os.date('%Y-%m-%d', tonumber(blame_info['author_time']))
      end

      -- Extra spaces to account for nvim-scrollview
      text = string.format('%s • %s • %s  ', blame_info.author, date_time, blame_info.summary)
    end

    -- Pinched from:
    --  https://github.com/lewis6991/gitsigns.nvim/issues/368#issuecomment-927097279
    local ffi = require("ffi")
    ffi.cdef 'int curwin_col_off(void);'
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local len = #vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
    local width = vim.api.nvim_win_get_width(0) - ffi.C.curwin_col_off()
    local available_space = math.max(0, width - len)

    if available_space == 0 then
      return { { '', 'GitSignsCurrentLineBlame' } }
    elseif #text > available_space then
      text = text:sub(1, available_space - 1)
      return { { ' ' .. text, 'GitSignsCurrentLineBlame' } }
    else
      return { { ' ' .. text, 'GitSignsCurrentLineBlame' } }
    end
  end,


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
    end, { expr = true })
    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })
    map('n', '<Leader>hs', gs.stage_hunk, {})
    map('n', '<Leader>hS', gs.undo_stage_hunk, {})
    map('n', '<Leader>hu', gs.reset_hunk, {})
    map('n', '<Leader>hU', gs.reset_buffer, {})
    map('n', '<Leader>hp', gs.preview_hunk, {})
    map('n', '<Leader>hb', gs.blame_line, {})
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
