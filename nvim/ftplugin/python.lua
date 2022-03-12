local util = require('utl.util')

util.opt('bo', {
  commentstring = '# %s',
  formatprg = 'autopep8 -',
  ts = 4,
  sw = 4,
  et = true,
})
