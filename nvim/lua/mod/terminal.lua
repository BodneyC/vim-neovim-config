local skm = vim.api.nvim_set_keymap
local bskm = vim.api.nvim_buf_set_keymap
local util = require('utl.util')

local plane = {
  HORZ = 0,
  VERT = 1,
}
local some_init_val = 'SOME_INIT_VALUE'

local M = {
  term_name = some_init_val,
  help_buf_nr = 0,
  term_height = -1,
  term_width = -1,
}

local function set_open_term_buffer_name()
  local blist = vim.fn.getbufinfo({
    bufloaded = 1,
    buflisted = 0,
  })
  for _, e in ipairs(blist) do
    if e.name ~= '' and not e.hidden then
      if string.match(e.name, '^term://.*') then
        M.term_name = e.name
        break
      end
    end
  end
end

function M.close_if_term_job()
  if vim.b.terminal_job_pid then
    local bufnr = vim.fn.bufnr()
    if not pcall(vim.cmd, 'close') then
      print('Could not close terminal')
    end
    if vim.fn.bufexists(bufnr) then
      vim.cmd('bd! ' .. bufnr)
    end
  end
end

local function split()
  if vim.g.term_direction == plane.VERT then
    vim.cmd('vsplit')
  elseif vim.g.term_direction == plane.HORZ then
    vim.cmd('split')
  else
    print('Invalid term_direction: ' .. vim.g.term_direction)
  end
end

local function flip()
  if vim.g.term_direction == plane.VERT then
    vim.g.term_direction = plane.HORZ
  else
    vim.g.term_direction = plane.VERT
  end
end

function M.next_term_split()
  local cur_win = vim.fn.bufwinnr('%')
  local winnr = vim.fn.bufwinnr(M.term_name)
  if winnr ~= -1 then
    vim.cmd(winnr .. 'wincmd w')
    split()
    vim.o.hidden = true
    vim.cmd('terminal')
    local new_win = vim.fn.bufwinnr('%')
    vim.cmd(
      'au! TermClose <buffer> lua require\'mod.terminal\'.close_if_term_job()')
    vim.cmd(cur_win .. 'wincmd w')
    vim.cmd(new_win .. 'wincmd w')
    vim.cmd('startinsert')
    flip()
  else
    M.term_split(1)
  end
end

function M.term_split(b)
  M.set_terminal_direction()
  if M.term_name == some_init_val then
    set_open_term_buffer_name()
  end
  local winnr = vim.fn.bufwinnr(M.term_name)
  local dir_char = 'j'
  if vim.g.term_direction == plane.VERT then
    dir_char = 'l'
  end

  if winnr ~= -1 then
    vim.cmd(winnr .. 'wincmd ' .. (b and 'q' or 'w'))
    return
  end

  local bufnr = vim.fn.bufnr(M.term_name)
  local term_exists = bufnr ~= -1 and vim.fn.bufexists(bufnr) and
                        vim.fn.bufloaded(bufnr)

  if not b then
    vim.cmd('10 wincmd ' .. dir_char)
  end
  split()
  if not b then
    vim.cmd('wincmd ' .. dir_char)
  end

  vim.o.hidden = true

  if b then
    vim.cmd('wincmd ' .. string.upper(dir_char))
  end

  if vim.g.term_direction == plane.VERT then
    vim.cmd('vertical resize ' .. M.term_width)
  else
    vim.cmd('resize ' .. M.term_height)
  end

  if term_exists then
    vim.cmd('b ' .. bufnr)
  else
    vim.cmd('terminal')
  end

  M.term_name = vim.fn.bufname('%')
  vim.cmd(
    'au! TermClose <buffer> lua require\'mod.terminal\'.close_if_term_job()')

  vim.cmd('startinsert')

  flip()
end

function M.floating_centred(...)
  local args = {...}
  local height_divisor = args[1] or vim.g.floating_term_divisor
  local width_divisor = args[2] or vim.g.floating_term_divisor
  local height = math.floor(vim.o.lines * height_divisor)
  local width = math.floor(vim.o.columns * width_divisor)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  local opts = {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = 'rounded',
  }
  local cur_float_win = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(cur_float_win, true, opts)
  return cur_float_win
end

local function on_term_exit(_, code, _)
  if code == 0 then
    vim.cmd('bd!')
  end
end

function M.floating_term(...)
  local args = {...}
  bskm(M.floating_centred(), 'n', '<Esc>', ':bw!<CR>', {})
  vim.fn.termopen(args[1] or os.getenv('SHELL'), {
    on_exit = on_term_exit,
  })
end

function M.floating_man(...)
  local args = {...}
  local winid = vim.fn.bufwinnr(vim.fn.bufnr())
  M.floating_term('man ' .. table.concat(args, ' '))
  vim.cmd(winid .. 'wincmd w')
end

