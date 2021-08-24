local util = require('utl.util')

local M = {}

function M.init()
  util.opt('bo', {
    commentstring = '# %s',
    formatprg = 'autopep8 -',
    ts = 4,
    sw = 4,
    et = true,
  })
end

return M
