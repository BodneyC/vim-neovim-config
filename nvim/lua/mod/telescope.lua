local vim = vim

local telescope = require 'telescope'
local config = require 'telescope.config'
local sorters = require 'telescope.sorters'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local make_entry = require 'telescope.make_entry'
local previewers = require 'telescope.previewers'

local M = {}

M.grep_string_filtered = function(opts)
  local conf = config.values
  local search = opts.search or vim.fn.expand('<cword>')

  local rg_rgx = '^[^:]*:%d*:?%d*:?'

  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)
  opts.word_match = opts.word_match or nil

  local sorter = sorters.get_fzy_sorter()
  local original_scoring_function = sorter.scoring_function
  sorter.scoring_function = function(a, prompt, line, b)
    if prompt == 0 or #prompt < (opts.ngram_len or 2) then return 0 end
    local l = line:gsub(rg_rgx, '')
    return original_scoring_function(a, prompt, l, b)
  end

  local original_highlighter = sorter.highlighter
  sorter.highlighter = function(a, prompt, line)
    local _, idx = line:find(rg_rgx)
    if idx then
      local ll = line:sub(1, idx):gsub('.', ' ')
      local lr = line:sub(idx + 1):lower()
      line = ll .. lr
    end
    return original_highlighter(a, prompt, line)
  end

  pickers.new(opts, {
    prompt_title = 'Find Word',
    finder = finders.new_oneshot_job(vim.tbl_flatten {
      conf.vimgrep_arguments, opts.word_match, search,
    }, opts),
    previewer = conf.grep_previewer(opts),
    sorter = sorter,
  }):find()
end

M.init = function()
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
      file_ignore_patterns = {
        '\\.lsp', '\\.clj-kondo', 'node_modules', 'package-lock\\.json', 'yarn\\.lock', '\\.git',
      },
      shorten_path = true,
      winblend = 20,
      width = 0.75,
      preview_cutoff = 120,
      results_height = 1,
      results_width = 0.8,
      border = {},
      borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
      color_devicons = true,
      use_less = true,
      set_env = {['COLORTERM'] = 'truecolor'},
      file_previewer = previewers.cat.new,
      grep_previewer = previewers.vimgrep.new,
      qflist_previewer = previewers.qflist.new,
      fzy_native = {override_generic_sorter = true, override_file_sorter = true},
    },
  }
  telescope.load_extension('fzy_native')
end

return M
