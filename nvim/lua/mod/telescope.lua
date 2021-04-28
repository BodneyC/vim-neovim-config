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

M.tags_absolute = function(opts)
  local conf = config.values
  local ctags_file = vim.bo.tags:split(',')[1] or 'tags'

  if not vim.loop.fs_open(vim.fn.expand(ctags_file, true), "r", 438) then
    print('Tags file does not exists. Create one with ctags -R')
    return
  end

  local fd = assert(vim.loop.fs_open(vim.fn.expand(ctags_file, true), "r", 438))
  local stat = assert(vim.loop.fs_fstat(fd))
  local data = assert(vim.loop.fs_read(fd, stat.size, 0))
  assert(vim.loop.fs_close(fd))

  -- Literally, the only changed data...
  local home = os.getenv('HOME')
  data = data:gsub('../../..', home)

  local results = vim.split(data, '\n')

  pickers.new(opts,{
    prompt = 'Tags',
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_ctags(opts),
    },
    previewer = previewers.ctags.new(opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function()
      actions._goto_file_selection:enhance {
        post = function()
          local selection = actions.get_selected_entry()

          if selection.scode then
            local scode = string.gsub(selection.scode, '[$]$', '')
            scode = string.gsub(scode, [[\\]], [[\]])
            scode = string.gsub(scode, [[\/]], [[/]])
            scode = string.gsub(scode, '[*]', [[\*]])

            vim.cmd('norm! gg')
            vim.fn.search(scode)
            vim.cmd('norm! zz')
          else
            vim.api.nvim_win_set_cursor(0, {selection.lnum, 0})
          end
        end,
      }
      return true
    end
  }):find()
end

local escape_chars = function(string)
  return string.gsub(string,  "[%(|%)|\\|%[|%]|%-|%{%}|%?|%+|%*]", {
    ["\\"] = "\\\\", ["-"] = "\\-",
    ["("] = "\\(", [")"] = "\\)",
    ["["] = "\\[", ["]"] = "\\]",
    ["{"] = "\\{", ["}"] = "\\}",
    ["?"] = "\\?", ["+"] = "\\+",
    ["*"] = "\\*",
  })
end

M.grep_string_filtered = function(opts)
  local conf = config.values

  local search = escape_chars(opts.search or vim.fn.expand('<cword>'))
  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments

  local word_match = opts.word_match
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)

  local rg_rgx = '^[^:]*:%d*:?%d*:?'

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

  local args = vim.tbl_flatten {
    vimgrep_arguments,
    word_match,
    search,
  }

  -- print(vim.inspect(vim.tbl_flatten {conf.vimgrep_arguments, opts.word_match, search}))
  pickers.new(opts, {
    prompt_title = 'Find Word',
    finder = finders.new_oneshot_job(args, opts),
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
        'rg', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case',
        '--glob', '!.git/**', '--glob', '!.vim/**', '--glob', '!**/target/**', '--glob', '!**/*.class',
      },
      prompt_prefix = '>',
      selection_strategy = 'reset',
      layout_strategy = 'horizontal',
      layout_defaults = {
        -- TODO add builtin options.
      },
      file_ignore_patterns = {
        '\\.cache', '\\.lsp', '\\.clj-kondo', 'node_modules', 'package-lock\\.json', 'yarn\\.lock', '\\.git',
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

  local n_s = {noremap = true, silent = true}
  local skm = vim.api.nvim_set_keymap
  require'utl.util'.command('Rg', [[lua require'mod.telescope'.grep(<f-args>)]], {nargs = '1'})
  skm('n', '<leader>gs', [[<CMD>Telescope git_status<CR>]], n_s)
  skm('n', '<leader>gb', [[<CMD>Telescope git_branches<CR>]], n_s)
  skm('n', '<leader>gc', [[<CMD>Telescope git_commits<CR>]], n_s)
  skm('n', '<leader>gr', [[<CMD>Telescope registers<CR>]], n_s)
  skm('n', '<leader>m', [[<CMD>Telescope keymaps<CR>]], n_s)
  skm('n', '<leader>p', [[<CMD>lua require'telescope'.extensions.packer.plugins(opts)<CR>]], n_s)
  skm('n', '<leader>ld', [[<CMD>Telescope lsp_document_symbols<CR>]], n_s)
  skm('n', '<leader>lw', [[<CMD>Telescope lsp_workspace_symbols<CR>]], n_s)
  skm('n', '<leader>ga', [[<CMD>Telescope lsp_code_actions<CR>]], n_s)
  skm('n', '<leader>M', [[<CMD>Telescope marks<CR>]], n_s)
  skm('n', '<leader>r', [[<CMD>lua require'mod.telescope'.grep_string_filtered ]] ..
      [[ { search = '', disable_coordinates = true, shorten_path = true, }<CR>]], {noremap = true})
  skm('n', '<leader>f',
      [[<CMD>lua require'telescope.builtin'.fd { find_command = { 'fd', '-tf', '-H' } }<CR>]], n_s)
  skm('n', '<leader>bl', [[<CMD>Telescope buffers<CR>]], n_s)

  -- Gets better results than the builtin
  local grep_string_under_cursor = [[<CMD>lua local s = vim.fn.expand('<cword>'); ]] ..
                                       [[require'telescope.builtin'.grep_string { ]] ..
                                       [[ search = s, prompt_prefix = s .. ' >', ]] ..
                                       [[ ngram_len = 1, }<CR>]]
  skm('n', '<M-]>', grep_string_under_cursor, n_s)
  skm('n', '‘', grep_string_under_cursor, n_s)

  skm('n', '<M-[>', [[<CMD>lua require'mod.telescope'.tags_absolute {shorten_path = true} <CR> ]], n_s)

end

return M
