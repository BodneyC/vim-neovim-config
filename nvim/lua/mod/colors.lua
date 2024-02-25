local M = {}

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

function M.material()
  -- order matters here...
  vim.g.material_style = 'darker'
  local colors = require('material.colors')

  require('material').setup({

    contrast = {
      terminal = true, -- Enable contrast for the built-in terminal
      sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
      floating_windows = false, -- Enable contrast for floating windows
      cursor_line = false, -- Enable darker background for the cursor line
      non_current_windows = false, -- Enable contrasted background for non-current windows
      filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
    },

    styles = { -- Give comments style such as bold, italic, underline etc.
      comments = { italic = true },
      keywords = { --[[ italic = true ]]
      },
      strings = { --[[ bold = true ]]
      },
      functions = { --[[ bold = true, undercurl = true ]]
      },
      variables = {},
      operators = {},
      types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
      -- Available plugins:
      'dap',
      -- 'dashboard',
      -- 'eyeliner',
      -- 'fidget',
      -- 'flash',
      'gitsigns',
      -- 'harpoon',
      -- 'hop',
      -- 'illuminate',
      'indent-blankline',
      'lspsaga',
      -- 'mini',
      -- 'neogit',
      'neotest',
      'neo-tree',
      -- 'neorg',
      'noice',
      'nvim-cmp',
      -- 'nvim-navic',
      -- 'nvim-tree',
      'nvim-web-devicons',
      'rainbow-delimiters',
      -- 'sneak',
      -- 'telescope',
      'trouble',
      'which-key',
      'nvim-notify',
    },

    disable = {
      colored_cursor = true, -- Disable the colored cursor
      borders = true, -- Disable borders between verticaly split windows
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = true, -- Hide the end-of-buffer lines
    },

    high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = true, -- Enable higher contrast text for darker style
    },

    lualine_style = 'stealth', -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_colors = nil, -- If you want to override the default colors, set this to a function

    custom_highlights = {
      Search = {
        bg = colors.editor.selection,
        fg = colors.main.white,
      },
      -- NoiceCmdLine = {
      --   bg = colors.editor.selection,
      -- },
    }, -- Overwrite highlights with your own
  })
  vim.cmd('colo material')
end

function M.nightfox()
  local variant = 'nordfox'
  require('nightfox').setup({
    options = {
      styles = {
        comments = 'italic',
        keywords = 'bold',
        types = 'italic,bold',
      },
    },
    groups = {
      all = {
        IndentBlanklineChar = { fg = 'bg3' },
        TelescopePromptBorder = { bg = 'bg2', fg = 'fg2' },
        TelescopePromptNormal = { bg = 'bg2', fg = 'fg0' },
        TelescopePromptTitle = { bg = 'bg2', fg = 'fg2' },
        TelescopePromptPrefix = { bg = 'bg2', fg = 'fg2' },
        TelescopeNormal = { bg = 'bg1' },
        gitblame = { fg = 'palette.comment' },
        CursorLine = { bg = 'bg2' },
        CurrentWord = { bg = 'bg2' },
        CurrentWords = { bg = 'bg1' },
        CurrentWordsTwins = { link = 'CurrentWords' },
        -- WSDelimiterRed = { bg = '#292736' },
        -- WSDelimiterYellow = { bg = '#313739' },
        -- WSDelimiterBlue = { bg = '#212E3F' },
        -- WSDelimiterOrange = { bg = '#2D2F34' },
        -- WSDelimiterGreen = { bg = '#22303A' },
        -- WSDelimiterViolet = { bg = '#2A2B3F' },
        -- WSDelimiterCyan = { bg = '#20323E' },
      },
    },
  })
  vim.cmd('colo ' .. variant)
  local palette = require('nightfox.palette.' .. variant).palette
  vim.api.nvim_set_hl(
    0,
    '@text.uri',
    { fg = palette.orange.base, underline = false, italic = true }
  )
end

function M.everforest()
  vim.g.everforest_background = 'medium'

  local group = vim.api.nvim_create_augroup('EverforestCustom', {
    clear = true,
  })
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    pattern = 'everforest',
    callback = M.custom,
  })

  vim.cmd('colo everforest')
end

function M.custom()
  local p = vim.fn['everforest#get_palette'](
    vim.g.everforest_background,
    vim.empty_dict()
  )

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

  hl('gitblame', p.grey1, p.bg1, { 'italic' })

  hl('VirtualTextInfo', nil, p.bg1)
  hl('VirtualTextHint', p.blue, p.bg1)
  hl('VirtualTextError', p.red, p.bg1)
  hl('VirtualTextWarning', p.orange, p.bg1)

  hl('IndentBlanklineChar', p.bg1, nil)
end

return M
