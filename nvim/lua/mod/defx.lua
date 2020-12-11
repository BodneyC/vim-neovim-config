local vim = vim

local M = {}

function M.open()
  local opts = {
    '-columns=indent:git:icons:filename:type', '-split=vertical', '-winwidth=32', '-no-auto-cd',
    '-direction=topleft', '-show-ignored-files',
    '-session-file=' .. os.getenv('HOME') .. '/.config/defx/sessions/defx-sessions.json',
  }
  vim.fn.execute('Defx ' .. table.concat(opts, ' '))
end

function M.init()
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
