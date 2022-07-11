local util = require('utl.util')

local telescope = require('telescope')
local action_set = require('telescope.actions.set')
local action_state = require('telescope.actions.state')
local config = require('telescope.config')
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local make_entry = require('telescope.make_entry')
local previewers = require('telescope.previewers')

local M = {}

function M.tags_absolute(opts)
  local conf = config.values
  local ctags_file = vim.bo.tags:split(',')[1] or 'tags'

  if not vim.loop.fs_open(vim.fn.expand(ctags_file, true), 'r', 438) then
    print('Tags file does not exists. Create one with ctags -R')
    return
  end

  local fd = assert(vim.loop.fs_open(vim.fn.expand(ctags_file, true), 'r', 438))
  local stat = assert(vim.loop.fs_fstat(fd))
  local data = assert(vim.loop.fs_read(fd, stat.size, 0))
  assert(vim.loop.fs_close(fd))

  -- Literally, the only changed data...
  local home = os.getenv('HOME')
  data = data:gsub('../../..', home)

  local results = vim.split(data, '\n')

  -- picker
  pickers.new(opts, {
    prompt = 'Tags',
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_ctags(opts),
    },
    previewer = previewers.ctags.new(opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function()
      action_set.select:enhance{
        post = function()
          local selection = action_state.get_selected_entry()

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
    end,
  }):find()

end

local function escape_chars(string)
  return string.gsub(string, '[%(|%)|\\|%[|%]|%-|%{%}|%?|%+|%*]', {
    ['\\'] = '\\\\',
    ['-'] = '\\-',
    ['('] = '\\(',
    [')'] = '\\)',
    ['['] = '\\[',
    [']'] = '\\]',
    ['{'] = '\\{',
    ['}'] = '\\}',
    ['?'] = '\\?',
    ['+'] = '\\+',
    ['*'] = '\\*',
  })
end

M.histfile = os.getenv('HOME') .. '/.cache/nvim/telescope.histfile'

local prompt_hist = ''
local histfile_idx = -1

function M.grep_string_filtered(opts)
  local conf = config.values

  histfile_idx = -1
  prompt_hist = ''

  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
  local search_dirs = opts.search_dirs
  local word = opts.search or vim.fn.expand('<cword>')
  local search = opts.use_regex and word or escape_chars(word)
  local word_match = opts.word_match
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)

  local args = vim.tbl_flatten {vimgrep_arguments, word_match, search}

  if search_dirs then
    for _, path in ipairs(search_dirs) do
      table.insert(args, vim.fn.expand(path))
    end
  else
    table.insert(args, '.')
  end

  local rg_rgx = '^[^:]*:%d*:?%d*:?'

  local sorter = sorters.get_fzy_sorter()
  local original_scoring_function = sorter.scoring_function
  sorter.scoring_function = function(a, prompt, line, b)
    if prompt == 0 or #prompt < (opts.ngram_len or 2) then
      return 0
    end
    prompt_hist = prompt
    local l = line:gsub(rg_rgx, '')
    return original_scoring_function(a, prompt, l, b)
  end

  pickers.new(opts, {
    prompt_title = 'Find Word',
    finder = finders.new_oneshot_job(args, opts),
    previewer = conf.grep_previewer(opts),
    sorter = sorter,
  }):find()
end

local function read_hist_file()
  local f = io.open(M.histfile, 'r')
  if not f then
    return nil
  end
  local arr = {}
  for line in f:lines() do
    table.insert(arr, line);
  end
  f:close()
  return arr
end

