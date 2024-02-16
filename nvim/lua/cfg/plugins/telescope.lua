local util = require('utl.util')
local telescope = require('telescope')

local histdir = os.getenv('HOME') .. '/.local/share/nvim/databases'
if vim.fn.isdirectory(histdir) == 0 then
  os.execute('mkdir -p ' .. histdir)
end

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').cycle_history_next,
        ['<C-k>'] = require('telescope.actions').cycle_history_prev,
        ['<C-w>'] = function() vim.api.nvim_input '<C-S-w>' end,
        ['<C-u>'] = function() vim.api.nvim_input '<C-S-u>' end,
      },
      n = {
        ['j'] = require('telescope.actions').cycle_history_next,
        ['k'] = require('telescope.actions').cycle_history_prev,
      },
    },
    history = {
      path = histdir .. '/telescope_history.sqlite3',
      limit = 100,
    },
    sorting_strategy = 'ascending',
    vimgrep_arguments = {
      'rg', '--color=never', '--column', '--glob=!**/*.class',
      '--glob=!**/target/**', '--glob=!.git/**', '--glob=!.vim/**', '--hidden',
      '--line-number', '--no-heading', '--smart-case', '--with-filename',
    },
    prompt_prefix = '$ ',
    selection_strategy = 'reset',
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = 'top',
      horizontal = {
        prompt_position = 'top',
        width_padding = 0.1,
        height_padding = 0.2,
        preview_width = 0.6,
        mirror = false,
      },
      vertical = { mirror = true },
    },
    file_ignore_patterns = {
      [[\.cache]], [[\.lsp]], [[\.clj-kondo]], [[node_modules]],
      [[package-lock\.json]], [[yarn\.lock]], [[\.git]],
    },
    path_display = { 'absolute' },
    winblend = 0,
    border = {},
    -- borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    borderchars = { '', '', '', '', '', '', '', '' },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
  },
}
telescope.load_extension('fzy_native')
telescope.load_extension('live_grep_args')
telescope.load_extension('ui-select')
telescope.load_extension('smart_history')

-- mappings
util.command('Rg',
  [[lua require('telescope.builtin').grep_string{ search = <f-args> }]],
  { nargs = '1' })

local mapper = require('utl.mapper')
local map = mapper({ noremap = true, silent = true })

local ldr = '<leader>T'
local builtin = require('telescope.builtin')

map('n', ldr .. 's', builtin.git_status, 'Git status')
map('n', ldr .. 'b', builtin.git_branches, 'Git branches')
map('n', ldr .. 'c', builtin.git_commits, 'Git commits')
map('n', ldr .. 'r', builtin.registers, 'Registers')
map('n', ldr .. 'm', builtin.keymaps, 'Keymaps')
map('n', ldr .. 'd', builtin.lsp_document_symbols, 'LSP doc symbols')
map('n', ldr .. 'w', builtin.lsp_workspace_symbols, 'LSP workspace symbols')
map('n', ldr .. 'M', builtin.marks, 'Marks')
map('n', '<leader>s', require('session-lens').search_session, 'Search session')
map('n', '<leader>r', function()
  builtin.live_grep { search = '', path_display = { 'smart' } }
end, 'Search text')
map('n', '<leader>f', function()
  builtin.fd { find_command = { 'fd', '-tf', '-H' } }
end, 'Search files')
map('n', '<leader>bl', builtin.buffers, 'List buffers')
map('n', '<M-]>', builtin.grep_string, 'Grep string')
map('n', '‘', builtin.grep_string, 'Grep string')
