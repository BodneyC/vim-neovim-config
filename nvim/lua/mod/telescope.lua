local vim = vim

local telescope = require 'telescope'
local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'

local M = {}

function M.grep(q)
  builtin.grep_string {search = q, prompt_prefix = q .. ' >'}
end

function M.init()
  telescope.setup {
    defaults = {
      mappings = {i = {['<Esc>'] = actions.close, ['<C-u>'] = false}},
      prompt_position = 'top',
      sorting_strategy = 'ascending',
      vimgrep_arguments = {
        'rg', '--hidden', '--ignore-vcs', '--color=never', '--no-heading', '--with-filename',
        '--line-number', '--column', '--smart-case',
      },
      prompt_prefix = '>',
      selection_strategy = 'reset',
      layout_strategy = 'horizontal',
      layout_defaults = {
        -- TODO add builtin options.
      },
      file_sorter = require'telescope.sorters'.get_fuzzy_file,
      file_ignore_patterns = {
        '.lsp', '.clj-kondo', 'node_modules', 'package-lock.json', 'yarn.lock', '.git',
      },
      generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
      shorten_path = true,
      winblend = 0,
      width = 0.75,
      preview_cutoff = 120,
      results_height = 1,
      results_width = 0.8,
      border = {},
      borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
      color_devicons = true,
      use_less = true,
      set_env = {['COLORTERM'] = 'truecolor'}, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
      file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
      grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
      qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
    },
  }
end

return M
