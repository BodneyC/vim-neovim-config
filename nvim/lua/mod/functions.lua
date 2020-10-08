local vim = vim
local util = require'utl.util'
local lang = require'utl.lang'
local fs = require'utl.fs'

local M = {}

function M.set_indent(n)
  vim.bo.ts = tonumber(n)
  vim.bo.sw = tonumber(n)
  if vim.fn.exists(":IndentLinesReset") then
    util.exec('IndentLinesReset')
  end
end

function M.change_indent(n)
  util.toggle_bool_option('bo', 'et')
  util.exec('%retab!')
  vim.bo.ts = tonumber(n)
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
    util.exec('redraw')
    local ch = ''
    local draw = true
    while not lang.elem_in_array({ 'y', 'n', 'f', 'r', 'a', 'q' }, ch) do
      if draw then
        print('Word: ' ..  vim.fn.expand('<cword>') ..
          ' ([y]es/[n]o/[f]irst/[r]epeat/[a]dd/[q]uit)\n')
      end
      draw = false
      util.exec('redraw')
      ch = vim.fn.nr2char(vim.fn.getchar())
    end
    local dic = {
      n = '',
      y = -- bit of a dirty hack to be honest
      [[
        let tmp_file = tempname()
        call writefile(spellsuggest(expand('<cword>')), tmp_file)
        exe 'split ' . tmp_file
        redraw
        setl buftype=nofile bufhidden=wipe nobuflisted ro hidden nornu nu
        let choice = input('Make your selection: ')
        q
        exe 'normal! ' . choice . 'z='
        mode
        redraw
      ]],
      r = 'spellrepall',
      f = 'normal! 1z=',
      a = 'normal! zG',
    }
    if ch == 'q' then break end
    if dic[ch] then
      util.exec_lines(dic[ch])
    end
    util.exec('normal! ]S')
  end
  util.exec('normal! `z')
  if not spell_pre then
    vim.wo.spell = false
  end
  print('Spell checker end')
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

local function call_if_fn_exists(fn)
  if vim.fn.exists(':' .. fn) then
    util.exec(fn)
  end
end

function M.handle_large_file()
  if fs.fsize(vim.fn.expand("<afile>")) > vim.g.large_file then
    vim.o.updatetime = 1000
    vim.o.wrap = false
    vim.o.completeopt = ''
    vim.o.swapfile = false
    vim.o.eventignore = vim.o.eventignore .. ',FileType'
    vim.wo.undolevels = -1
    vim.wo.signcolumn = 'no'
    vim.bo.bufhidden = true
    vim.bo.buftype = 'nowrite'
    vim.bo.syntax = 'off'
    call_if_fn_exists('AirlineToggle')
    call_if_fn_exists('TSBufDisable')
    call_if_fn_exists('LspBufStopAll')
    call_if_fn_exists('GitGutterDisable')
    call_if_fn_exists('PearTreeDisable')
  end
end

return M
