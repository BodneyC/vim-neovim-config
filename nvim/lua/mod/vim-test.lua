local shlex = require('utl.shlex')
local dap_helper = require('mod.dap-helper')

local M = {}

function M.jest_strategy(cmd)
  local parts = shlex.split(cmd)
  local prog = parts[1]
  local term = parts[4]
  local file = parts[6]
  dap_helper.debug_jest(prog, file, term)
end

function M.mocha_strategy(cmd)
  local parts = shlex.split(cmd)
  local prog = parts[1]
  local file = parts[2]
  local term
  if #parts >= 4 then
    term = parts[4]
  end
  dap_helper.debug_mocha(prog, file, term)
end

function M.init()
  vim.cmd([[
    function! VimTestJestStrategy(cmd)
      exe "lua require('mod.vim-test').jest_strategy(\[\[" . a:cmd . "\]\])"
    endfunction

    function! VimTestMochaStrategy(cmd)
      exe "lua require('mod.vim-test').mocha_strategy(\[\[" . a:cmd . "\]\])"
    endfunction

    let g:test#custom_strategies = {
      \   'mocha': function('VimTestMochaStrategy'),
      \   'jest': function('VimTestJestStrategy'),
      \ }
  ]])
end

return M