function actions.hist_f(dir)
  return function(_)
    if M.euid == '0' then
      return
    end
    local arr = read_hist_file()
    if not arr then
      return
    end
    if histfile_idx == -1 or histfile_idx > #arr then
      histfile_idx = #arr + (dir == 'prev' and 1 or 0)
    end
    if histfile_idx ~= (dir == 'prev' and 1 or #arr) then
      histfile_idx = histfile_idx + (dir == 'prev' and -1 or 1)
    end
    if not arr[histfile_idx] then
      return
    end
    util.feedkeys('<C-u>' .. arr[histfile_idx], 'n')
  end
end

function actions.append_to_hist(prompt_bufnr)
  if M.euid == '0' then
    return
  end
  if prompt_hist ~= '' then
    local f = io.open(M.histfile, 'a+')
    local len = f:seek('end')
    f:seek('set', len - 128)
    local last_chunk = f:read('*a')
    if last_chunk:match(prompt_hist .. '*%s*$') then
      print('Repeated search term, not writing to histfile')
    else
      f:write(prompt_hist .. '\n')
    end
    f:close()
  end

  -- temp pending: https://github.com/nvim-telescope/telescope.nvim/issues/684
  actions.select_default(prompt_bufnr)
  actions.center(prompt_bufnr)
end

function M.init()
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

  M.euid = util.run_cmd('id -u', true)

  telescope.setup {
    defaults = {
      mappings = {
        i = {
          -- ['<Esc>'] = actions.close,
          -- ['<C-u>'] = false,
          ['<C-j>'] = actions.hist_f('prev'),
          ['<C-k>'] = actions.hist_f('next'),
          ['<CR>'] = actions.append_to_hist,
          ['<C-w>'] = function()
            vim.cmd [[normal! db]]
          end,
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
        vertical = {
          mirror = true,
        },
      },
      file_ignore_patterns = file_ignore_patterns,
      path_display = {'absolute'},
      winblend = 0,
      border = {},
      -- borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
      borderchars = {'', '', '', '', '', '', '', ''},
      color_devicons = true,
      set_env = {
        ['COLORTERM'] = 'truecolor',
      },
    },
  }
  telescope.load_extension('fzy_native')
  telescope.load_extension('live_grep_args')
  telescope.load_extension('ui-select')

  -- mappings
  local flags = require('utl.maps').flags
  local skm = vim.api.nvim_set_keymap
  util.command('Rg', [[lua require('mod.telescope').grep(<f-args>)]], {
    nargs = '1',
  })
  local tele_leader = '<leader>T'
  skm('n', tele_leader .. 's', [[<CMD>Telescope git_status<CR>]], flags.ns)
  skm('n', tele_leader .. 'b', [[<CMD>Telescope git_branches<CR>]], flags.ns)
  skm('n', tele_leader .. 'c', [[<CMD>Telescope git_commits<CR>]], flags.ns)
  skm('n', tele_leader .. 'r', [[<CMD>Telescope registers<CR>]], flags.ns)
  skm('n', tele_leader .. 'm', [[<CMD>Telescope keymaps<CR>]], flags.ns)
  skm('n', tele_leader .. 'd', [[<CMD>Telescope lsp_document_symbols<CR>]],
    flags.ns)
  skm('n', tele_leader .. 'w', [[<CMD>Telescope lsp_workspace_symbols<CR>]],
    flags.ns)
  skm('n', tele_leader .. 'a', [[<CMD>Telescope lsp_code_actions<CR>]], flags.ns)
  skm('n', tele_leader .. 'M', [[<CMD>Telescope marks<CR>]], flags.ns)

  skm('n', '<leader>s', [[<CMD>lua require('session-lens').search_session()<CR>]], flags.ns)
  skm('n', '<leader>r',
    [[<CMD>lua require('mod.telescope').grep_string_filtered ]] ..
      [[ { search = '', disable_coordinates = true, path_display = {'tail'}, }<CR>]],
    flags.n)
  skm('n', '<leader>f', [[<CMD>lua require('telescope.builtin').fd]] ..
    [[ { find_command = { 'fd', '-tf', '-H' } }<CR>]], flags.ns)
  skm('n', '<leader>bl', [[<CMD>Telescope buffers<CR>]], flags.ns)

  -- Gets better results than the builtin
  local grep_string_under_cursor =
    [[<CMD>lua local s = vim.fn.expand('<cword>'); ]] ..
      [[require('telescope.builtin').grep_string { ]] ..
      [[ search = s, prompt_prefix = s .. ' > ', ]] .. [[ ngram_len = 1, }<CR>]]
  skm('n', '<M-]>', grep_string_under_cursor, flags.ns)
  skm('n', '‘', grep_string_under_cursor, flags.ns)

  skm('n', '<M-[>',
    [[<CMD>lua require('mod.telescope').tags_absolute {} <CR> ]], flags.ns)

end

return M
