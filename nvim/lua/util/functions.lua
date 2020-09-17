local vim = vim
local cfg = require'util.cfg'

local M = {}

function M.set_indent(n)
  vim.bo.ts = n
  vim.bo.sw = n
  if vim.fn.exists(":IndentLinesReset") then
    cfg.exec('IndentLinesReset')
  end
end

function M.change_indent(n)
  cfg.toggle_bool_option('bo', 'et')
  cfg.exec('%retab!')
  vim.bo.ts = n
  cfg.toggle_bool_option('bo', 'et')
  cfg.exec('%retab!')
  M.set_indent(n)
end

function M.spell_checker()
  local spell_pre = vim.wo.spell
  if not spell_pre then
    vim.wo.spell = true
  end
  cfg.exec('normal! mzgg]S')
  while vim.fn.spellbadword()[0] ~= '' do
    local cnt = 0
    cfg.exec('redraw')
    local ch = ''
    while cfg.elem_in_array({ 'y', 'n', 'f', 'r', 'a', 'q' }, ch) == -1 do
      if cnt > 0 then print('Incorrect input') end
      cnt = cnt + 1
      print('Word: ' ..  vim.fn.expand('<cword>') ..
        ' ([y]es/[n]o/[f]irst/[r]epeat/[a]dd/[q]uit) ')
      ch = io.read(1)
      cfg.exec('redraw')
    end
    local dic = {
      n = '',
      y = [[
        normal! z=
        normal! ]] .. vim.fn.input('Make your selection: ') .. [[z=
      ]],
      r = 'spellrepall',
      f = 'normal! 1z=',
      a = 'normal! zG',
    }
    if dic[ch] then
      cfg.exec(dic[ch])
    end
    cfg.exec('normal! ]S')
  end
  cfg.exec('normal! `z')
  if not spell_pre then
    vim.wo.spell = false
  end
  print('Spell checker complete')
end

function M.match_over(...)
  local args = { ... }
  print(vim.inspect(args))
  if #args > 1 or (args[1] and not tonumber(args[1])) then
    error('More than one argument')
  end
  local w = vim.g.match_over_width or 80
  if args[1] then w = args[1] end
  cfg.exec('match OverLength /\\%' .. w .. 'v.\\+/')
end

function M.zoom_toggle()
  if vim.t.zoomed and vim.t.zoom_winrestcmd then
    cfg.exec(vim.t.zoom_winrestcmd)
    vim.t.zoomed = false
  else
    vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
    cfg.exec('resize | vertical resize')
    vim.t.zoomed = true
  end
end

function M.highlight_under_cursor()
  local hl_groups = {}
  for _, e in ipairs(vim.fn.synstack(vim.fn.col('.'), vim.fn.line('.'))) do
    table.insert(hl_groups, vim.fn.synIDattr(e, 'name'))
  end
  print(vim.inspect(hl_groups))
end

function M.handle_large_file()
  if cfg.fsize(vim.fn.expand("<afile>")) > vim.g.large_file then
    vim.o.eventignore = vim.o.eventignore .. ',FileType'
    vim.o.swapfile = false
    vim.bo.bufhidden = true
    vim.bo.buftype = 'nowrite'
    vim.wo.undolevels = 1
    vim.o.completeopt = ''
    vim.o.wrap = false
    if vim.fn.exists(':AirlineToggle') then
      cfg.exec('AirlineToggle')
    end
  end
end

return M
