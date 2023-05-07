local M = {}

local nvim_tree = require('nvim-tree')
local view = require('nvim-tree.view')
local api = require('nvim-tree.api')

local function system(cmd, opts)
  opts = opts or {}
  return function()
    local node = api.tree.get_node_under_cursor()
    if not node then
      return
    end
    if not opts.directories and node.entries ~= nil then
      print('Not running for directories')
      return
    end
    local cmd_str = cmd
    if not opts.without_file then
      cmd_str = cmd_str .. ' ' .. node.absolute_path
    end
    if opts.echo_cmd then
      print(cmd_str)
    end
    local fd = io.popen(cmd_str .. ' 2>&1')
    if fd ~= nil then
      local stdout = fd:read("*a"):gsub('[\n\r]', ' ')
      fd:close()
      print(stdout)
    else
      print("Couldn't run command: " .. cmd_str)
    end
    api.tree.reload()
  end
end

function M.on_attach(bufnr)
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Default mappings. Feel free to modify or remove as you wish.
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
  vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  -- END_DEFAULT_ON_ATTACH

  -- Custom
  vim.keymap.set('n', 'Y', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Open'))

  vim.keymap.set('n', '+x', system('chmod +x', { echo_cmd = true }), opts('+x'))
  vim.keymap.set('n', '-x', system('chmod -x', { echo_cmd = true }), opts('-x'))
  vim.keymap.set('n', 'd', system('rem --', { echo_cmd = true }), opts('rem file'))
  vim.keymap.set('n', 'D', system('rem --', { directories = true, echo_cmd = true }), opts('rem dir'))
  vim.keymap.set('n', 'u', system('NO_COLOR==true rem last', { directories = true, without_file = true, }),
    opts('rem undo last'))
end

M.min_width = 30
M.max_width = 50

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
    elseif line_width > M.max_width then
      width = M.max_width
      break
    end
  end
  if width ~= cur_width then
    view.resize(width)
    print('NvimTree resized (' .. width .. ')')
  end
  if opts.refocus and cur_buf ~= -1 then
    vim.cmd(vim.fn.bufwinnr(cur_buf) .. 'wincmd w')
  end
end

return M
