local vim = vim

local util = require 'utl.util'
local fs = require 'utl.fs'

local header = [[

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

]]

local footer = [[

+----------------------------+
|                            |
|      NeoVim - BodneyC      |
|                            |
+----------------------------+

]]
local function center(txt)
  local lines = {}
  for s in txt:gmatch('[^\r\n]+') do table.insert(lines, s) end
  local longest = 0
  for _, l in ipairs(lines) do if #l > longest then longest = #l end end
  local spaces = string.rep(' ', (vim.fn.winwidth(0) / 2) - (longest / 2))
  local outlines = {}
  for _, l in ipairs(lines) do table.insert(outlines, spaces .. l) end
  return outlines
end

return {
  init = function()
    if vim.fn.argc() == 0 or
        (vim.fn.argc() == 1 and fs.dir_exists(vim.fn.argv(0)) and not vim.fn.exists('s:stdin')) then
      vim.g.startify_padding_left = math.floor(vim.fn.winwidth(0) / 4)
      vim.g.startify_custom_header = center(header)
      vim.g.startify_custom_footer = center(footer)
      vim.fn.execute('Startify')
    end
  end,
}
