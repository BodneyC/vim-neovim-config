local vim = vim
local fs = require 'utl.fs'
local util = require 'utl.util'
local lang = require 'utl.lang'

local M = {}

function M.order_by_bufnr() --
  local blstate = require 'bufferline.state'
  table.sort(blstate.buffers, function(a, b)
    return a < b
  end)
  vim.fn['bufferline#update']()
end --

function M.bs() --
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
end --

function M.set_indent(n) --
  vim.bo.ts = tonumber(n)
  vim.bo.sw = tonumber(n)
  if vim.fn.exists(':IndentLinesReset') == 1 then vim.cmd('IndentLinesReset') end
  if vim.fn.exists(':IndentBlanklineRefresh') == 1 then vim.cmd('IndentBlanklineRefresh') end
end --

function M.change_indent(n) --
  util.toggle_bool_option('bo', 'et')
  vim.cmd('%retab!')
  vim.bo.ts = tonumber(n)
  util.toggle_bool_option('bo', 'et')
  vim.cmd('%retab!')
  M.set_indent(n)
end --

function M.spell_checker() --
  local spell_pre = vim.wo.spell
  if not spell_pre then vim.wo.spell = true end
  vim.cmd('normal! mzgg]S')
  while vim.fn.spellbadword()[0] ~= '' do
    vim.cmd('redraw')
    local ch = ''
    local draw = true
    while not lang.elem_in_array({'y', 'n', 'f', 'r', 'a', 'q'}, ch) do
      if draw then
        print('Word: ' .. vim.fn.expand('<cword>') ..
                  ' ([y]es/[n]o/[f]irst/[r]epeat/[a]dd/[q]uit)\n')
      end
      draw = false
      vim.cmd('redraw')
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
    if dic[ch] then vim.cmd_lines(dic[ch]) end
    vim.cmd('normal! ]S')
  end
  vim.cmd('normal! `z')
  if not spell_pre then vim.wo.spell = false end
  print('Spell checker end')
end --

function M.match_over(...) --
  local args = {...}
  print(vim.inspect(args))
  if #args > 1 or (args[1] and not tonumber(args[1])) then error('More than one argument') end
  local w = vim.g.match_over_width or 80
  if args[1] then w = args[1] end
  vim.cmd('match OverLength /\\%' .. w .. 'v.\\+/')
end --

function M.zoom_toggle() --
  if vim.t.zoomed and vim.t.zoom_winrestcmd then
    vim.cmd(vim.t.zoom_winrestcmd)
    vim.t.zoomed = false
  else
    vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
    vim.cmd('resize | vertical resize')
    vim.t.zoomed = true
  end
end --

function M.highlight_under_cursor() --
  local hl_groups = {}
  for _, e in ipairs(vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))) do
    table.insert(hl_groups, vim.fn.synIDattr(e, 'name'))
  end
  print(vim.inspect(hl_groups))
end --

-- Requires barbar at the minute, but not necessary I suppose...
function M.buffer_close_all_but_visible() --
  local bs = vim.fn.map(vim.fn.filter(vim.fn.range(0, vim.fn.bufnr('$')),
      'bufexists(v:val) && buflisted(v:val) && bufwinnr(v:val) < 0'), 'bufname(v:val)')
  if #bs > 0 then
    for _, buf in ipairs(bs) do vim.fn.execute('BufferClose ' .. buf) end
  else
    print('No buffers to delete')
  end
end --

local function call_if_fn_exists(fn) --
  if vim.fn.exists(':' .. fn) then vim.cmd(fn) end
end --

function M.handle_large_file() --
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
    call_if_fn_exists('TSBufDisable')
    call_if_fn_exists('LspBufStopAll')
    call_if_fn_exists('GitGutterDisable')
    call_if_fn_exists('PearTreeDisable')
  end
end --

return M
