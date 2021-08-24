local lang = require('utl.lang')

return function(ft)
  if ft == '' or ft == nil then
    return
  end

  local m = 'ftplugin.' .. ft
  if lang.module_exists(m) then

    if vim.b.did_ftplugin then
      return
    end
    vim.b.did_ftplugin = true

    require(m).init()
  end
end
