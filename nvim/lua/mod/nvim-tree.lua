local M = {}

local nvim_tree = require('nvim-tree')

M.min_width = 30

function M.resize(opts)
  local cur_win = -1
  if vim.bo.ft ~= 'NvimTree' then
    cur_win = vim.fn.bufwinnr(vim.fn.bufnr())
    nvim_tree.focus()
  end
  local buf = vim.fn.getline(1, '$')
  table.remove(buf, 1)
  local width = 34
  for _, l in ipairs(buf) do
    local line_width = #(l:gsub('^(.-)%s*$', '%1'))
    if line_width > width then
      width = line_width
    end
  end
  -- vim.cmd('vertical resize' .. width)
  nvim_tree.resize(width)
  print('NvimTree resized (' .. width .. ')')
  if opts.refocus and cur_win ~= -1 then
    vim.cmd(cur_win .. 'wincmd w')
  end
end

return M
