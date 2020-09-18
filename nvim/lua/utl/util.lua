local vim = vim

local M = {}

function M.show_documentation()
  vim.lsp.buf.hover()
  if not vim.b.textDocument_hover then
    if vim.bo.ft == 'vim' then
      vim.fn.execute('H ' .. vim.fn.expand('<cword>'))
    elseif string.match(vim.bo.ft, 'z?sh') then
      vim.fn.execute('M ' .. vim.fn.expand('<cword>'))
    else
      print('No hover candidate found')
    end
  end
end

function M.go_to_definition()
  vim.lsp.buf.definition()
  if not vim.b.textDocument_location then
    for _, wrd in ipairs({'<cword>', '<cWORD>', '<cexpr>'}) do
      local word = vim.fn.expand(wrd)
      if #(vim.fn.taglist('^' .. word .. '$')) then
        vim.fn.execute('tag ' .. word)
        return
      end
    end
    vim.fn.execute('redraw')
    print('No definition found')
  end
end

local function vim_run_all_lines_separately(s)
  for l in s:gmatch('[^\r\n]+') do
    vim.fn.execute(l:gsub("^%s*(.-)%s*$", "%1"))
  end
end
M.augroup = vim_run_all_lines_separately
M.exec_lines = vim_run_all_lines_separately

M.func = vim.fn.execute
M.funcs = vim.fn.execute
M.exec = vim.fn.execute

function M.command(lhs, rhs, opts)
  local parts = {
    'command!',
    '-nargs=' .. (opts.nargs or '0'),
    opts.complete and '-complete=' .. opts.complete or '',
    opts.bang and '-bang' or '',
    lhs, rhs
  }
  M.exec(table.concat(parts, ' '))
end

function M.toggle_bool_option(scope, opt)
  if vim[scope] and vim[scope][opt] and
      type(vim[scope][opt]) == 'boolean' then
    vim[scope][opt] = not vim[scope][opt]
  end
end

local function edge_of_screen(d)
  local w = vim.fn.winnr()
  vim.fn.execute('silent! wincmd ' .. d)
  local n = vim.fn.winnr()
  vim.fn.execute('silent! ' .. w .. ' wincmd w')
  return w == n
end

function M.resize_window(d)
  local inc = vim.g.resize_increment or 2
  if vim.fn.winnr('$') == 1 then return end
  local dir = ''
  if d == 'h' or d == 'l' then
    dir = 'vertical'
  end
  local edge = edge_of_screen(d) and '-' or '+'
  if dir == '' and edge == '-' then
    if edge_of_screen((d == 'j') and 'k' or 'j') then
	    return
    end
  end
  vim.fn.execute(dir .. ' resize ' .. edge .. inc)
end

function M.elem_in_array(a, e)
  for _, v in ipairs(a) do
    if v == e then
      return true
    end
  end
  return false
end

return M