local M = {}

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param desc? string
---@param opts? vim.keymap.set.Opts
function M.map(mode, lhs, rhs, desc, opts)
  opts = vim.tbl_extend('force', { silent = true, desc = desc }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

---@param keys string
---@param mode? string
function M.feedkeys(keys, mode)
  vim.api.nvim_feedkeys(vim.keycode(keys), mode or 'n', false)
end

local opposite = { h = 'l', l = 'h', j = 'k', k = 'j' }

local function is_edge(dir)
  return vim.fn.winnr() == vim.fn.winnr(dir)
end

---@param dir 'h'|'j'|'k'|'l'
function M.resize_window(dir)
  if vim.fn.winnr('$') == 1 then
    return
  end

  local vertical = dir == 'h' or dir == 'l'
  local at_edge = is_edge(dir)
  local sign = '+'
  if at_edge then
    sign = '-'
  elseif dir ~= 'j' and not is_edge(opposite[dir]) and dir ~= 'l' then
    sign = '-'
  end

  if not vertical and sign == '-' and is_edge(opposite[dir]) then
    return
  end

  local step = vim.g.resize_increment or 2
  vim.cmd((vertical and 'vertical ' or '') .. 'resize ' .. sign .. step)
end

function M.wipe_hidden_buffers()
  local visible = {}
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
      visible[vim.api.nvim_win_get_buf(win)] = true
    end
  end

  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if
        not visible[buf]
        and not vim.bo[buf].modified
        and not vim.api.nvim_buf_get_name(buf):find('Neotest ', 1, true)
        and pcall(vim.api.nvim_buf_delete, buf, { force = true })
    then
      count = count + 1
    end
  end

  if count > 0 then
    vim.notify(count .. ' buffers wiped out')
  end
end

return M
