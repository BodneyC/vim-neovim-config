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

function M.init()
  -- util.augroup({
  --   name = '__DASHBOARD__',
  --   autocmds = {
  --     {event = 'FileType', glob = 'dashboard', cmd = [[set laststatus=0]]},
  --     {event = 'WinLeave', glob = '<buffer>', cmd = [[set laststatus=2]]},
  --   },
  -- })
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
