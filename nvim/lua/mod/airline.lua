local vim = vim

local M = {}

M.file_info = function()
  local ff = {unix = '', mac = '', dos = ''}
  return ff[vim.bo.ff] .. ' ' .. vim.bo.ft
end

M.mode = function()
  local m = vim.w.airline_current_mode or ''
  return string.sub(vim.fn['airline#util#shorten'](m, 79, 1), 0, 3)
end

M.modified = function()
  return vim.bo.modified and ' ' or ''
end

M.nvim_lsp = function()
  if #vim.lsp.buf_get_clients() > 0 then return require'lsp-status'.status() end
  return ' '
end

M.init = function()
  local spc = vim.g.airline_symbols.space or ' '
  vim.g.airline_section_a = vim.fn['airline#section#create'](
      {'Mode', 'crypt', 'paste', 'keymap', 'spell', 'capslock', 'xkblayout', 'iminsert'})
  vim.g.airline_section_b = vim.fn['airline#section#create']({'branch'})
  vim.g.airline_section_c = vim.fn['airline#section#create']({'%<', 'Fn', 'Modified', 'readonly'})
  vim.g.airline_section_x = vim.fn['airline#section#create_right'](
      {'bookmark', 'gutentags', 'grepper', 'NvimLsp'})
  vim.g.airline_section_y = vim.fn['airline#section#create']({'FileInfo'})
  if vim.fn['airline#util#winwidth']() > 79 then
    vim.g.airline_section_z = vim.fn['airline#section#create'](
        {'windowswap', 'obsession', '%p%%', spc, 'Position'})
  else
    vim.g.airline_section_z = vim.fn['airline#section#create']({'%p%%', spc, 'LineNr', ':%v'})
  end
end

return M
