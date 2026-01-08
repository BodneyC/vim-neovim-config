return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile      = { enabled = true },
    bufdelete    = { enabled = true },
    dashboard    = {
      preset = {
        header =
            "░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░\n" ..
            "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░\n" ..
            "░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░    ░▒▓██████▓▒░ \n" ..
            "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░    \n" ..
            "░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░    "
      },
    },
    debug        = { enabled = true },
    git          = { enabled = true },
    gitbrowse    = { enabled = true },
    lazygit      = { enabled = true },
    notify       = { enabled = true },
    notifier     = { enabled = true },
    quickfile    = { enabled = true },
    rename       = { enabled = true },
    statuscolumn = { enabled = true },
    terminal     = { enabled = true },
    toggle       = { enabled = true },
    win          = { enabled = true },
    words        = { enabled = false },
  },
  init = function()
    local snacks = require('snacks')
    _G.dd = function(...) snacks.debug.inspect(...) end
    _G.bt = function() snacks.debug.backtrace() end
    vim.print = _G.dd
    vim.keymap.set('n', '<leader>go', function() snacks.gitbrowse() end, { noremap = true })
  end
}
