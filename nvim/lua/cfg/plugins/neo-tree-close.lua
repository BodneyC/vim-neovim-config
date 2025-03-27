return function()
  local M = require("neo-tree.setup")
  local utils = require("neo-tree.utils")
  local log = require("neo-tree.log")

  local win_id = vim.api.nvim_get_current_win()
  if utils.is_floating(win_id) then
    return
  end

  -- if the new win is not a floating window, make sure all neo-tree floats are closed
  -- manager.close_all("float")

  -- if M.config.close_if_last_window then
  local tabid = vim.api.nvim_get_current_tabpage()
  local wins = utils.get_value(M, "config.prior_windows", {})[tabid]
  local prior_exists = utils.truthy(wins)
  local non_floating_wins = vim.tbl_filter(function(win)
    return not utils.is_floating(win)
  end, vim.api.nvim_tabpage_list_wins(tabid))
  local win_count = #non_floating_wins

  log.trace("checking if last window")
  log.trace("prior window exists = ", prior_exists)
  log.trace("win_count: ", win_count)

  if prior_exists and win_count == 1 and vim.o.filetype == "neo-tree" then
    local position = vim.api.nvim_buf_get_var(0, "neo_tree_position")
    local source = vim.api.nvim_buf_get_var(0, "neo_tree_source")
    if position ~= "current" then
      -- close_if_last_window just doesn't make sense for a split style
      log.trace("last window, closing")
      local state = require("neo-tree.sources.manager").get_state(source)
      if state == nil then
        return
      end
      local mod = utils.get_opened_buffers()
      log.debug("close_if_last_window, modified files found: ", vim.inspect(mod))
      for filename, buf_info in pairs(mod) do
        if buf_info.modified then
          local buf_name, message
          if vim.startswith(filename, "[No Name]#") then
            buf_name = string.sub(filename, 11)
            message =
            "Cannot close because an unnamed buffer is modified. Please save or discard this file."
          else
            buf_name = filename
            message =
            "Cannot close because one of the files is modified. Please save or discard changes."
          end
          log.trace("close_if_last_window, showing unnamed modified buffer: ", filename)
          vim.schedule(function()
            log.warn(message)
            vim.cmd("rightbelow vertical split")
            vim.api.nvim_win_set_width(win_id, state.window.width or 40)
            vim.cmd("b " .. buf_name)
          end)
          return
        end
      end
      vim.cmd("bw")
      vim.cmd("q!")
      return
    end
    -- end
  end

  -- if vim.o.filetype == "neo-tree" then
  --   local _, position = pcall(vim.api.nvim_buf_get_var, 0, "neo_tree_position")
  --   if position == "current" then
  --     -- make sure the buffer wasn't moved to a new window
  --     local neo_tree_winid = vim.api.nvim_buf_get_var(0, "neo_tree_winid")
  --     local current_winid = vim.api.nvim_get_current_win()
  --     local current_bufnr = vim.api.nvim_get_current_buf()
  --     if neo_tree_winid ~= current_winid then
  --       -- At this point we know that either the neo-tree window was split,
  --       -- or the neo-tree buffer is being shown in another window for some other reason.
  --       -- Sometime the split is just the first step in the process of opening somethig else,
  --       -- so instead of fixing this right away, we add a short delay and check back again to see
  --       -- if the buffer is still in this window.
  --       local old_state = manager.get_state("filesystem", nil, neo_tree_winid)
  --       vim.schedule(function()
  --         local bufnr = vim.api.nvim_get_current_buf()
  --         if bufnr ~= current_bufnr then
  --           -- The neo-tree buffer was replaced with something else, so we don't need to do anything.
  --           log.trace("neo-tree buffer replaced with something else - no further action required")
  --           return
  --         end
  --         -- create a new tree for this window
  --         local state = manager.get_state("filesystem", nil, current_winid)
  --         state.path = old_state.path
  --         state.current_position = "current"
  --         local renderer = require("neo-tree.ui.renderer")
  --         state.force_open_folders = renderer.get_expanded_nodes(old_state.tree)
  --         require("neo-tree.sources.filesystem")._navigate_internal(state, nil, nil, nil, false)
  --       end)
  --       return
  --     end
  --   end
  --   -- it's a neo-tree window, ignore
  --   return
  -- end

  -- M.config.prior_windows = M.config.prior_windows or {}

  -- local tabid = vim.api.nvim_get_current_tabpage()
  -- local tab_windows = M.config.prior_windows[tabid]
  -- if tab_windows == nil then
  --   tab_windows = {}
  --   M.config.prior_windows[tabid] = tab_windows
  -- end
  -- table.insert(tab_windows, win_id)

  -- -- prune the history when it gets too big
  -- if #tab_windows > 100 then
  --   local new_array = {}
  --   local win_count = #tab_windows
  --   for i = 80, win_count do
  --     table.insert(new_array, tab_windows[i])
  --   end
  --   M.config.prior_windows[tabid] = new_array
  -- end
end
