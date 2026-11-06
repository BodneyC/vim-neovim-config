local M = {}

---@param cmd string
---@param opts? { run_on_dirs?: boolean, append_filepath?: boolean, append_root_dir?: boolean }
function M.system(cmd, opts)
  opts = vim.tbl_extend('keep', opts or {}, {
    run_on_dirs = false,
    append_filepath = true,
    append_root_dir = false,
  })
  return function(state)
    local node = state.tree:get_node()
    if not node then
      return
    end
    if not opts.run_on_dirs and node.type == 'directory' then
      vim.notify('Not running for directories')
      return
    end

    local target
    if opts.append_filepath or (opts.run_on_dirs and node.type == 'directory') then
      target = node.path
    elseif opts.append_root_dir then
      target = state.tree:get_nodes()[1].id
    end

    local full = cmd .. (target and (' ' .. vim.fn.shellescape(target)) or '')
    vim.notify(full)
    local out = vim.fn.system(full .. ' 2>&1'):gsub('[\n\r]', ' ')
    vim.notify(out)
    require('neo-tree.sources.manager').refresh('all')
  end
end

function M.close_if_last_window()
  local utils = require('neo-tree.utils')
  local win = vim.api.nvim_get_current_win()
  if utils.is_floating(win) or vim.bo.filetype ~= 'neo-tree' then
    return
  end

  local tab = vim.api.nvim_get_current_tabpage()
  local prior = utils.get_value(require('neo-tree.setup'), 'config.prior_windows', {})[tab]
  local wins = vim.tbl_filter(function(w)
    return not utils.is_floating(w)
  end, vim.api.nvim_tabpage_list_wins(tab))
  if not utils.truthy(prior) or #wins ~= 1 or vim.b.neo_tree_position == 'current' then
    return
  end

  local state = require('neo-tree.sources.manager').get_state(vim.b.neo_tree_source)
  if not state then
    return
  end

  for name, info in pairs(utils.get_opened_buffers()) do
    if info.modified then
      local unnamed = vim.startswith(name, '[No Name]#')
      vim.schedule(function()
        require('neo-tree.log').warn(
          unnamed and 'Cannot close because an unnamed buffer is modified. Please save or discard this file.'
          or 'Cannot close because one of the files is modified. Please save or discard changes.'
        )
        vim.cmd('rightbelow vertical split')
        vim.api.nvim_win_set_width(win, state.window.width or 40)
        vim.cmd.buffer(unnamed and name:sub(11) or name)
      end)
      return
    end
  end

  vim.cmd('bwipeout')
  vim.cmd('quit!')
end

return M
