local ts = require('nvim-treesitter')

local M = {}

function M.statusline()
  local ft = vim.bo.ft
  local status = ''
  if ft == 'yaml' or ft == 'helm' then
    status = ts.statusline({
      type_patterns = {'block_mapping_pair'},
      separator = '.',
      transform_fn = function(line)
        return line:gsub('%s*[%[%(%{]*%s*$', ''):gsub(':.*$', '')
      end,
    })
  else
    status = ts.statusline()
  end
  return status
end

return M
