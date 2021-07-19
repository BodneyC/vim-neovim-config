local lang = require 'utl.lang'

return function(ft)
  if ft == '' or ft == nil then
    return
  end
  local m = 'ftplugin.' .. ft
  if lang.module_exists(m) then
    require(m).init()
  end
end
