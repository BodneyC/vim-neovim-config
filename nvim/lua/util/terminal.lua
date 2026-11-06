local M = {}

local HORIZONTAL, VERTICAL = 0, 1

local state = {
  direction = HORIZONTAL,
  buf = nil, ---@type integer?
  height = 0,
  width = 0,
}

local group = vim.api.nvim_create_augroup('config_terminal', { clear = true })

local function find_visible_term()
  for _, info in ipairs(vim.fn.getbufinfo({ bufloaded = 1 })) do
    if info.name:match('^term://') and info.hidden == 0 then
      return info.bufnr
    end
  end
end

local function close_on_exit(buf)
  vim.api.nvim_clear_autocmds({ group = group, event = 'TermClose', buffer = buf })
  vim.api.nvim_create_autocmd('TermClose', {
    group = group,
    buffer = buf,
    once = true,
    callback = function()
      vim.schedule(function()
        for _, win in ipairs(vim.fn.win_findbuf(buf)) do
          pcall(vim.api.nvim_win_close, win, true)
        end
        if vim.api.nvim_buf_is_valid(buf) then
          pcall(vim.api.nvim_buf_delete, buf, { force = true })
        end
      end)
    end,
  })
end

local function split()
  vim.cmd(state.direction == VERTICAL and 'vsplit' or 'split')
end

local function flip()
  state.direction = state.direction == VERTICAL and HORIZONTAL or VERTICAL
end

local function startinsert()
  vim.defer_fn(function()
    vim.cmd.startinsert()
  end, 100)
end

---@param direction? integer
function M.set_direction(direction)
  state.height = math.floor(vim.o.lines * 0.3)
  state.width = math.floor(vim.o.columns * 0.4)
  if direction then
    state.direction = direction
    return
  end
  local width, height = vim.fn.winwidth(0), vim.fn.winheight(0)
  state.direction = (width / 2 >= 80 and height * 3.2 <= width) and VERTICAL or HORIZONTAL
end

---@param toggle boolean
function M.split(toggle)
  M.set_direction()
  if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
    state.buf = find_visible_term()
  end

  local win = state.buf and vim.fn.bufwinid(state.buf) or -1
  if win ~= -1 then
    if toggle then
      vim.api.nvim_win_close(win, false)
    else
      vim.api.nvim_set_current_win(win)
    end
    return
  end

  local dir = state.direction == VERTICAL and 'l' or 'j'
  local reuse = state.buf and vim.api.nvim_buf_is_loaded(state.buf)

  if not toggle then
    vim.cmd('10wincmd ' .. dir)
  end
  split()
  vim.cmd('wincmd ' .. (toggle and dir:upper() or dir))

  if state.direction == VERTICAL then
    vim.cmd('vertical resize ' .. state.width)
  else
    vim.cmd('resize ' .. state.height)
  end

  if reuse then
    vim.api.nvim_win_set_buf(0, state.buf)
  else
    vim.cmd.terminal()
  end

  state.buf = vim.api.nvim_get_current_buf()
  close_on_exit(state.buf)
  startinsert()
  flip()
end

function M.next_split()
  local win = state.buf and vim.api.nvim_buf_is_valid(state.buf) and vim.fn.bufwinid(state.buf) or -1
  if win == -1 then
    return M.split(true)
  end

  local origin = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(win)
  split()
  vim.cmd.terminal()
  close_on_exit(vim.api.nvim_get_current_buf())

  local new = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(origin)
  vim.api.nvim_set_current_win(new)
  startinsert()
  flip()
end

local function open_float()
  local ratio = tonumber(vim.g.floating_term_divisor) or 0.9
  local width = math.floor(vim.o.columns * ratio)
  local height = math.floor(vim.o.lines * ratio)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'wipe'
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    width = width,
    height = height,
    style = 'minimal',
    border = 'solid',
  })
  return buf
end

---@param cmd? string
function M.float(cmd)
  local origin = vim.api.nvim_get_current_win()
  local buf = open_float()
  vim.keymap.set('n', '<Esc>', '<Cmd>bwipeout!<CR>', { buffer = buf, silent = true })
  vim.fn.jobstart(cmd or vim.o.shell, {
    term = true,
    on_exit = function(_, code)
      if code == 0 and vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
      if vim.api.nvim_win_is_valid(origin) then
        vim.api.nvim_set_current_win(origin)
      end
    end,
  })
end

---@param topic string
function M.help(topic)
  local origin = vim.api.nvim_get_current_win()
  open_float()
  vim.bo.filetype = 'help'
  vim.bo.buftype = 'help'

  local ok, err = pcall(vim.cmd, 'help ' .. topic)
  if not ok then
    vim.api.nvim_win_close(0, true)
    vim.api.nvim_set_current_win(origin)
    vim.notify(err --[[@as string]], vim.log.levels.ERROR)
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  vim.keymap.set('n', '<Esc>', '<Cmd>bwipeout<CR>', { buffer = buf, silent = true })
  vim.keymap.set('n', '<leader>q', '<Cmd>bwipeout<CR>', { buffer = buf, silent = true, desc = 'Quit' })
end

function M.setup()
  M.set_direction()

  local command = vim.api.nvim_create_user_command
  command('SetTerminalDirection', function(ctx)
    local arg = ctx.args:lower()
    if arg == '' then
      M.set_direction()
    elseif arg:match('^v') or arg == tostring(VERTICAL) then
      M.set_direction(VERTICAL)
    else
      M.set_direction(HORIZONTAL)
    end
  end, {
    nargs = '?',
    complete = function()
      return { 'vertical', 'horizontal' }
    end
  })
  command('TermSplit', function(ctx)
    M.split(ctx.bang)
  end, { bang = true })
  command('M', function(ctx)
    M.float('man ' .. ctx.args)
    vim.cmd.startinsert()
  end, { nargs = '+', complete = 'shellcmd' })
  for _, name in ipairs({ 'H', 'Help' }) do
    command(name, function(ctx)
      M.help(ctx.args)
    end, { nargs = '?', complete = 'help' })
  end

  vim.keymap.set('n', "<leader>'", M.next_split, { desc = 'New terminal' })
  vim.keymap.set('t', '<C-r>', [['<C-\><C-n>"' . nr2char(getchar()) . 'pi']], { expr = true })
  vim.keymap.set('t', '<LeftRelease>', '<Nop>')

  vim.api.nvim_create_autocmd('TermOpen', {
    group = group,
    callback = function()
      vim.opt_local.winhighlight = 'Normal:NvimTreeNormal'
    end,
  })
  vim.api.nvim_create_autocmd({ 'TermOpen', 'TermEnter' }, {
    group = group,
    callback = function()
      vim.opt_local.spell = false
      vim.opt_local.signcolumn = 'no'
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.buflisted = false
    end,
  })
  vim.api.nvim_create_autocmd('TermEnter', {
    group = group,
    callback = function()
      if vim.fn.winnr('$') == 1 then
        vim.cmd.quit()
      end
    end,
  })
  vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    callback = function()
      if vim.bo.buftype == 'terminal' then
        vim.cmd.startinsert()
      end
    end,
  })
end

return M
