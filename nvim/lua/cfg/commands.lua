local util = require('utl.util')

vim.cmd([[
  cabbrev PC PackerCompile
  cabbrev PI PackerInstall
  cabbrev PS PackerSync
  cabbrev PU PackerUpdate
]])

vim.cmd(
  [[cnoreabbrev SortLen ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }']])

vim.cmd([[
  func! CopyForTerminal(...) range
    let reg = get(a:, 1, '"')
    let lines = getline(a:firstline, a:lastline)
    call map(lines, { i, l -> substitute(l, '^ *\(.*\)\\ *$', '\1 ', '') })
    exe "let @" . reg . " = join(lines, ' ')"
  endfunc
]])

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
    name = 'Wqa',
    cmd = [[wqa]],
    opts = {
      nargs = '0',
    },
  },
  {
    name = 'WQa',
    cmd = [[wqa]],
    opts = {
      nargs = '0',
    },
  },
  {
    name = 'WQ',
    cmd = [[wq]],
    opts = {
      nargs = '0',
    },
  },
  {
    name = 'Wq',
    cmd = [[wq]],
    opts = {
      nargs = '0',
    },
  },
  {
    name = 'W',
    cmd = [[w]],
    opts = {
      nargs = '0',
    },
  },
  {
    name = 'Q',
    cmd = [[q]],
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
    name = 'CopyForTerminal',
    cmd = [[<line1>,<line2>call CopyForTerminal(<f-args>)]],
    opts = {
      range = true,
      nargs = '?',
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
    name = 'HighlightUnderCursor',
    lua_fn = require('mod.functions').highlight_under_cursor,
    opts = {
      nargs = '0',
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
  {
    name = 'SpellChecker',
    lua_fn = require('mod.functions').spell_checker,
    opts = {
      nargs = '0',
    },
  },
  {
    name = 'ZoomToggle',
    lua_fn = require('mod.functions').zoom_toggle,
    opts = {
      nargs = '0',
    },
  },

})
