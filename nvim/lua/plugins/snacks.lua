local header = table.concat({
  '░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░',
  '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░',
  '░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░    ░▒▓██████▓▒░ ',
  '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░    ',
  '░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░    ',
}, '\n')

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { preset = { header = header } },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = false },
    picker = { ui_select = true },
  },
  keys = {
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete buffer' },
    { '<leader>go', function() Snacks.gitbrowse() end, desc = 'Open in browser' },
    { '<leader>lg', function() Snacks.lazygit() end, desc = 'LazyGit' },
    { '<leader>T', function() Snacks.terminal.toggle() end, desc = 'Toggle terminal' },
  },
  init = function()
    _G.dd = function(...)
      require('snacks').debug.inspect(...)
    end
    _G.bt = function()
      require('snacks').debug.backtrace()
    end
    vim.print = _G.dd
  end,
  config = function(_, opts)
    require('snacks').setup(opts)
    vim.api.nvim_create_user_command('LazyGit', function()
      Snacks.lazygit()
    end, {})
  end,
}
