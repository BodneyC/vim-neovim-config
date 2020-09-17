local vim = vim
local util = require'utl.util'

local M = {}

function M.init()
  vim.g.python_highlight_all = 1
  vim.g.vimspectrItalicComment = 'on'
  vim.g.onedark_termcolors = 256

  vim.o.termguicolors = true

  if os.getenv('TERMTHEME') == "light" then
    util.exec('colo plint-light')
  else
    util.exec('colo unicorn')
  end

  M.additional_highlights()

  util.augroup([[
    augroup __HIGHLIGHT__
      au!
      au TextYankPost * silent! lua require'vim.highlight'.on_yank()
      au ColorScheme  * lua require'mod.highlight'.additional_highlights()
      au CursorHold   * lua require'mod.highlight'.hover_match()
    augroup END
  ]])

  util.exec('command! -nargs=0 HiTest so $VIMRUNTIME/syntax/hitest.vim')
end

function M.additional_highlights()
  util.exec('hi! link HoverMatch MatchParen')
  util.exec('hi! SpelunkerSpellBad gui=undercurl')
  util.exec('hi! OverLength guibg=#995959 guifg=#ffffff')
  util.exec('hi! link JavaIdentifier NONE')
  util.exec('hi! link CleverFChar ErrorMsg')
  util.exec('hi! link CleverFCursor ErrorMsg')
  if os.getenv('TERMTHEME') == "light" then
    util.exec('hi! Visual guifg=bg')
    util.exec('hi! VertSplit guibg=NONE')
  end
end


function M.hover_match()
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
    vim.b.hover_match_id = vim.fn.matchadd(
      'HoverMatch',
      '\\([^a-zA-z]\\|^\\)\\zs' .. w .. '\\ze\\([^a-zA-z]\\|$\\)'
    )
  end
end

function M.SetSignTheme(bg)
  vim.fn.execute('hi! SignColumn            guibg=' .. bg)
  vim.fn.execute('hi! GitGutterAdd          guibg=' .. bg)
  vim.fn.execute('hi! GitGutterChange       guibg=' .. bg)
  vim.fn.execute('hi! GitGutterChangeDelete guibg=' .. bg)
  vim.fn.execute('hi! GitGutterDelete       guibg=' .. bg)
  vim.fn.execute('hi! CocErrorSign          guibg=' .. bg)
  vim.fn.execute('hi! CocWarningSign        guibg=' .. bg)
  util.exec([[
    hi! clear CocGitAddedSign CocGitChangedSign CocGitChangeRemovedSign CocGitRemovedSign
    hi link CocGitAddedSign GitGutterAdd
    hi link CocGitChangedSign GitGutterChange
    hi link CocGitChangeRemovedSign GitGutterChangeDelete
    hi link CocGitRemovedSign GitGutterDelete
  ]])
end


return M
