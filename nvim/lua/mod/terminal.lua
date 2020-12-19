local vim = vim
local skm = vim.api.nvim_set_keymap
local bskm = vim.api.nvim_buf_set_keymap
local util = require 'utl.util'

local some_init_val = 'SOME_INIT_VALUE'

local M = {}

local function set_open_term_buffer_name()
  local blist = vim.fn.getbufinfo({bufloaded = 1, buflisted = 0})
  for _, e in ipairs(blist) do
    if e.name ~= '' and not e.hidden then
      if string.match(e.name, '^term://.*') then
        vim.g.tmp_term_name = e.name
        break
      end
    end
  end
end

function M.close_if_term_job()
  if vim.b.terminal_job_pid then
    if not pcall(util.exec, 'close') then print('Could not close terminal') end
  end
end

function M.next_term_split()
  -- M.set_terminal_direction()
  local cur_win = vim.fn.bufwinnr('%')
  local winnr = vim.fn.bufwinnr(vim.g.tmp_term_name)
  if winnr ~= -1 then
    util.exec(winnr .. 'wincmd w')
    if vim.g.term_direction == 'horz' then
      util.exec('split')
    else
      util.exec('vsplit')
    end
    vim.o.hidden = true
    util.exec('terminal')
    local new_win = vim.fn.bufwinnr('%')
    util.exec('au! TermClose <buffer> lua require\'mod.terminal\'.close_if_term_job()')
    util.exec(cur_win .. 'wincmd w')
    util.exec(new_win .. 'wincmd w')
    util.exec('startinsert')
  else
    M.term_split(1)
  end
end

function M.term_split(b)
  M.set_terminal_direction()
  if vim.g.tmp_term_name == some_init_val then set_open_term_buffer_name() end
  local ttn = vim.g.tmp_term_name
  local winnr = vim.fn.bufwinnr(ttn)
  local dir_char = 'j'
  if vim.g.term_direction == 'horz' then dir_char = 'l' end
  if winnr ~= -1 then
    util.exec(winnr .. 'wincmd ' .. (b and 'q' or 'w'))
  else
    local bufnr = vim.fn.bufnr(ttn)
    if bufnr ~= -1 and vim.fn.bufexists(bufnr) and vim.fn.bufloaded(bufnr) then
      util.exec('bd!' .. bufnr)
    end
    if b then
      if vim.g.term_direction == 'horz' then
        util.exec('vsplit')
      else
        util.exec('split')
      end
    else
      util.exec(string.format([[
        10 wincmd %s
        vsplit
        wincmd %s
      ]], dir_char, dir_char))
    end
    vim.o.hidden = true
    if b then util.exec('wincmd ' .. string.upper(dir_char)) end
    util.exec('terminal')
    if vim.g.term_direction == 'horz' then
      util.exec('vertical resize ' .. vim.g.term_width)
    else
      util.exec('resize ' .. vim.g.term_height)
    end
    vim.g.tmp_term_name = vim.fn.bufname('%')
    util.exec('au! TermClose <buffer> lua require\'mod.terminal\'.close_if_term_job()')
    util.exec('startinsert')
  end
end

function M.border_box(h, w, c, r)
  local bar = string.rep('─', w)
  local top = '╭' .. bar .. '╮'
  local mid = '│' .. string.rep(' ', w) .. '│'
  local bot = '╰' .. bar .. '╯'
  local lines = {top}
  for _ = 1, h do table.insert(lines, mid) end
  table.insert(lines, bot)
  local buf = vim.fn.nvim_create_buf(false, true)
  vim.fn.nvim_buf_set_lines(buf, 0, -1, true, lines)
  local opts = {
    relative = 'editor',
    row = r - 1,
    col = c - 1,
    width = w + 2,
    height = h + 2,
    style = 'minimal',
  }
  vim.fn.nvim_open_win(buf, true, opts)
  vim.g.tmp_border_buf = buf
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
  local cur_float_win = vim.fn.nvim_create_buf(false, true)
  vim.fn.nvim_open_win(cur_float_win, true, opts)
  util.augroup(string.format([[
    augroup __FLOAT__
      au!
      au BufWipeout <buffer=%d> bd! %d
    augroup END
  ]], cur_float_win, buf))
  return cur_float_win
end

local function on_term_exit(_, code, _)
  if code == 0 then util.exec('bd!') end
end

function M.floating_term(...)
  local args = {...}
  bskm(M.floating_centred(), 'n', '<Esc>', ':bw!<CR>', {})
  vim.fn.termopen(args[1] or os.getenv('SHELL'), {on_exit = on_term_exit})
end

function M.floating_man(...)
  local args = {...}
  M.floating_term('man ' .. table.concat(args, ' '))
end

