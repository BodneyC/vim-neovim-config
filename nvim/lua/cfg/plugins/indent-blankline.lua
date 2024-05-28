return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    local highlight = {
      'RainbowRed',
      'RainbowYellow',
      'RainbowBlue',
      'RainbowOrange',
      'RainbowGreen',
      'RainbowViolet',
      'RainbowCyan',
    }

    local hooks = require('ibl.hooks')
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for _, prefix in ipairs({ '', 'TS' }) do
        vim.api.nvim_set_hl(0, prefix .. 'RainbowRed', { fg = '#BB5A61' })
        vim.api.nvim_set_hl(0, prefix .. 'RainbowYellow', { fg = '#BE9F66' })
        vim.api.nvim_set_hl(0, prefix .. 'RainbowBlue', { fg = '#5090C4' })
        vim.api.nvim_set_hl(0, prefix .. 'RainbowOrange', { fg = '#A0764E' })
        vim.api.nvim_set_hl(0, prefix .. 'RainbowGreen', { fg = '#77995F' })
        vim.api.nvim_set_hl(0, prefix .. 'RainbowViolet', { fg = '#945BA5' })
        vim.api.nvim_set_hl(0, prefix .. 'RainbowCyan', { fg = '#3E838C' })
      end
    end)

    require('ibl').setup({
      exclude = {
        filetypes = {
          'packer',
          'floaterm',
          'help',
          'Outline',
          'NvimTree',
          'neo-tree',
          '',
        },
      },
      scope = { show_start = false, show_end = false },
      indent = { char = '│', highlight = highlight },
    })
  end
}