function M.floating_help(...)
  local args = {...}
  local winid = vim.fn.bufwinnr(vim.fn.bufnr())
  if M.help_buf_nr > 0 and vim.fn.bufloaded(vim.g.tmp_help_buf) == 1 then
    vim.cmd('bw! ' .. M.help_buf_nr)
    M.help_buf_nr = -1
  end
  local query = args[1] or ''
  M.help_buf_nr = M.floating_centred()
  vim.bo.ft = 'help'
  vim.bo.bt = 'help'
  if not pcall(vim.cmd, 'help ' .. query) then
    vim.cmd('bw ' .. M.help_buf_nr)
    print('"' .. query .. '" not in helptags')
    vim.cmd(winid .. 'wincmd w')
    return
  end
  bskm(M.help_buf_nr, 'n', '<Esc>', ':bw<CR>', {})
  bskm(M.help_buf_nr, 'n', '<leader>q', ':bw<CR>', {})
end

function M.set_terminal_direction(...)
  M.term_height = math.floor(vim.o.lines * 0.3)
  M.term_width = math.floor(vim.o.columns * 0.4)
  local args = {...}
  if args[1] then
    vim.g.term_direction = args[1]
    return
  end
  if (vim.fn.winheight(0) * 3.2) > vim.fn.winwidth(0) then
    vim.g.term_direction = plane.HORZ
  else
    vim.g.term_direction = plane.VERT
  end
end

function M.setup_terms_from_session()
  M.term_name = vim.fn.expand('%') -- I know this will pick one at random... but they have no real order anyway...
  vim.cmd(
    'au! TermClose <buffer> lua require\'mod.terminal\'.close_if_term_job()')
end

function M.init()
  M.set_terminal_direction()
  vim.g.floating_term_divisor = vim.g.floating_term_divisor or '0.9'

  local n_s = {
    noremap = true,
    silent = true,
  }
  local mod_terminal = 'lua require\'mod.terminal\''

  -- commands
  -- `table.unpack` not in 5.1, use `unpack`
  util.command('SetTerminalDirection',
    mod_terminal .. '.set_terminal_direction(<f-args>)', {
      nargs = '?',
    })

  util.command('TermSplit', mod_terminal .. '.term_split(<bang>0)', {
    bang = true,
  })
  util.command('M', mod_terminal .. '.floating_man(<f-args>)', {
    nargs = '+',
    complete = 'shellcmd',
  })
  util.command('H', mod_terminal .. '.floating_help(<f-args>)', {
    nargs = '?',
    complete = 'help',
  })
  util.command('Help', mod_terminal .. '.floating_help(<f-args>)', {
    nargs = '?',
    complete = 'help',
  })

  -- mappings
  skm('n', '<Leader>\'', ':' .. mod_terminal .. '.next_term_split(false)<CR>',
    n_s)

  skm('t', '<C-R>', '\'<C-\\><C-N>"\' . nr2char(getchar()) . \'pi\'', {
    expr = true,
    unpack(n_s),
  })

  skm('n', '<F10>', ':' .. mod_terminal .. '.term_split(true)<CR>', n_s)
  skm('i', '<F10>', '<C-o>:' .. mod_terminal .. '.term_split(true)<CR>', n_s)
  skm('t', '<F10>', '<C-\\><C-n>:' .. mod_terminal .. '.term_split(true)<CR>',
    n_s)

  skm('i', '<C-q>', '<C-o>:' .. mod_terminal .. '.term_split(false)<CR>', n_s)
  skm('n', '<C-q>', ':' .. mod_terminal .. '.term_split(false)<CR>', n_s)
  skm('t', '<C-q>', '<C-\\><C-n>:wincmd p<CR>', n_s)
  skm('t', '<LeftRelease>', '<Nop>', n_s)

  -- __TERMINAL__
  util.augroup({
    name = '__TERMINAL__',
    autocmds = {
      {
        event = 'TermEnter,TermOpen,BufNew,BufEnter',
        glob = 'term://*',
        cmd = [[startinsert]],
      },
      {
        event = 'TermOpen',
        glob = 'term://*',
        cmd = [[nnoremap <buffer> <LeftRelease> <LeftRelease>i]],
      },
      {
        event = 'TermLeave,BufLeave',
        glob = 'term://*',
        cmd = [[stopinsert]],
      },
      {
        event = 'TermOpen,TermEnter',
        glob = '*',
        cmd = [[setlocal nospell signcolumn=no nobuflisted nonu nornu tw=0 wh=1]],
      },
      {
        event = 'SessionLoadPost',
        glob = 'term://*',
        cmd = [[lua require('mod.terminal').setup_terms_from_session()]],
      },
      {
        event = 'TermEnter',
        glob = 'term://*',
        cmd = [[if winnr('$') == 1 | q | endif]],
      },
    },
  })
end

return M
