local M = {}

local whitespace = ' \t\r\n'
local quotes = [['"]]

-- Super simple and sketchy version of Python's shlex.split
function M.shell_split(cmd)
  local cmd_parts = {}
  local in_quote = nil
  local current_part = ''
  for i = 1, #cmd do
    local c = cmd:sub(i, i)
    local last_char = current_part:sub(-1)
    if in_quote then
      current_part = current_part .. c
      if c == in_quote and last_char ~= '\\' then
        table.insert(cmd_parts, current_part)
        current_part = ''
        in_quote = nil
      end
    elseif quotes:find(c, 1, true) then
      current_part = current_part .. c
      in_quote = c
    elseif whitespace:find(c, 1, true) then
      if last_char == '\\' then
        current_part = current_part .. c
      elseif #current_part > 0 then
        table.insert(cmd_parts, current_part)
        current_part = ''
      end
    else
      current_part = current_part .. c
      if i == #cmd then
        table.insert(cmd_parts, current_part)
        current_part = ''
      end
    end
  end
  return cmd_parts
end

function M.mocha_strategy(cmd)
  local parts = M.shell_split(cmd)
  if #parts == 2 then
    vim.fn['vimspector#LaunchWithSettings']({
      configuration = 'mocha-file',
      prog = parts[1],
      file = parts[2],
    })
  elseif #parts >= 4 then
    if parts[3] ~= '--grep' then
      print('Third arg not \'--grep\', exiting')
      return
    end
    local term = ''
    for i = 4, #parts do
      term = term .. parts[i]
    end
    term = term:sub(2, -2)
    print('File ' .. parts[2] .. ', term ' .. term)
    vim.fn['vimspector#LaunchWithSettings']({
      configuration = 'mocha-grep',
      prog = parts[1],
      file = parts[2],
      term = term,
    })
  end
end

function M.init()

  vim.cmd([[
    function! VimTestMochaStrategy(cmd)
      exe "lua require('mod.vim-test').mocha_strategy(\[\[" . a:cmd . "\]\])"
    endfunction

    let g:test#custom_strategies = {
      \   'mocha': function('VimTestMochaStrategy')
      \ }
  ]])
end

return M
