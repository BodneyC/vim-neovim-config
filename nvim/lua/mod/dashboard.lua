local vim = vim
local util = require 'utl.util'
local fs = require 'utl.fs'

local M = {}

local header = string.split([[

                                       ,---._
  ,---,.                             .-- -.' \   ,----..
,'  .'  \                            |    |   : /   /   \
,---.' .' |               ,---,      :    ;   ||   :     :
|   |  |: |           ,-+-. /  |     :    :   |.   |  ;. /
:   :  :  /   ,---.  ,--.'|'   |     |    :   :.   ; /--`
:   |    ;   /     \|   |  ,"' |     :    |    ;   | ;
|   :     \ /    /  |   | /  | |     |    ;   ||   : |
|   |   . |.    ' / |   | |  | | ___ l    '    .   | '___
'   :  '; |'   ;   /|   | |  |//    /\    J   :'   ; : .'|
|   |  | ; '   |  / |   | |--'/  ../  `..-    ,'   | '/  :
|   :   /  |   :    |   |/    \    \         ; |   :    /
|   | ,'    \   \  /'---'      \    \      ,'   \   \ .'
`----'       `----'             "---....--'      `---`

]], '\n')

local footer = string.split([[

+----------------------------+
|                            |
|      NeoVim - BodneyC      |
|                            |
+----------------------------+

]], '\n')

M.init = function()
  -- util.augroup([[
  --   augroup __DASHBOARD__
  --     au FileType dashboard set laststatus=0
  --     au WinLeave <buffer> set laststatus=2
  --   augroup END
  -- ]])
  vim.g.dashboard_custom_header = header
  vim.g.dashboard_custom_footer = footer
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.dashboard_custom_shortcut = {
    last_session = 'l',
    find_history = 'h',
    find_file = 'f',
    new_file = 'e',
    change_colorscheme = 'c',
    find_word = 'a',
    book_marks = 'b',
  }
  vim.g.dashboard_custom_shortcut_icon = {
    last_session = '  ',
    find_history = 'ﭯ  ',
    find_file = '  ',
    new_file = '  ',
    change_colorscheme = '  ',
    find_word = '  ',
    book_marks = '  ',
  }
end

return M
