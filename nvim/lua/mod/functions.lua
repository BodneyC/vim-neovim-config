local vim = vim
local util = require'utl.util'
local fs = require'utl.fs'

local M = {}

function M.set_indent(n)
  vim.bo.ts = n
  vim.bo.sw = n
  if vim.fn.exists(":IndentLinesReset") then
    util.exec('IndentLinesReset')
  end
end

function M.change_indent(n)
  util.toggle_bool_option('bo', 'et')
  util.exec('%retab!')
  vim.bo.ts = n
  util.toggle_bool_option('bo', 'et')
  util.exec('%retab!')
  M.set_indent(n)
end

function M.spell_checker()
  local spell_pre = vim.wo.spell
  if not spell_pre then
    vim.wo.spell = true
  end
  util.exec('normal! mzgg]S')
  while vim.fn.spellbadword()[0] ~= '' do
    local cnt = 0
    util.exec('redraw')
    local ch = ''
    while util.elem_in_array({ 'y', 'n', 'f', 'r', 'a', 'q' }, ch) == -1 do
      if cnt > 0 then print('Incorrect input') end
      cnt = cnt + 1
      print('Word: ' ..  vim.fn.expand('<cword>') ..
        ' ([y]es/[n]o/[f]irst/[r]epeat/[a]dd/[q]uit) ')
      ch = io.read(1)
      util.exec('redraw')
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
      util.exec(dic[ch])
    end
    util.exec('normal! ]S')
  end
  util.exec('normal! `z')
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
  util.exec('match OverLength /\\%' .. w .. 'v.\\+/')
end

function M.zoom_toggle()
  if vim.t.zoomed and vim.t.zoom_winrestcmd then
    util.exec(vim.t.zoom_winrestcmd)
    vim.t.zoomed = false
  else
    vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
    util.exec('resize | vertical resize')
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
  if fs.fsize(vim.fn.expand("<afile>")) > vim.g.large_file then
    vim.o.eventignore = vim.o.eventignore .. ',FileType'
    vim.o.swapfile = false
    vim.bo.bufhidden = true
    vim.bo.buftype = 'nowrite'
    vim.wo.undolevels = 1
    vim.o.completeopt = ''
    vim.o.wrap = false
    if vim.fn.exists(':AirlineToggle') then
      util.exec('AirlineToggle')
    end
  end
end

return M
