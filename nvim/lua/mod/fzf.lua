local vim = vim

local util = require 'utl.util'
local lang = require 'utl.lang'

local rg_cmd = 'rg -g "!{.lsp,.clj-kondo,node_modules,package-lock.json,yarn.lock,.git}" ' ..
                   '--hidden --ignore-vcs --column --no-heading --line-number --color=always -- '

local M = {}

function M.run_cmd(cmd)
  if vim.fn.winnr('$') > 1 and lang.elem_in_array({'defx', 'coc-explorer'}, vim.bo.ft) then
    vim.cmd('wincmd p')
  end
  vim.cmd(cmd)
end

function M.files(q)
  local fzf_opts = {options = {'--query', q}}
  vim.fn['fzf#vim#files']('', vim.fn['fzf#vim#with_preview'](fzf_opts, 'up:70%'))
end

function M.rg(q, b)
  local fzf_opts = {options = {'--delimiter', ':', '--nth', '4..', '--query', q}}
  vim.fn['fzf#vim#grep'](rg_cmd .. vim.fn.shellescape(q), 1,
      vim.fn['fzf#vim#with_preview'](fzf_opts), b)
end

function M.rg_under_cursor()
  local w = vim.fn.expand('<cword>')
  if string.match(w, '^[_a-zA-Z0-9][#_a-zA-Z0-9]*$') then
    local fzf_opts = {down = '20%', options = {'--margin', '0,0'}}
    vim.fn['fzf#vim#grep'](rg_cmd .. vim.fn.shellescape(w), 1,
        vim.fn['fzf#vim#with_preview'](fzf_opts), 0)
  else
    print('"' .. w .. '" does not match /^[_a-za-Z0-9]+/')
  end
end

return M
