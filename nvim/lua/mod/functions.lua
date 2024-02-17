local fs = require('utl.fs')
local util = require('utl.util')
local lang = require('utl.lang')

local M = {}

function M.bufonly()
  local tablist = {}
  for tabnr = 1, vim.fn.tabpagenr('$') do
    for _, bufnr in ipairs(vim.fn.tabpagebuflist(tabnr)) do table.insert(tablist, bufnr) end
  end
  local cnt = 0
  -- NOTE: These comments exist for debugging purposes
  local bwd = {}
  for bufnr = 1, vim.fn.bufnr('$') do
    if vim.fn.bufexists(bufnr) == 1 and vim.fn.getbufvar(bufnr, '&mod') == 0 and
        lang.index_of(tablist, bufnr) == -1 then
      table.insert(bwd, vim.fn.bufname(bufnr))
      vim.cmd([[silent bwipeout]] .. bufnr)
      cnt = cnt + 1
    end
  end
  if cnt > 0 then print(cnt .. ' buffers wiped out') end
  -- if cnt > 0 then print(cnt .. ' buffers wiped out: ' .. vim.inspect(bwd)) end
end

-- WIP
function M.bs()
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

function M.set_indent(n)
  vim.bo.ts = tonumber(n)
  vim.bo.sw = tonumber(n)
  if vim.fn.exists(':IndentBlanklineRefresh') == 1 then vim.cmd('IndentBlanklineRefresh') end
end

function M.change_indent(n)
  util.toggle_bool_option('bo', 'et')
  vim.cmd('%retab!')
  vim.bo.ts = tonumber(n)
  util.toggle_bool_option('bo', 'et')
  vim.cmd('%retab!')
  M.set_indent(n)
end

function M.match_over(...)
  local args = { ... }
  print(vim.inspect(args))
  if #args > 1 or (args[1] and not tonumber(args[1])) then error('More than one argument') end
  local w = vim.g.match_over_width or 80
  if args[1] then w = args[1] end
  if vim.fn.hlexists('OverLength') == 0 then
    vim.cmd([[hi! OverLength guibg=#995959 guifg=#ffffff]])
  end
  vim.cmd([[match OverLength /\%]] .. w .. [[v.\+/]])
end

local function call_if_fn_exists(fn) if vim.fn.exists(':' .. fn) == 1 then vim.cmd(fn) end end

function M.handle_large_file()
  local fn = vim.fn.expand('<afile>')
  if fs.file_exists(fn) and fs.fsize(vim.fn.expand('<afile>')) > vim.g.large_file then
    vim.o.updatetime = 1000
    vim.wo.wrap = false
    vim.o.completeopt = ''
    vim.bo.swapfile = false
    if #vim.o.eventignore > 0 then
      vim.o.eventignore = vim.o.eventignore .. ',FileType'
    else
      vim.o.eventignore = 'FileType'
    end
    vim.o.undolevels = -1
    vim.wo.signcolumn = 'no'
    vim.bo.bufhidden = 'wipe'
    vim.bo.buftype = 'nowrite'
    vim.bo.syntax = 'off'
    call_if_fn_exists('TSBufDisable')
    call_if_fn_exists('LspBufStopAll')
    call_if_fn_exists('GitGutterDisable')
    call_if_fn_exists('PearTreeDisable')
  end
end

return M
