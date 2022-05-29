local M = {}

function M.everforest_custom()
  local p = vim.fn['everforest#get_palette'](vim.g.everforest_background,
    vim.empty_dict())

  local function hl(name, fg, bg, opts)
    local cmd = 'hi! ' .. name
    if fg then
      cmd = cmd .. ' guifg=' .. fg[1]
    end
    if bg then
      cmd = cmd .. ' guibg=' .. bg[1]
    end
    if opts then
      cmd = cmd .. ' gui=' .. table.concat(opts, ',')
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

  hl('SignColumn', nil, p.bg0)
  hl('RedSign', p.red, p.none)
  hl('OrangeSign', p.orange, p.none)
  hl('YellowSign', p.yellow, p.none)
  hl('GreenSign', p.green, p.none)
  hl('AquaSign', p.aqua, p.none)
  hl('BlueSign', p.blue, p.none)
  hl('PurpleSign', p.purple, p.none)

  hl('NvimTreeNormal', nil, p.bg1)
  hl('NvimTreeCursorLine', nil, p.bg0)
  hl('NvimTreeEndOfBuffer', p.bg1, p.bg1)

  hl('gitblame', p.grey1, p.bg1, {'italic'})

  hl('VirtualTextInfo', nil, p.bg1)
  hl('VirtualTextHint', nil, p.bg1)
  hl('VirtualTextError', nil, p.bg1)
  hl('VirtualTextWarning', nil, p.bg1)

  hl('IndentBlanklineChar', p.bg1, nil)
end

return M