function M.floating_help(...)
  local args = {...}
  if vim.g.tmp_help_buf > 0 and vim.fn.bufloaded(vim.g.tmp_help_buf) == 1 then
    util.exec('bw! ' .. vim.g.tmp_help_buf)
    vim.g.tmp_help_buf = -1
  end
  local query = args[1] or ''
  vim.g.tmp_help_buf = M.floating_centred()
  util.augroup([[
    augroup __FLOAT__
      au!
    augroup END
  ]])
  vim.bo.ft = 'help'
  vim.bo.bt = 'help'
  if not pcall(util.exec, 'help ' .. query) then
    util.exec('bw ' .. vim.g.tmp_help_buf)
    util.exec('bw ' .. vim.g.tmp_border_buf)
    error('"' .. query .. '" not in helptags')
  else
    bskm(vim.g.tmp_help_buf, 'n', '<Esc>', ':bw<CR>', {})
    bskm(vim.g.tmp_help_buf, 'n', '<leader>q', ':bw<CR>', {})
    util.augroup(string.format([[
      augroup __FLOAT__
        au BufWipeout <buffer=%s> bd! %s
      augroup END
    ]], vim.g.tmp_help_buf, vim.g.tmp_border_buf))
  end
end

function M.set_terminal_direction(...)
  vim.g.term_height = vim.g.term_height or math.floor(vim.o.lines * 0.3)
  vim.g.term_width = vim.g.term_width or math.floor(vim.o.columns * 0.4)
  local args = {...}
  if args[1] then
    vim.g.term_direction = args[1]
    return
  end
  local winnr = vim.fn.winnr('$')
  if (vim.fn.winheight(winnr) * 3.2) > vim.fn.winwidth(winnr) then
    vim.g.term_direction = 'vert'
  else
    vim.g.term_direction = 'horz'
  end
end

function M.setup_terms_from_session()
  vim.g.tmp_term_name = vim.fn.expand('%') -- I know this will pick one at random... but they have no real order anyway...
  util.exec('au! TermClose <buffer> lua require\'mod.terminal\'.close_if_term_job()')
end

function M.init()
  M.set_terminal_direction()
  vim.g.floating_term_divisor = vim.g.floating_term_divisor or '0.9'
  vim.g.tmp_term_name = some_init_val
  vim.g.tmp_border_buf = -1
  vim.g.tmp_help_buf = 0

  local n_s = {noremap = true, silent = true}
  local mod_terminal = 'lua require\'mod.terminal\''

  -- `table.unpack` not in 5.1, use `unpack`
  util.command('SetTerminalDirection', mod_terminal .. '.set_terminal_direction(<f-args>)',
      {nargs = '?'})

  util.command('TermSplit', mod_terminal .. '.term_split(<bang>0)', {bang = true})
  util.command('M', mod_terminal .. '.floating_man(<f-args>)', {nargs = '+', complete = 'shellcmd'})
  util.command('H', mod_terminal .. '.floating_help(<f-args>)', {nargs = '?', complete = 'help'})
  util.command('Help', mod_terminal .. '.floating_help(<f-args>)', {nargs = '?', complete = 'help'})

  skm('n', '<Leader>\'', ':' .. mod_terminal .. '.next_term_split(false)<CR>', n_s)

  skm('t', '<C-R>', '\'<C-\\><C-N>"\' . nr2char(getchar()) . \'pi\'', {expr = true, unpack(n_s)})

  skm('n', '<F10>', ':' .. mod_terminal .. '.term_split(true)<CR>', n_s)
  skm('i', '<F10>', '<C-o>:' .. mod_terminal .. '.term_split(true)<CR>', n_s)
  skm('t', '<F10>', '<C-\\><C-n>:' .. mod_terminal .. '.term_split(true)<CR>', n_s)

  skm('i', '<C-q>', '<C-o>:' .. mod_terminal .. '.term_split(false)<CR>', n_s)
  skm('n', '<C-q>', ':' .. mod_terminal .. '.term_split(false)<CR>', n_s)
  skm('t', '<C-q>', '<C-\\><C-n>:wincmd p<CR>', n_s)
  skm('t', '<LeftRelease>', '<Nop>', n_s)

  util.augroup([[
    augroup __TERMINAL__
      au!
      au TermEnter,TermOpen,BufNew,BufEnter term://* startinsert
      " au TermEnter term://* if winnr('$') == 1 | q | endif
      au TermOpen term://* nnoremap <buffer> <LeftRelease> <LeftRelease>i
      au TermLeave,BufLeave term://* stopinsert
      au TermOpen,TermEnter * setlocal nospell signcolumn=no nobuflisted nonu nornu tw=0 wh=1
        " winhl=Normal:CursorLine,EndOfBuffer:EndOfBufferWinHl
      au SessionLoadPost term://* lua require'mod.terminal'.setup_terms_from_session()
    augroup END
  ]])

end

return M
