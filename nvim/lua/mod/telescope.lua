local vim = vim

local telescope = require 'telescope'
local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'

local M = {}

function M.grep(q)
  -- builtin.grep_string {search = q, prompt_prefix = q .. ' >'}
  M.grep_string_filtered {search = q, prompt_prefix = q .. ' >'}
end

M.grep_string_filtered = function(opts)
  local conf = require('telescope.config').values
  local search = opts.search or vim.fn.expand('<cword>')

  opts.entry_maker = opts.entry_maker or require'telescope.make_entry'.gen_from_vimgrep(opts)
  opts.word_match = opts.word_match or nil

  local sorter = require'telescope.sorters'.get_generic_fuzzy_sorter(opts)
  local original_scoring_function = sorter.scoring_function
  sorter.scoring_function = function(a, prompt, line, b)
    if prompt == 0 or #prompt < (opts.ngram_len or 2) then return 0 end
    local l = line:gsub('^.*:%d*:%d:', '')
    return original_scoring_function(a, prompt, l, b)
  end

  local original_highlighter = sorter.highlighter
  sorter.highlighter = function(a, prompt, line)
    local _, idx = line:find('^.*:%d*:%d:')
    local ll = line:sub(1, idx):gsub('.', ' ')
    local lr = line:sub(idx + 1)
    return original_highlighter(a, prompt, ll .. lr)
  end

  require'telescope.pickers'.new(opts, {
    prompt_title = 'Find Word',
    finder = require'telescope.finders'.new_oneshot_job(
        vim.tbl_flatten {conf.vimgrep_arguments, opts.word_match, search}, opts),
    previewer = conf.grep_previewer(opts),
    sorter = sorter,
  }):find()
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
