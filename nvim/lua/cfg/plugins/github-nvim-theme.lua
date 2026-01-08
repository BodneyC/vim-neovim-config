return {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local spec = require('github-theme.palette').load('github_dark_dimmed')
    require('github-theme').setup({
      groups = {
        github_dark_dimmed = {
          Search = { bg = spec.accent.subtle },
          MatchParen = { link = 'Search' }
        }
      }
    })

    vim.cmd('colorscheme github_dark_dimmed')
  end,
}
