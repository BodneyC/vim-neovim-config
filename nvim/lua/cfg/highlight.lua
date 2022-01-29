local util = require('utl.util')

-- -- Only here so I don't have to PackerCompile while debugging
-- require('bolorscheme').setup {
--   theme = 'spacegray',
--   light = false,
-- }

util.opt('g', {
  everforest_background = 'medium',
})
vim.cmd('colo everforest')
do
  local p = vim.fn['everforest#get_palette'](
    vim.fn['everforest#get_configuration']().background)

  local function hl(name, fg, bg)
    local cmd = 'hi! ' .. name
    if fg then
      cmd = cmd .. ' guifg=' .. fg[1]
    end
    if bg then
      cmd = cmd .. ' guibg=' .. bg[1]
    end
    vim.cmd(cmd)
  end

  hl('TelescopeBorder', p.bg1, p.bg1)
  hl('TelescopePromptBorder', p.bg2, p.bg2)

  hl('TelescopePromptNormal', p.fg, p.bg2)
  hl('TelescopePromptPrefix', p.red, p.bg2)

  hl('TelescopeNormal', nil, p.bg1)

  hl('TelescopePreviewTitle', p.bg, p.green)
  hl('TelescopePromptTitle', p.bg, p.red)
  hl('TelescopeResultsTitle', p.bg1, p.bg1)

  hl('TelescopeSelection', nil, p.bg2)

  hl('EndOfBuffer', p.bg0, p.bg0)
end
