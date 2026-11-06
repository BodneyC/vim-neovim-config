local command = vim.api.nvim_create_user_command

local function set_indent(n)
  vim.bo.tabstop = n
  vim.bo.shiftwidth = n
end

command('DiffThis', 'windo diffthis', {})
command('DiffOff', 'windo diffoff', {})
command('ConvLineEndings', [[%s/\r//g]], {})
command('HiTest', 'source $VIMRUNTIME/syntax/hitest.vim', {})

command('SetIndent', function(ctx)
  set_indent(tonumber(ctx.args))
end, { nargs = 1 })

command('ChangeIndent', function(ctx)
  local n = tonumber(ctx.args)
  vim.bo.expandtab = not vim.bo.expandtab
  vim.cmd('%retab!')
  vim.bo.tabstop = n
  vim.bo.expandtab = not vim.bo.expandtab
  vim.cmd('%retab!')
  set_indent(n)
end, { nargs = 1 })

command('MatchOver', function(ctx)
  local width = tonumber(ctx.args) or vim.g.match_over_width or 80
  if vim.fn.hlexists('OverLength') == 0 then
    vim.api.nvim_set_hl(0, 'OverLength', { fg = '#ffffff', bg = '#995959' })
  end
  vim.cmd.match({ args = { 'OverLength', [[/\%]] .. width .. [[v.\+/]] } })
end, { nargs = '?' })

command('Redir', function(ctx)
  local output = vim.api.nvim_exec2(ctx.args, { output = true }).output
  vim.cmd.new()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, '\n', { plain = true }))
  vim.bo.modified = false
end, { nargs = '+', complete = 'command' })

command('ClearUnlisted', function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and not vim.bo[buf].buflisted then
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end
  end
end, {})
