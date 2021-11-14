local util = require('utl.util')

vim.cmd 'filetype off'

-- if vim.g.nvui then
--   vim.cmd [[NvuiCmdFontFamily Iosevka Nerd Font]]
--   vim.cmd [[NvuiScrollAnimationDuration 0.1]]
-- end

vim.g.fzf_history_dir = os.getenv('HOME') .. '/.cache/nvim/fzf/.fzf_history_dir'

util.safe_require('cfg.packer')

util.safe_require('cfg.options')
util.safe_require('cfg.augroups')
util.safe_require('cfg.remappings')
util.safe_require('cfg.commands')

util.safe_require('cfg.plugins')
util.safe_require('cfg.lsp')
util.safe_require('cfg.dap')

util.safe_require_and_init('mod.terminal')
util.safe_require_and_init('mod.vim-test')
