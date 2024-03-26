local width = 80
vim.bo.tw = width
-- Hacky...
vim.cmd('au! BufEnter <buffer> MatchOver ' .. width)
vim.cmd('au! BufLeave <buffer> MatchOver 80000')
