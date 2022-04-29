local M = {}
local view = require 'nvim-tree.view'
local lib = require 'nvim-tree.lib'

local nvim_tree = require('nvim-tree')

M.min_width = 30

function M.system(cmd, opts)
  if view.is_help_ui() then
    return
  end
  local node = lib.get_node_at_cursor()
  if not node then
    return
  end
  if not opts.directories and node.entries ~= nil then
    print('Not running for directories')
    return
  end
  local cmd_str = cmd
  if not opts.ignore_file then
    cmd_str = cmd_str .. ' ' .. lib.get_last_group_node(node).absolute_path
  end
  vim.cmd([[echo """]] .. cmd_str .. [["""]])
  os.execute(cmd_str)
  lib.refresh_tree()
end

function M.system_cb(cmd, opts)
  if not opts then
    opts = {}
  end
  local opts_str = vim.inspect(opts, {
    newline = '',
    indent = '',
  })
  return [[:lua require('mod.nvim-tree')]] .. '.system([[' .. cmd .. ']], ' ..
           opts_str .. ')<CR>'
end

function M.resize(opts)
  local cur_buf = -1
  if vim.bo.ft ~= 'NvimTree' then
    cur_buf = vim.fn.bufnr()
    nvim_tree.focus()
  end
  local cur_width = vim.fn.winwidth('.')
  local buf = vim.fn.getline(1, '$')
  table.remove(buf, 1)
  local width = M.min_width
  for _, l in ipairs(buf) do
    local line_width = #(l:gsub('^(.-)%s*$', '%1'):gsub('➛.*', ''))
    if line_width > width then
      width = line_width
    end
  end
  if width ~= cur_width then
    nvim_tree.resize(width)
    print('NvimTree resized (' .. width .. ')')
  end
  if opts.refocus and cur_buf ~= -1 then
    vim.cmd(vim.fn.bufwinnr(cur_buf) .. 'wincmd w')
  end
end

return M
