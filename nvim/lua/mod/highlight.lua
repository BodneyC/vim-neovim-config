local vim = vim
local util = require 'utl.util'

local M = {}

function M.init() --
  vim.g.python_highlight_all = 1
  vim.g.vimspectrItalicComment = 'on'
  vim.g.onedark_termcolors = 256

  vim.o.termguicolors = true

  if os.getenv('TERMTHEME') == 'light' then
    vim.cmd('colo plint-light')
  else
  end

  M.additional_highlights()

  util.augroup({
    name = '__HIGHLIGHT__',
    autocmds = {
      {event = 'TextYankPost', glob = '*', cmd = [[silent! lua require'vim.highlight'.on_yank()]]},
      {
        event = 'ColorScheme',
        glob = '*',
        cmd = [[lua require'mod.highlight'.additional_highlights()]],
      },
      -- {event = 'CursorHold', glob = '*', cmd = [[lua require'mod.highlight'.hover_match()]]},
    },
  })

  vim.cmd('command! -nargs=0 HiTest so $VIMRUNTIME/syntax/hitest.vim')
end --

function M.additional_highlights() --
  -- vim.cmd([[
  --   hi! link HoverMatch MatchParen
  --   hi! SpelunkerSpellBad gui=undercurl
  --   hi! OverLength guibg=#995959 guifg=#ffffff
  --   hi! link JavaIdentifier NONE
  --   hi! link CleverFChar ErrorMsg
  --   hi! link CleverFCursor ErrorMsg
  --   hi! CurrentWord gui=bold
  --   hi! link CurrentWordTwins CurrentWord
  --   exec 'hi! NormalFloat guibg=' . g:color_dict.highlight[1]
  --   hi! link NormalFloat Normal " Still unsure of this
  -- ]])
  -- if os.getenv('TERMTHEME') == 'light' then
  --   vim.cmd('hi! Visual guifg=bg')
  --   vim.cmd('hi! VertSplit guibg=NONE')
  -- end
end --

function M.hover_match() --
  local id = vim.b.hover_match_id
  if id then
    for _, match in ipairs(vim.fn.getmatches()) do
      if match.id == id then
        vim.fn.matchdelete(id)
        break
      end
    end
  end
  local w = vim.fn.expand('<cword>')
  if string.match(w, '^[0-9]*[#_a-zA-Z][#_a-zA-Z0-9]*$') then
    vim.b.hover_match_id = vim.fn.matchadd('HoverMatch', '\\([^a-zA-z]\\|^\\)\\zs' .. w ..
        '\\ze\\([^a-zA-z]\\|$\\)', 0)
  end
end --

function M.SetSignTheme(bg) --
  vim.fn.execute('hi! SignColumn            guibg=' .. bg)
  vim.fn.execute('hi! GitGutterAdd          guibg=' .. bg)
  vim.fn.execute('hi! GitGutterChange       guibg=' .. bg)
  vim.fn.execute('hi! GitGutterChangeDelete guibg=' .. bg)
  vim.fn.execute('hi! GitGutterDelete       guibg=' .. bg)
  vim.fn.execute('hi! CocErrorSign          guibg=' .. bg)
  vim.fn.execute('hi! CocWarningSign        guibg=' .. bg)
end --

return M
