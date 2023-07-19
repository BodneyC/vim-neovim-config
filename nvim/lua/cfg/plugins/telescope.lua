local util = require('utl.util')
local telescope = require('telescope')

local vimgrep_arguments = {
  'rg',
  '--hidden',
  '--color=never',
  '--no-heading',
  '--with-filename',
  '--line-number',
  '--column',
  '--smart-case',
  '--glob',
  '!.git/**',
  '--glob',
  '!.vim/**',
  '--glob',
  '!**/target/**',
  '--glob',
  '!**/*.class',
 }

local file_ignore_patterns = {
  '\\.cache',
  '\\.lsp',
  '\\.clj-kondo',
  'node_modules',
  'package-lock\\.json',
  'yarn\\.lock',
  '\\.git',
 }

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').cycle_history_prev,
        ['<C-k>'] = require('telescope.actions').cycle_history_next,
        ['<C-w>'] = function() vim.api.nvim_input '<C-S-w>' end,
        ['<C-u>'] = function() vim.api.nvim_input '<C-S-u>' end,
       },
     },
    sorting_strategy = 'ascending',
    vimgrep_arguments = vimgrep_arguments,
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
    file_ignore_patterns = file_ignore_patterns,
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

-- mappings
util.command('Rg',
  [[lua require('telescope.builtin').grep_string{ search = <f-args> }]],
  { nargs = '1' })

local tele_leader = '<leader>T'
local builtin = require('telescope.builtin')

local mapper = require('utl.mapper')
local map = mapper({ noremap = true, silent = true })

map('n', tele_leader .. 's', builtin.git_status, 'Git status')
map('n', tele_leader .. 'b', builtin.git_branches, 'Git branches')
map('n', tele_leader .. 'c', builtin.git_commits, 'Git commits')
map('n', tele_leader .. 'r', builtin.registers, 'Registers')
map('n', tele_leader .. 'm', builtin.keymaps, 'Keymaps')
map('n', tele_leader .. 'd', builtin.lsp_document_symbols, 'LSP doc symbols')
map('n', tele_leader .. 'w', builtin.lsp_workspace_symbols, 'LSP workspace symbols')
map('n', tele_leader .. 'M', builtin.marks, 'Marks')
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
