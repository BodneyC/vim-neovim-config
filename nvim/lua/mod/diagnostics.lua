-- Until I figure out how to get markdownlint to return a column number
--  regardless, I need this
local M = {}

local fmt = string.format

function M.navigate(direction)
  return function(opts)
    opts = opts or {}
    local pos = vim.diagnostic[fmt('get_%s_pos', direction)](opts)
    if not pos then
      --- TODO: move to notify.lua, notify.diagnostics.no_more_diagnostics(direction:gsub("^%l", string.upper)))
      return print(fmt('Diagnostic%s: No more valid diagnostics to move to.',
        direction:gsub('^%l', string.upper)))
    end

    -- This is the block changed from:
    --  .../lspsaga.nvim/lua/lspsaga/diagnostic.lua
    -- Some linters (like markdownlint) don't always provide a column num,
    --  this default to SOL if that happens
    if pos[2] == -1 then
      pos[2] = 1
    end

    local win_id = opts.win_id or vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win_id, {pos[1] + 1, pos[2]})

    vim.schedule(function()
      require('lspsaga.diagnostic').show_line_diagnostics(opts.popup_opts, nil,
        vim.api.nvim_win_get_buf(win_id))
    end)
  end
end

return M
