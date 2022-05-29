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
    callback = function()
      if vim.bo.readonly or not vim.bo.modified or
        vim.fn.filereadable(vim.fn.bufname('%')) == 0 then
        return
      end
      vim.cmd([[silent update]])
      if vim.bo.ft == 'rust' then
        vim.cmd([[doautocmd BufWritePost]])
      end
      -- Bug: vaguely related to https://github.com/tpope/vim-repeat/issues/82
      vim.g.repeat_tick = vim.g.repeat_tick and vim.g.repeat_tick + 1
    end,
  })
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = group,
    pattern = '*',
    callback = require('vim.highlight').on_yank,
  })
end
