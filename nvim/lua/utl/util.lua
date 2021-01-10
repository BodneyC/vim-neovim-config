local vim = vim

local M = {}

M.document_formatting = function()
  local clients = vim.lsp.buf_get_clients()
  if #clients > 0 then
    for _, o in pairs(clients) do
      if o.resolved_capabilities.document_formatting ~= false then
        vim.lsp.buf.formatting()
        return
      end
    end
  end
  vim.fn.execute('w')
  vim.fn.execute('FormatWrite')
end

M.show_documentation = function()
  if #vim.lsp.buf_get_clients() ~= 0 then
    vim.lsp.buf.hover()
  else
    if vim.bo.ft == 'vim' then
      vim.fn.execute('H ' .. vim.fn.expand('<cword>'))
    elseif string.match(vim.bo.ft, 'z?sh') then
      vim.fn.execute('M ' .. vim.fn.expand('<cword>'))
    else
      print('No hover candidate found')
    end
  end
end

M.go_to_definition = function()
  if #vim.lsp.buf_get_clients() ~= 0 then
    vim.lsp.buf.definition()
  else
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

local vim_run_all_lines_separately = function(s)
  for l in s:gmatch('[^\r\n]+') do
    vim.fn.execute(l:gsub('^%s*(.-)%s*$', '%1'))
  end
end
M.augroup = vim_run_all_lines_separately
M.exec_lines = vim_run_all_lines_separately

M.func = vim.fn.execute

M.funcs = vim.fn.execute
M.exec = vim.fn.execute

M.command = function(lhs, rhs, opts)
  local parts = {
    'command!',
    '-nargs=' .. (opts.nargs or '0'),
    opts.complete and '-complete=' .. opts.complete or '',
    opts.bang and '-bang' or '',
    opts.range and '-range' or '',
    opts.buffer and '-buffer' or '',
    lhs,
    rhs,
  }
  M.exec(table.concat(parts, ' '))
end

M.toggle_bool_option = function(scope, opt)
  if vim[scope] and vim[scope][opt] ~= nil and type(vim[scope][opt]) ==
      'boolean' then
    vim[scope][opt] = not vim[scope][opt]
  end
end

local edge_of_screen = function(d)
  local w = vim.fn.winnr()
  vim.fn.execute('silent! wincmd ' .. d)
  local n = vim.fn.winnr()
  vim.fn.execute('silent! ' .. w .. ' wincmd w')
  return w == n
end

M.resize_window = function(d)
  local inc = vim.g.resize_increment or 2
  if vim.fn.winnr('$') == 1 then
    return
  end
  local dir = ''
  if d == 'h' or d == 'l' then
    dir = 'vertical'
  end
  print(edge_of_screen(d))
  local edge = edge_of_screen(d) and '-' or '+'
  if dir == '' and edge == '-' then
    if edge_of_screen((d == 'j') and 'k' or 'j') then
      return
    end
  end
  vim.fn.execute(dir .. ' resize ' .. edge .. inc)
end

return M
