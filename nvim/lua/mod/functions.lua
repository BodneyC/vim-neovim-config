local vim = vim
local fs = require 'utl.fs'
local util = require 'utl.util'
local lang = require 'utl.lang'

local M = {}

-- `wqa` with a terminal open comes with E948 and the "no matching autocommands
--  for acwrite buffer" - I can't find a solution, this is a bodge, I hate it,
--  but it works.
M.wqa = function()
  util.exec([[
    try
      wqa
    catch
      wa
      qa
    endtry
  ]])
end

M.order_by_bufnr = function()
  local blstate = require 'bufferline.state'
  table.sort(blstate.buffers, function(a, b)
    return a < b
  end)
  vim.fn['bufferline#update']()
end

M.bs = function()
  local getline = vim.fn.getline
  local ln = vim.fn.line('.')
  local l = getline(ln)
  local pl = getline(ln - 1)
  if string.match(string.sub(l, 1, vim.fn.col('.') - 1), '^%s+$') then
    if string.match(pl, '^%s*$') then
      if string.match(l, '^%s*$') then
        return '<Esc>:silent exe line(\'.\') - 1 . \'delete\'<CR>S'
      else
        return '<C-o>:exe line(\'.\') - 1 . \'delete\'<CR>'
      end
    else
      return '<C-w><BS>'
    end
  else
    return vim.fn.AutoPairsDelete()
  end
end

M.set_indent = function(n)
  vim.bo.ts = tonumber(n)
  vim.bo.sw = tonumber(n)
  if vim.fn.exists(':IndentLinesReset') then util.exec('IndentLinesReset') end
end

M.change_indent = function(n)
  util.toggle_bool_option('bo', 'et')
  util.exec('%retab!')
  vim.bo.ts = tonumber(n)
  util.toggle_bool_option('bo', 'et')
  util.exec('%retab!')
  M.set_indent(n)
end

M.spell_checker = function()
  local spell_pre = vim.wo.spell
  if not spell_pre then vim.wo.spell = true end
  util.exec('normal! mzgg]S')
  while vim.fn.spellbadword()[0] ~= '' do
    util.exec('redraw')
    local ch = ''
    local draw = true
    while not lang.elem_in_array({'y', 'n', 'f', 'r', 'a', 'q'}, ch) do
      if draw then
        print('Word: ' .. vim.fn.expand('<cword>') ..
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
    if dic[ch] then util.exec_lines(dic[ch]) end
    util.exec('normal! ]S')
  end
  util.exec('normal! `z')
  if not spell_pre then vim.wo.spell = false end
  print('Spell checker end')
end

M.match_over = function(...)
  local args = {...}
  print(vim.inspect(args))
  if #args > 1 or (args[1] and not tonumber(args[1])) then error('More than one argument') end
  local w = vim.g.match_over_width or 80
  if args[1] then w = args[1] end
  util.exec('match OverLength /\\%' .. w .. 'v.\\+/')
end

M.zoom_toggle = function()
  if vim.t.zoomed and vim.t.zoom_winrestcmd then
    util.exec(vim.t.zoom_winrestcmd)
    vim.t.zoomed = false
  else
    vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
    util.exec('resize | vertical resize')
    vim.t.zoomed = true
  end
end

M.highlight_under_cursor = function()
  local hl_groups = {}
  for _, e in ipairs(vim.fn.synstack(vim.fn.col('.'), vim.fn.line('.'))) do
    table.insert(hl_groups, vim.fn.synIDattr(e, 'name'))
  end
  print(vim.inspect(hl_groups))
end

-- Requires barbar at the minute, but not necessary I suppose...
M.buffer_close_all_but_visible = function()
  local bs = vim.fn.map(vim.fn.filter(vim.fn.range(0, vim.fn.bufnr('$')),
      'bufexists(v:val) && buflisted(v:val) && bufwinnr(v:val) < 0'), 'bufname(v:val)')
  if #bs > 0 then
    for _, buf in ipairs(bs) do vim.fn.execute('BufferClose ' .. buf) end
  else
    print('No buffers to delete')
  end
end

local call_if_fn_exists = function(fn)
  if vim.fn.exists(':' .. fn) then util.exec(fn) end
end

M.handle_large_file = function()
  local fn = vim.fn.expand('<afile>')
  if fs.file_exists(fn) and fs.fsize(vim.fn.expand('<afile>')) > vim.g.large_file then
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
