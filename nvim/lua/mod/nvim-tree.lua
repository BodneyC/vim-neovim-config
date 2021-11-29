local M = {}
local view = require 'nvim-tree.view'
local lib = require 'nvim-tree.lib'

local nvim_tree = require('nvim-tree')

M.min_width = 30

function M.system(cmd)
  if view.is_help_ui() then
    return
  end
  local node = lib.get_node_at_cursor()
  if not node then
    return
  end
  if node.entries ~= nil then
    return
  end
  os.execute(cmd .. ' ' .. lib.get_last_group_node(node).absolute_path)
  lib.refresh_tree()
end

function M.system_cb(cmd)
  return [[:lua require('mod.nvim-tree')]] .. '.system([[' .. cmd .. ']])<CR>'
end

function M.resize(opts)
  local cur_win = -1
  if vim.bo.ft ~= 'NvimTree' then
    cur_win = vim.fn.bufwinnr(vim.fn.bufnr())
    nvim_tree.focus()
  end
  local cur_width = vim.fn.winwidth('.')
  local buf = vim.fn.getline(1, '$')
  table.remove(buf, 1)
  local width = M.min_width
  for _, l in ipairs(buf) do
    local line_width = #(l:gsub('^(.-)%s*$', '%1'))
    if line_width > width then
      width = line_width
    end
  end
  if width ~= cur_width then
    nvim_tree.resize(width)
    print('NvimTree resized (' .. width .. ')')
  end
  if opts.refocus and cur_win ~= -1 then
    vim.cmd(cur_win .. 'wincmd w')
  end
end

return M
