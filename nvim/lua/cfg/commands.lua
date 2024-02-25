local util = require('utl.util')

vim.cmd('cabbrev L Lazy')

util.commands({
  {
    name = 'DiffThis',
    cmd = [[windo diffthis]],
    opts = {
      nargs = '0',
    },
  },
  {
    name = 'DiffOff',
    cmd = [[windo diffoff]],
    opts = {
      nargs = '0',
    },
  },
  {
    name = 'ConvLineEndings',
    cmd = [[%s/<CR>//g]],
    opts = {
      nargs = '0',
    },
  },
  {
    name = 'ChangeIndent',
    cmd = [[lua require('mod.functions').change_indent(<f-args>)]],
    opts = {
      nargs = '1',
    },
  },
  {
    name = 'HiTest',
    cmd = [[so $VIMRUNTIME/syntax/hitest.vim]],
    opts = {
      nargs = 0,
    },
  },
  {
    name = 'MatchOver',
    cmd = [[lua require('mod.functions').match_over(<f-args>)]],
    opts = {
      nargs = '?',
    },
  },
  {
    name = 'Spectre',
    lua_fn = require('spectre').open,
    opts = {
      nargs = 0,
    },
  },
  {
    name = 'SetIndent',
    cmd = [[lua require('mod.functions').set_indent(<f-args>)]],
    opts = {
      nargs = '1',
    },
  },
  -- {
  --   name = 'HighlightUnderCursor',
  --   lua_fn = require('mod.functions').highlight_under_cursor,
  --   opts = {
  --     nargs = '0',
  --   },
  -- },
  -- {
  --   name = 'SpellChecker',
  --   lua_fn = require('mod.functions').spell_checker,
  --   opts = {
  --     nargs = '0',
  --   },
  -- },
  -- {
  --   name = 'ZoomToggle',
  --   lua_fn = require('mod.functions').zoom_toggle,
  --   opts = {
  --     nargs = '0',
  --   },
  -- },
})

vim.api.nvim_create_user_command('Redir', function(ctx)
  local lines = vim.split(vim.api.nvim_exec(ctx.args, true), '\n', { plain = true })
  vim.cmd('new')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
end, { nargs = '+', complete = 'command' })
