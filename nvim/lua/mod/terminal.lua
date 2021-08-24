local skm = vim.api.nvim_set_keymap
local bskm = vim.api.nvim_buf_set_keymap
local util = require ('utl.util')

local plane = {HORIZTONAL = 0, VERTICAL = 1}
local some_init_val = 'SOME_INIT_VALUE'

local M = {}

local function set_open_term_buffer_name()
  local blist = vim.fn.getbufinfo({bufloaded = 1, buflisted = 0})
  for _, e in ipairs(blist) do
    if e.name ~= '' and not e.hidden then
      if string.match(e.name, '^term://.*') then
        __MOD_TERM_TMP_TERM_NAME = e.name
        break
      end
    end
  end
end

function M.close_if_term_job()
  if vim.b.terminal_job_pid then
    if not pcall(vim.cmd, 'close') then
      print('Could not close terminal')
    end
  end
end

local function split()
  if vim.g.term_direction == plane.VERTICAL then
    vim.cmd('vsplit')
  elseif vim.g.term_direction == plane.HORIZTONAL then
    vim.cmd('split')
  else
    print('Invalid term_direction: ' .. vim.g.term_direction)
  end
end

local function flip()
  if vim.g.term_direction == plane.VERTICAL then
    vim.g.term_direction = plane.HORIZTONAL
  else
    vim.g.term_direction = plane.VERTICAL
  end
end

function M.next_term_split()
  local cur_win = vim.fn.bufwinnr('%')
  local winnr = vim.fn.bufwinnr(__MOD_TERM_TMP_TERM_NAME)
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
  if __MOD_TERM_TMP_TERM_NAME == some_init_val then
    set_open_term_buffer_name()
  end
  local winnr = vim.fn.bufwinnr(__MOD_TERM_TMP_TERM_NAME)
  local dir_char = 'j'
  if vim.g.term_direction == plane.VERTICAL then
    dir_char = 'l'
  end

  if winnr ~= -1 then
    vim.cmd(winnr .. 'wincmd ' .. (b and 'q' or 'w'))
    return
  end

  local bufnr = vim.fn.bufnr(__MOD_TERM_TMP_TERM_NAME)
  if bufnr ~= -1 and vim.fn.bufexists(bufnr) and vim.fn.bufloaded(bufnr) then
    vim.cmd('bd!' .. bufnr)
  end

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
  vim.cmd('terminal')

  if vim.g.term_direction == plane.VERTICAL then
    vim.cmd('vertical resize ' .. vim.g.term_width)
  else
    vim.cmd('resize ' .. vim.g.term_height)
  end

  __MOD_TERM_TMP_TERM_NAME = vim.fn.bufname('%')
  vim.cmd(
    'au! TermClose <buffer> lua require\'mod.terminal\'.close_if_term_job()')
  vim.cmd('startinsert')

  flip()
end

function M.border_box(h, w, c, r)
  local bar = string.rep('─', w)
  local top = '╭' .. bar .. '╮'
  local mid = '│' .. string.rep(' ', w) .. '│'
  local bot = '╰' .. bar .. '╯'
  local lines = {top}
  for _ = 1, h do
    table.insert(lines, mid)
  end
  table.insert(lines, bot)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
  local opts = {
    relative = 'editor',
    row = r - 1,
    col = c - 1,
    width = w + 2,
    height = h + 2,
    style = 'minimal',
  }
  vim.api.nvim_open_win(buf, true, opts)
  __MOD_TERM_TMP_BORDER_BUF = buf
  return buf
end

