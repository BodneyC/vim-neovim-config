local vim = vim
local util = require 'utl.util'

local M = {}

function M.open()
  local opts = {
    '-columns=indent:git:icons:filename', '-split=vertical', '-winwidth=32', '-no-auto-cd',
    '-direction=topleft', '-show-ignored-files',
    '-session-file=' .. os.getenv('HOME') .. '/.config/defx/sessions/defx-sessions.json',
  }
  local fn = vim.fn.expand('%:p')
  vim.fn.execute('Defx ' .. table.concat(opts, ' '))
  print(fn)
  M.go_to_file(fn)
end

function M.go_to_file(fn)
  if not fn then fn = vim.fn.expand('%:p') end
  vim.fn['defx#call_action']('search', fn)
end

function M.defx_resize()
  local cur_win = vim.fn.bufnr()
  M.open()
  local buf = vim.fn.getline(1, '$')
  table.remove(buf, 1)
  table.sort(buf, function(a, b)
    return #a > #b
  end)
  vim.cmd('vertical resize' .. #buf[1])
  vim.cmd(cur_win .. 'wincmd w')
end

function M.init()
  util.augroup({
    name = '__DEFX__',
    autocmds = {
      {
        event = 'BufEnter',
        glob = '*',
        cmd = [[if (winnr("$") == 1 && &ft == 'defx') | silent call defx#call_action('add_session') | bd! | q | endif]],
      }, {
        event = 'BufLeave',
        glob = '*',
        cmd = [[if &ft == 'defx' | silent call defx#call_action('add_session') | endif]],
      },
    },
  })
  vim.fn['defx#custom#column']('git', 'indicators', {
    Modified = '~',
    Staged = '+',
    Untracked = '✭',
    Renamed = '➜',
    Unmerged = '═',
    Ignored = 'i',
    Deleted = '×',
    Unknown = '?',
  })
  vim.fn.execute('command! -nargs=0 DefxOpen lua require\'mod.defx\'.open()')
  vim.api.nvim_set_keymap('n', '<Leader>d', '<CMD>DefxOpen<CR>', {silent = true, noremap = true})
end

return M
