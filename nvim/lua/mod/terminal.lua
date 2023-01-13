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
    vim.defer_fn(function()
      vim.cmd('startinsert')
    end, 100)
    flip()
  else
    M.term_split(true)
  end
end

function M.term_split(toggle)
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
    vim.cmd(winnr .. 'wincmd ' .. (toggle and 'q' or 'w'))
    return
  end

  local bufnr = vim.fn.bufnr(M.term_name)
  local term_exists = bufnr ~= -1 and vim.fn.bufexists(bufnr) and
                        vim.fn.bufloaded(bufnr)

  if not toggle then
    vim.cmd('10 wincmd ' .. dir_char)
  end
  split()
  if not toggle then
    vim.cmd('wincmd ' .. dir_char)
  end

  vim.o.hidden = true

  if toggle then
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

  vim.defer_fn(function()
    vim.cmd('startinsert')
  end, 100)

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
    border = 'solid',
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
  local bufnr = M.floating_centred()
  bskm(bufnr, 'n', '<Esc>', ':bw!<CR>', {})
  vim.fn.termopen(args[1] or os.getenv('SHELL'), {
    on_exit = function(job_id, code, event)
      on_term_exit(job_id, code, event)
      if args[2] then
        vim.cmd(args[2] .. 'wincmd w')
      end
    end,
  })
end

function M.floating_man(...)
  local args = {...}
  local winid = vim.fn.bufwinnr(vim.fn.bufnr())
  M.floating_term('man ' .. table.concat(args, ' '), winid)
  vim.cmd([[startinsert]])
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
  local status, err = pcall(vim.cmd, 'help ' .. query)
  if not status then
    vim.cmd('bw ' .. M.help_buf_nr)
    print('"' .. query .. '" failed: ' .. err)
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
  local winwidth = vim.fn.winwidth(0)
  local winheight = vim.fn.winheight(0)
  -- 3.2 is a number that means something to someone... not me, though
  if winwidth / 2 >= 80 and (winheight * 3.2) <= winwidth then
    vim.g.term_direction = plane.VERT
  else
    vim.g.term_direction = plane.HORZ
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

  local ns = require('utl.maps').flags.ns
  local m_term = 'lua require\'mod.terminal\''

  -- `table.unpack` not in 5.1, use `unpack`
  util.commands({
    {
      name = 'SetTerminalDirection',
      cmd = m_term .. '.set_terminal_direction(<f-args>)',
      opts = {
        nargs = '?',
      },
    },
    {
      name = 'TermSplit',
      cmd = m_term .. '.term_split(<bang>0)',
      opts = {
        bang = true,
      },
    },
    {
      name = 'M',
      cmd = m_term .. '.floating_man(<f-args>)',
      opts = {
        nargs = '+',
        complete = 'shellcmd',
      },
    },
    {
      name = 'H',
      cmd = m_term .. '.floating_help(<f-args>)',
      opts = {
        nargs = '?',
        complete = 'help',
      },
    },
    {
      name = 'Help',
      cmd = m_term .. '.floating_help(<f-args>)',
      opts = {
        nargs = '?',
        complete = 'help',
      },
    },
  })

  skm('n', '<Leader>\'', ':' .. m_term .. '.next_term_split(false)<CR>', ns)

  skm('t', '<C-R>', '\'<C-\\><C-N>"\' . nr2char(getchar()) . \'pi\'', {
    expr = true,
    unpack(ns),
  })

  -- skm('n', '<C-S-q>', ':' .. m_term .. '.term_split(true)<CR>', ns)
  -- skm('i', '<C-S-q>', '<C-o>:' .. m_term .. '.term_split(true)<CR>', ns)
  -- skm('t', '<C-S-q>', '<C-\\><C-n>:' .. m_term .. '.term_split(true)<CR>', ns)

  -- skm('i', '<C-q>', '<C-o>:' .. m_term .. '.term_split(false)<CR>', ns)
  -- skm('n', '<C-q>', ':' .. m_term .. '.term_split(false)<CR>', ns)
  -- skm('t', '<C-q>', '<C-\\><C-n>:wincmd p<CR>', ns)

  skm('t', '<LeftRelease>', '<Nop>', ns)

  do
    local group = vim.api.nvim_create_augroup('__TERMINAL__', {
      clear = true,
    })
    vim.api.nvim_create_autocmd('TermOpen', {
      group = group,
      pattern = 'term://*',
      command = [[set winhighlight=Normal:NvimTreeNormal]],
    })
    vim.api.nvim_create_autocmd({'TermOpen', 'TermEnter'}, {
      group = group,
      pattern = '*',
      command = [[setlocal nospell signcolumn=no nonu nornu nobuflisted ]], -- tw=0 wh=1]],
    })
    vim.api.nvim_create_autocmd('TermEnter', {
      group = group,
      pattern = 'term://*',
      command = [[if winnr('$') == 1 | q | endif]],
    })
    --- Ignored for floaterm
    -- vim.api.nvim_create_autocmd({'TermEnter', 'TermOpen', 'BufNew', 'BufEnter'}, {
    --   group = group,
    --   pattern = 'term://*',
    --   command = [[startinsert]],
    -- })
    -- vim.api.nvim_create_autocmd('TermOpen', {
    --   group = group,
    --   pattern = 'term://*',
    --   command = [[nnoremap <buffer> <LeftRelease> <LeftRelease>i]],
    -- })
    -- vim.api.nvim_create_autocmd({'TermLeave', 'BufLeave'}, {
    --   group = group,
    --   pattern = 'term://*',
    --   command = [[stopinsert]],
    -- })
    -- vim.api.nvim_create_autocmd('SessionLoadPost', {
    --   group = group,
    --   pattern = 'term://*',
    --   callback = require('mod.terminal').setup_terms_from_session,
    -- })
  end
end

return M
