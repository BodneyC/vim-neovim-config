-- Until I figure out how to get markdownlint to return a column number
--  regardless, I need this

local M = {}

local function _iter_diagnostic_move_pos(name, opts, pos) --
  opts = opts or {}

  local enable_popup = vim.F.if_nil(opts.enable_popup, true)
  local win_id = opts.win_id or vim.api.nvim_get_current_win()

  if not pos then
    print(string.format("%s: No more valid diagnostics to move to.", name))
    return
  end

  -- This is the block changed from:
  --  .../lspsaga.nvim/lua/lspsaga/diagnostic.lua
  -- Some linters (like markdownlint) don't always provide a column num,
  --  this default to SOL if that happens
  if pos[2] == -1 then
    pos[2] = 1
  end

  vim.api.nvim_win_set_cursor(win_id, {pos[1] + 1, pos[2]})

  if enable_popup then
    vim.schedule(function()
      require'lspsaga.diagnostic'.show_line_diagnostics(opts.popup_opts, vim.api.nvim_win_get_buf(win_id))
    end)
  end
end --

function M.lsp_jump_diagnostic_next(opts) --
  return _iter_diagnostic_move_pos(
    "DiagnosticNext",
    opts,
    vim.lsp.diagnostic.get_next_pos(opts)
  )
end --

function M.lsp_jump_diagnostic_prev(opts) --
  return _iter_diagnostic_move_pos(
    "DiagnosticPrevious",
    opts,
    vim.lsp.diagnostic.get_prev_pos(opts)
  )
end --

return M
