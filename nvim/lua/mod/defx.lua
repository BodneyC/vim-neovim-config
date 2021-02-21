local vim = vim

local M = {}

M.open = function()
  local opts = {
    '-columns=indent:git:icons:filename', '-split=vertical', '-winwidth=32', '-no-auto-cd',
    '-direction=topleft', '-show-ignored-files',
    '-session-file=' .. os.getenv('HOME') .. '/.config/defx/sessions/defx-sessions.json',
  }
  vim.fn.execute('Defx ' .. table.concat(opts, ' '))
end

M.defx_resize = function()
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

M.init = function()
  require'utl.util'.augroup([[
    augroup __DEFX__
      au!
      au BufEnter * if (winnr("$") == 1 && &ft == 'defx') | silent call defx#call_action('add_session') | bd! | q | endif
      au BufLeave * if &ft == 'defx' | silent call defx#call_action('add_session') | endif
    augroup END
  ]])
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
