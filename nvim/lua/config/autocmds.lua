local group = vim.api.nvim_create_augroup('config_general', { clear = true })

vim.api.nvim_create_autocmd({ 'BufLeave', 'TextChanged' }, {
  group = group,
  desc = 'Autosave modified file buffers',
  callback = function(ev)
    local bo = vim.bo[ev.buf]
    if bo.readonly or not bo.modified or bo.buftype ~= '' then
      return
    end
    if vim.fn.filereadable(vim.api.nvim_buf_get_name(ev.buf)) == 0 then
      return
    end
    vim.cmd('silent update')
    if bo.filetype == 'rust' then
      vim.api.nvim_exec_autocmds('BufWritePost', { buffer = ev.buf })
    end
    if vim.g.repeat_tick then
      vim.g.repeat_tick = vim.g.repeat_tick + 1
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = 'qf',
  callback = function(ev)
    vim.keymap.set('n', '<CR>', '<CR><Cmd>cclose<CR>', { buffer = ev.buf, silent = true })
  end,
})
