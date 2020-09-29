local lang = require'utl.lang'

return function(ft)
  local m = 'ftplugin.' .. ft
  if lang.module_exists(m) then
    require(m).init()
  end
end
