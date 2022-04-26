do
  local group = vim.api.nvim_create_augroup('__CONFIG_GENERAL__', {
    clear = true,
  })
  vim.api.nvim_create_autocmd('BufReadPre', {
    group = group,
    pattern = '*',
    callback = require('mod.functions').handle_large_file,
  })
  vim.api.nvim_create_autocmd({'BufLeave', 'TextChanged'}, {
    group = group,
    pattern = '*',
    -- command = [[if &readonly == 0 && filereadable(bufname('%')) | update | endif]],
    command = [[if &readonly == 0 && &modified == 1 && filereadable(bufname('%')) | write | doautocmd BufWritePost | endif]],
  })
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = group,
    pattern = '*',
    callback = require('vim.highlight').on_yank,
  })
  -- vim.api.nvim_create_autocmd('BufReadPost', {
  --   pattern = '*',
  --   command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "silent normal g`\"" | end]],
  -- })
  -- vim.api.nvim_create_autocmd({'FileType', 'BufEnter'}, {
  --   group = group,
  --   pattern = '*',
  --   callback = function()
  --     require('ftplugin')(vim.bo.ft)
  --   end,
  -- })
end

-- do
  -- local group = vim.api.nvim_create_augroup('__EXT_ASSOCS__', {
  --   clear = true,
  -- })
  -- vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  --   group = group,
  --   pattern = {'*.MD', '*.md'},
  --   command = [[setf markdown]],
  -- })
  -- vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  --   group = group,
  --   pattern = '*.rasi',
  --   command = [[setf css]],
  -- })
  -- vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  --   group = group,
  --   pattern = 'Dockerfile*',
  --   command = [[setf dockerfile]],
  -- })
  -- vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  --   group = group,
  --   pattern = 'Jenkinsfile*',
  --   command = [[set ft=groovy et ts=4 sw=4]],
  -- })
  -- vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  --   group = group,
  --   pattern = '*.xml',
  --   command = [[set ft=xml et ts=4 sw=4]],
  -- })
-- end
