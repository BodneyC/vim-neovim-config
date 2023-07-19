local which_key = require('which-key')

return function (mapper_opts)
  return function(mode, key, cmd, desc, opts)
    local used_opts = vim.tbl_deep_extend('keep', opts or {}, mapper_opts)
    vim.keymap.set(mode, key, cmd, used_opts)
    if desc then
      which_key.register({ [key] = { desc } }, { mode = mode })
    end
  end
end
