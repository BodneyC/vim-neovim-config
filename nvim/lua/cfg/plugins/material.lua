return {
  'marko-cerovac/material.nvim',
  lazy = false,
  config = function()
    -- order matters here...
    vim.g.material_style = 'darker'
    local colors = require('material.colors')

    require('material').setup({

      contrast = {
        terminal = true,             -- Enable contrast for the built-in terminal
        sidebars = true,             -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false,    -- Enable contrast for floating windows
        cursor_line = false,         -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable contrasted background for non-current windows
        filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
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
        borders = true,        -- Disable borders between verticaly split windows
        background = false,    -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false,   -- Prevent the theme from setting terminal colors
        eob_lines = true,      -- Hide the end-of-buffer lines
      },

      high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = true,   -- Enable higher contrast text for darker style
      },

      lualine_style = 'stealth', -- Lualine style ( can be 'stealth' or 'default' )

      async_loading = true,      -- Load parts of the theme asyncronously for faster startup (turned on by default)

      custom_colors = nil,       -- If you want to override the default colors, set this to a function

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
  ,
}
