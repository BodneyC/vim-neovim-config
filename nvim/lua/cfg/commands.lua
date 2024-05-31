local command = vim.api.nvim_create_user_command

command('DiffThis', [[windo diffthis]], {})
command('DiffOff', [[windo diffoff]], {})
command('ConvLineEndings', [[%s/<CR>//g]], {})
command('HiTest', [[so $VIMRUNTIME/syntax/hitest.vim]], {})
command('Spectre', require('spectre').open, {})
command(
  'ChangeIndent',
  [[lua require('mod.functions').change_indent(<f-args>)]],
  { nargs = 1 }
)
command(
  'MatchOver',
  [[lua require('mod.functions').match_over(<f-args>)]],
  { nargs = '?' }
)
command(
  'SetIndent',
  [[lua require('mod.functions').set_indent(<f-args>)]],
  { nargs = 1 }
)
command(
  'Redir',
  function(ctx)
    vim.print(ctx)
    local lines =
        vim.split(vim.api.nvim_exec2(ctx.args, { output = true }).output, '\n', { plain = true })
    vim.cmd('new')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.opt_local.modified = false
  end,
  { nargs = '+', complete = 'command' }
)
-- command('HighlightUnderCursor', require('mod.functions').highlight_under_cursor, {})
-- command('SpellChecker', require('mod.functions').spell_checker, {})
-- command('ZoomToggle', require('mod.functions').zoom_toggle, {})