function M.floating_centred(...)
  local args = {...}
  local height_divisor = args[1] or vim.g.floating_term_divisor
  local width_divisor = args[2] or vim.g.floating_term_divisor
  local height = math.floor(vim.o.lines * height_divisor)
  local width = math.floor(vim.o.columns * width_divisor)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  local buf = M.border_box(height, width, col, row)
  local opts = {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
  }
  local cur_float_win = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(cur_float_win, true, opts)
  util.augroup({
    name = '__FLOAT__',
    autocmds = {
      {
        event = 'BufWipeout',
        glob = '<buffer=' .. cur_float_win .. '>',
        cmd = 'bd!' .. buf,
      },
    },
  })
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
  vim.fn.termopen(args[1] or os.getenv('SHELL'), {on_exit = on_term_exit})
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
  if __MOD_TERM_TMP_HELP_BUF > 0 and vim.fn.bufloaded(vim.g.tmp_help_buf) == 1 then
    vim.cmd('bw! ' .. __MOD_TERM_TMP_HELP_BUF)
    __MOD_TERM_TMP_HELP_BUF = -1
  end
  local query = args[1] or ''
  __MOD_TERM_TMP_HELP_BUF = M.floating_centred()
  util.augroup({name = '__FLOAT__', autocmds = {}})
  vim.bo.ft = 'help'
  vim.bo.bt = 'help'
  if not pcall(vim.cmd, 'help ' .. query) then
    vim.cmd('bw ' .. __MOD_TERM_TMP_HELP_BUF)
    vim.cmd('bw ' .. __MOD_TERM_TMP_BORDER_BUF)
    print('"' .. query .. '" not in helptags')
    vim.cmd(winid .. 'wincmd w')
    return
  end
  bskm(__MOD_TERM_TMP_HELP_BUF, 'n', '<Esc>', ':bw<CR>', {})
  bskm(__MOD_TERM_TMP_HELP_BUF, 'n', '<leader>q', ':bw<CR>', {})
  util.augroup({
    name = '__FLOAT__',
    autocmds = {
      {
        event = 'BufWipeout',
        glob = '<buffer=' .. __MOD_TERM_TMP_HELP_BUF .. '>',
        cmd = 'bd! ' .. __MOD_TERM_TMP_BORDER_BUF,
      },
    },
  })
end

function M.set_terminal_direction(...)
  vim.g.term_height = math.floor(vim.o.lines * 0.3)
  vim.g.term_width = math.floor(vim.o.columns * 0.4)
  local args = {...}
  if args[1] then
    vim.g.term_direction = args[1]
    return
  end
  if (vim.fn.winheight(0) * 3.2) > vim.fn.winwidth(0) then
    vim.g.term_direction = plane.HORIZTONAL
  else
    vim.g.term_direction = plane.VERTICAL
  end
end

function M.setup_terms_from_session()
  __MOD_TERM_TMP_TERM_NAME = vim.fn.expand('%') -- I know this will pick one at random... but they have no real order anyway...
  vim.cmd(
    'au! TermClose <buffer> lua require\'mod.terminal\'.close_if_term_job()')
end

function M.init()
  M.set_terminal_direction()
  vim.g.floating_term_divisor = vim.g.floating_term_divisor or '0.9'
  __MOD_TERM_TMP_TERM_NAME = some_init_val
  __MOD_TERM_TMP_BORDER_BUF = -1
  __MOD_TERM_TMP_HELP_BUF = 0

  local n_s = {noremap = true, silent = true}
  local mod_terminal = 'lua require\'mod.terminal\''

  -- commands
  -- `table.unpack` not in 5.1, use `unpack`
  util.command('SetTerminalDirection',
    mod_terminal .. '.set_terminal_direction(<f-args>)', {nargs = '?'})

  util.command('TermSplit', mod_terminal .. '.term_split(<bang>0)',
    {bang = true})
  util.command('M', mod_terminal .. '.floating_man(<f-args>)',
    {nargs = '+', complete = 'shellcmd'})
  util.command('H', mod_terminal .. '.floating_help(<f-args>)',
    {nargs = '?', complete = 'help'})
  util.command('Help', mod_terminal .. '.floating_help(<f-args>)',
    {nargs = '?', complete = 'help'})

  -- mappings
  skm('n', '<Leader>\'', ':' .. mod_terminal .. '.next_term_split(false)<CR>',
    n_s)

  skm('t', '<C-R>', '\'<C-\\><C-N>"\' . nr2char(getchar()) . \'pi\'',
    {expr = true, unpack(n_s)})

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
      }, {
        event = 'TermOpen',
        glob = 'term://*',
        cmd = [[nnoremap <buffer> <LeftRelease> <LeftRelease>i]],
      },
      {event = 'TermLeave,BufLeave', glob = 'term://*', cmd = [[stopinsert]]},
      {
        event = 'TermOpen,TermEnter',
        glob = '*',
        cmd = [[setlocal nospell signcolumn=no nobuflisted nonu nornu tw=0 wh=1]],
      }, {
        event = 'SessionLoadPost',
        glob = 'term://*',
        cmd = [[lua require('mod.terminal').setup_terms_from_session()]],
      }, {
        event = 'TermEnter',
        glob = 'term://*',
        cmd = [[if winnr('$') == 1 | q | endif]],
      },
    },
  })
end

return M
