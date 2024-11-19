return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile      = { enabled = true },
    bufdelete    = { enabled = true },
    dashboard    = { enabled = true },
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
    _G.dd = function(...)
      require('snacks').debug.inspect(...)
    end
    _G.bt = function()
      require('snacks').debug.backtrace()
    end
    vim.print = _G.dd
  end
}
