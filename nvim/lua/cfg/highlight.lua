local util = require('utl.util')

-- -- Only here so I don't have to PackerCompile while debugging
-- require('bolorscheme').setup {
--   theme = 'spacegray',
--   light = false,
-- }

util.opt('g', {
  everforest_background = 'medium',
})

do
  local group = vim.api.nvim_create_augroup('EverforestCustom', {
    clear = true,
  })
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    pattern = 'everforest',
    callback = require('mod.highlight').everforest_custom,
  })
end

vim.cmd('colo everforest')
