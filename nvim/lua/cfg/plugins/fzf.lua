local mapper = require('utl.mapper')
local map = mapper({ noremap = true, silent = true })

local fzf = require 'fzf-lua'

-- Vim
map('n', [[\r]], fzf.registers, 'Registers')
map('n', [[\h]], fzf.help_tags, 'Help tags')
map('n', [[\m]], fzf.keymaps, 'Keymaps')
map('n', [[\M]], fzf.marks, 'Marks')

-- Git
map('n', [[\gd]], fzf.git_status, 'Git status') -- gd for git diff
map('n', [[\gs]], fzf.git_status, 'Git status')
map('n', [[\gf]], fzf.git_files, 'Git files')
map('n', [[\gt]], fzf.git_tags, 'Git tags')
map('n', [[\gb]], fzf.git_branches, 'Git branches')
map('n', [[\gc]], fzf.git_commits, 'Git commits')

-- LSP
map('n', [[\a]], fzf.lsp_code_actions, 'LSP code actions')
map('n', [[\f]], fzf.lsp_finder, 'LSP finder')
map('n', [[\ld]], fzf.lsp_document_symbols, 'LSP doc symbols')
map('n', [[\lw]], fzf.lsp_workspace_symbols, 'LSP workspace symbols')

-- Daily
map('n', '<space>r', fzf.live_grep, 'Search text')
map('n', '<space>f', fzf.files, 'Search files')
map('n', '<space>bl', fzf.buffers, 'List buffers')

local function grep_cword()
  local cword = vim.fn.expand('<cword>')
  fzf.grep_cword { prompt = 'Rg (' .. cword .. ')❯ ' }
end

map('n', '<M-]>', grep_cword, 'Grep string')
map('n', '‘', grep_cword, 'Grep string')

return {
  winopts = {
    height  = 0.90,
    width   = 0.92,
    row     = 0.35,
    col     = 0.50,
    border  = {
      { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' },
      { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' },
      { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' },
    },
    -- border           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    preview = {
      border       = 'noborder',
      wrap         = 'nowrap',
      hidden       = 'nohidden',
      vertical     = 'down:45%',
      horizontal   = 'right:58%',
      layout       = 'flex',
      flip_columns = 120,
    },
  },
  hls = {
    preview_normal = 'TabLineFill',
    preview_border = 'TabLineFill',
  },
}
