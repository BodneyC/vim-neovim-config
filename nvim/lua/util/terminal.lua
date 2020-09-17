local vim = vim
local skm = vim.api.nvim_set_keymap
local bskm = vim.api.nvim_buf_set_keymap
local cfg = require'util.cfg'

local M = {}

local function get_open_term_buffer_name()
  local blist = vim.fn.getbufinfo({ bufloaded = 1, buflisted = 0 })
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
    if not pcall(cfg.exec, 'close') then
      print('Could not close terminal')
    end
  end
end

function M.next_term_split(b)
  local cur_win = vim.fn.bufwinnr('%')
  local winnr = vim.fn.bufwinnr(vim.g.tmp_term_name)
  if winnr ~= -1 then
    cfg.exec(winnr .. 'wincmd w')
    cfg.exec('vsplit')
    vim.o.hidden = true
    cfg.exec('terminal')
    local new_win = vim.fn.bufwinnr('%')
    if b then
      cfg.exec('wincmd =')
      cfg.exec('resize' .. vim.g.term_height)
    end
    cfg.exec("au! TermClose <buffer> lua require'util.terminal'.close_if_term_job()")
    cfg.exec(cur_win .. 'wincmd w')
    cfg.exec(new_win .. 'wincmd w')
    cfg.exec('startinsert')
  else
    M.term_split(1)
  end
end

function M.term_split(b)
  if vim.g.tmp_term_name == "SOME INIT VALUE" then
    get_open_term_buffer_name()
  end
  local ttn = vim.g.tmp_term_name
  local winnr = vim.fn.bufwinnr(ttn)
  if winnr ~= -1 then
    cfg.exec(winnr .. 'wincmd ' .. (b and 'q' or 'w'))
  else
    local bufnr = vim.fn.bufnr(ttn)
    if bufnr ~= -1 and vim.fn.bufexists(bufnr) and vim.fn.bufloaded(bufnr) then
      cfg.exec('bd!' .. bufnr)
    end
    if b then
      cfg.exec('vsplit')
    else
      cfg.exec([[
        10 wincmd j
        split
        wincmd j
      ]])
    end
    vim.o.hidden = true
    if b then cfg.exec('wincmd J') end
    cfg.exec('terminal')
    cfg.exec('resize ' .. vim.g.term_height)
    vim.g.tmp_term_name = vim.fn.bufname('%')
    cfg.exec("au! TermClose <buffer> lua require'util.terminal'.close_if_term_job()")
    cfg.exec('startinsert')
  end
end

function M.border_box(h, w, c, r)
  local bar = string.rep('─', w)
  local top = '╭' .. bar .. '╮'
  local mid = '│' .. string.rep(' ', w) .. '│'
  local bot = '╰' .. bar .. '╯'
  local lines = { top }
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
    style = 'minimal'
  }
  vim.fn.nvim_open_win(buf, true, opts)
  vim.g.tmp_border_buf = buf
  return buf
end

function M.floating_centred(...)
  local args = { ... }
  local height_divisor = args[1] or vim.g.floating_term_divisor
  local width_divisor = args[2] or vim.g.floating_term_divisor
  local height = math.floor(vim.o.lines * height_divisor)
  local width  = math.floor(vim.o.columns * width_divisor)
  local col    = math.floor((vim.o.columns - width) / 2)
  local row    = math.floor((vim.o.lines - height) / 2)
  local buf = M.border_box(height, width, col, row)
  local opts = {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal'
  }
  local cur_float_win = vim.fn.nvim_create_buf(false, true)
  vim.fn.nvim_open_win(cur_float_win, true, opts)
  cfg.augroup([[
    augroup __FLOAT__
      au!
      au BufWipeout <buffer=]] .. cur_float_win .. [[> bd! ]] .. buf .. [[

    augroup END
  ]])
  vim.o.winhl = 'Normal:NormalFloat'
  return cur_float_win
end

local function on_term_exit(_, code, _)
  if code == 0 then cfg.exec('bd!') end
end

function M.floating_term(...)
  local args = { ... }
  bskm(M.floating_centred(), 'n', '<Esc>', ':bw!<CR>', {})
  vim.fn.termopen(args[1] or os.getenv('SHELL'), { on_exit = on_term_exit })
