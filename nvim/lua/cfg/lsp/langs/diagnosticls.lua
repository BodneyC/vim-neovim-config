local home = vim.loop.os_homedir()
return {
  filetypes = { 'pkgbuild', 'terraform', 'markdown' },
  init_options = {
    filetypes = {
      pkgbuild = 'pkgbuild',
      terraform = 'terraform',
      markdown = 'markdown',
    },
    formatFiletypes = { sh = 'shfmt', zsh = 'shfmt' },
    -- package-manager - shfmt
    formatters = {
      shfmt = { args = { '-i=2', '-bn', '-ci', '-sr' }, command = 'shfmt' },
    },
    linters = {
      markdown = {
        -- npm i -g markdownlint
        command = 'sh',
        -- This is a real ugly hack:
        --  markdownlint doesn't provide a column if at the start of the line
        --  This sed expression adds that column number if not present
        --  Something decrements the given value, likely diagnosticls, so it has to be 1
        --  But if it's 1 (0 after decrementing) and the line is empty, Lspsaga removes
        --   the field from the diagnostic entry which causes the nvim_win_set_cursor error
        --  Hence, 2, to be decremented once and later treated as a 0...
        args = { '-c', [[markdownlint --stdin 2>&1 | sed 's/\(^[^:]\+:[0-9]\+\) /\1:2 /']] },
        isStderr = false,
        isStdout = true,
        formatPattern = {
          -- README.md:3:81 MD013/line-length Line length [Expected: 80; Actual: 282]
          '^[^:]+(:)(\\d+):(\\d+)\\s+(.*)$',
          { security = 1, line = 2, column = 3, message = 4 },
        },
        offsetColumn = 0,
        offsetLine = 0,
        securities = { error = 'error', note = 'info', warning = ':' },
        sourceName = 'markdown',
      },
      pkgbuild = {
        args = { '%file' },
        -- manual - vim-pkgbuild
        command = home ..
            '/.local/share/nvim/plugged/vim-pkgbuild/scripts/shellcheck_pkgbuild.sh',
        formatPattern = {
          '^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$',
          { column = 2, line = 1, message = 4, security = 3 },
        },
        securities = { error = 'error', note = 'info', warning = 'warning' },
        sourceName = 'pkgbuild',
      },
    }
  }
}
