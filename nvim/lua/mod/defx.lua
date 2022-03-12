local util = require('utl.util')

local M = {}

function M.search_file(fn)
  if not fn then
    fn = vim.fn.expand('%:p')
  end
  vim.fn['defx#call_action']('search_recursive', fn)
end

function M.open()
  local opts = {
    '-columns=indent:git:space:icons:space:filename',
    '-split=vertical',
    '-winwidth=32',
    '-no-auto-cd',
    '-direction=topleft',
    '-show-ignored-files',
    '-session-file=' .. os.getenv('HOME') ..
      '/.config/defx/sessions/defx-sessions.json',
  }
  local fn = vim.fn.expand('%:p')
  vim.fn.execute('Defx ' .. table.concat(opts, ' '))
  M.search_file(fn)
end

function M.resize()
  if vim.bo.ft ~= 'defx' then
    print('Not a defx buffer')
  end
  local buf = vim.fn.getline(1, '$')
  table.remove(buf, 1)
  table.remove(buf, #table)
  local width = 1
  for _, l in ipairs(buf) do
    local line_width = #(l:gsub('^(.-)%s*$', '%1'))
    if line_width > width then
      width = line_width
    end
  end
  vim.cmd('vertical resize' .. width)
  print('Defx resized')
end

function M.open_and_size(opts)
  local cur_win = vim.fn.bufwinnr(vim.fn.bufnr())
  if opts.open then
    M.open()
  end
  if opts.resize then
    M.resize()
  end
  if opts.refocus then
    vim.cmd(cur_win .. 'wincmd w')
  end
end

function M.init()
  do
    local group = vim.api.nvim_create_augroup('__DEFX__', {
      clear = true,
    })
    vim.api.nvim_create_autocmd('BufEnter', {
      group = group,
      pattern = '*',
      command = [[if (winnr("$") == 1 && &ft == 'defx') | ]] ..
        [[silent call defx#call_action('add_session') | bd! | q | endif]],
    })
    vim.api.nvim_create_autocmd('BufLeave', {
      group = group,
      pattern = '*',
        command = [[if &ft == 'defx' | silent call defx#call_action('add_session') | endif]],
    })
  end

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
  vim.fn.execute([[command! -nargs=0 DefxOpen lua require('mod.defx')]] ..
                   [[.open_and_size {open = true, resize = true, refocus = false}]])
  vim.api.nvim_set_keymap('n', '<Leader>d', '<CMD>DefxOpen<CR>', {
    silent = true,
    noremap = true,
  })
end

return M