end

function M.floating_man(...)
  local args = { ... }
  M.floating_term('man ' .. table.concat(args, ' '))
end

function M.floating_help(...)
  local args = { ... }
  if vim.g.tmp_help_buf > 0 and vim.fn.bufloaded(vim.g.tmp_help_buf) == 1 then
    cfg.exec('bw! ' .. vim.g.tmp_help_buf)
    vim.g.tmp_help_buf = -1
  end
  local query = args[1] or ''
  vim.g.tmp_help_buf = M.floating_centred()
  cfg.augroup([[
    augroup __FLOAT__
      au!
    augroup END
  ]])
  vim.bo.ft = 'help'
  vim.bo.bt = 'help'
  if not pcall(cfg.exec, 'help ' .. query) then
    cfg.exec('bw ' .. vim.g.tmp_help_buf)
    cfg.exec('bw ' .. vim.g.tmp_border_buf)
    error('"' .. query .. '" not in helptags')
  else
    bskm(vim.g.tmp_help_buf, 'n', '<Esc>', ':bw<CR>', {})
    cfg.augroup([[
      augroup __FLOAT__
        au BufWipeout <buffer=]] .. vim.g.tmp_help_buf ..
          [[> bd! ]] .. vim.g.tmp_border_buf .. [[

      augroup END
    ]])
  end
end

function M.init()
  vim.g.term_height = vim.g.term_height or 12
  vim.g.floating_term_divisor = '0.9'
  vim.g.tmp_term_name = 'SOME INIT VALUE'
  vim.g.tmp_border_buf = -1
  vim.g.tmp_help_buf = 0

  cfg.command('TermSplit', "lua require'util.terminal'.term_split(<bang>0)", { bang = true })
  cfg.command('M', "lua require'util.terminal'.floating_man(<f-args>)", { nargs = '+', complete = 'shellcmd' })
  cfg.command('H', "lua require'util.terminal'.floating_help(<f-args>)", { nargs = '?', complete = 'help' })
  cfg.command('Help', "lua require'util.terminal'.floating_help(<f-args>)", { nargs = '?', complete = 'help' })

  skm('n', "<Leader>'", ":lua require'util.terminal'.next_term_split(false)<CR>",
    { silent = true, noremap = true })

  skm('t', '<C-R>', '<C-\\><C-N>""pi', { expr = true, silent = true, noremap = true })

  skm('n', '<F10>', ":lua require'util.terminal'.term_split(true)<CR>", { silent = true, noremap = true })
  skm('i', '<F10>', "<C-o>:lua require'util.terminal'.term_split(true)<CR>", { silent = true, noremap = true })
  skm('t', '<F10>', "<C-\\><C-n>:lua require'util.terminal'.term_split(true)<CR>", { silent = true, noremap = true })

  skm('n', '<C-q>', ":lua require'util.terminal'.term_split(false)<CR>", { silent = true, noremap = true })
  skm('t', '<C-q>', '<C-\\><C-n>:wincmd p<CR>', { silent = true, noremap = true })
  skm('t', '<LeftRelease>', '<Nop>', { silent = true, noremap = true })

  skm('t', '<M-h>', '<C-\\><C-n>:TmuxNavigateLeft<CR>', { silent = true, noremap = true })
  skm('t', '<M-j>', '<C-\\><C-n>:TmuxNavigateDown<CR>', { silent = true, noremap = true })
  skm('t', '<M-k>', '<C-\\><C-n>:TmuxNavigateUp<CR>', { silent = true, noremap = true })
  skm('t', '<M-l>', '<C-\\><C-n>:TmuxNavigateRight<CR>', { silent = true, noremap = true })
  skm('t', '<M-\\>', '<C-\\><C-n>:TmuxNavigatePrevious<CR>', { silent = true, noremap = true })

  cfg.augroup([[
    augroup __TERMINAL__
      au!
      au TermEnter,TermOpen,BufNew,BufEnter term://* startinsert
      au TermLeave,BufLeave term://* stopinsert
      au TermOpen,TermEnter * setlocal nospell signcolumn=no nobuflisted nonu nornu tw=0 wh=1 winhl=Normal:CursorLine,EndOfBuffer:EndOfBufferWinHl
    augroup END
  ]])

end

return M
