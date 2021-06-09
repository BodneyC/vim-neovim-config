local vim = vim

local util = require 'utl.util'

-- imports -s-
local telescope = require 'telescope'
local action_set = require('telescope.actions.set')
local action_state = require('telescope.actions.state')
local config = require 'telescope.config'
local sorters = require 'telescope.sorters'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local make_entry = require 'telescope.make_entry'
local previewers = require 'telescope.previewers'
-- -e-

local M = {}

function M.tags_absolute(opts) -- -s-
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

  -- picker -s-
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
  -- -e-
end -- -e-

local function escape_chars(string) -- -s-
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
end -- -e-

M.histfile = os.getenv('HOME') .. '/.cache/nvim/telescope.histfile'

local tmpfile = '/tmp/telescope.histfile'
local histfile_idx = -1

function M.grep_string_filtered(opts) -- -s-
  local conf = config.values

  histfile_idx = -1

  local search = escape_chars(opts.search or vim.fn.expand('<cword>'))
  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments

  local word_match = opts.word_match
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)

  local rg_rgx = '^[^:]*:%d*:?%d*:?'

  local sorter = sorters.get_fzy_sorter() -- -s-
  local original_scoring_function = sorter.scoring_function
  sorter.scoring_function = function(a, prompt, line, b)
    if prompt == 0 or #prompt < (opts.ngram_len or 2) then return 0 end
    local file = io.open(tmpfile, 'w')
    file:write(prompt)
    file:close()
    local l = line:gsub(rg_rgx, '')
    return original_scoring_function(a, prompt, l, b)
  end -- -e-

  -- highligher -s-
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
  -- -e-

  local args = vim.tbl_flatten {vimgrep_arguments, word_match, search}

  pickers.new(opts, { -- -s-
    prompt_title = 'Find Word',
    finder = finders.new_oneshot_job(args, opts),
    previewer = conf.grep_previewer(opts),
    sorter = sorter,
  }):find() -- -e-
end -- -e-

local function read_hist_file() -- -s-
  if M.euid == '0' then return end
  local f = io.open(M.histfile, 'r')
  if not f then return nil end
  local arr = {}
  for line in f:lines() do table.insert(arr, line); end
  f:close()
  return arr
end -- -e-

function actions.prev_hist(prompt_bufnr) -- -s-
  if M.euid == '0' then return end
  local arr = read_hist_file()
  if not arr then return end
  if histfile_idx == -1 or histfile_idx > #arr then histfile_idx = #arr + 1 end
  if histfile_idx ~= 1 then histfile_idx = histfile_idx - 1 end
  if not arr[histfile_idx] then return end
  vim.api.nvim_input('<C-u>' .. arr[histfile_idx])
  if histfile_idx == 1 then return end
end -- -e-

function actions.next_hist(prompt_bufnr) -- -s-
  if M.euid == '0' then return end
  local arr = read_hist_file()
  if not arr then return end
  if histfile_idx == -1 or histfile_idx > #arr then histfile_idx = #arr end
  if histfile_idx ~= #arr then histfile_idx = histfile_idx + 1 end
  if not arr[histfile_idx] then return end
  vim.api.nvim_input('<C-u>' .. arr[histfile_idx])
end -- -e-

function actions.append_to_hist(prompt_bufnr) -- -s-
  if M.euid == '0' then return end
  local f = io.open(tmpfile, 'r')
  local fl = f:read('*a')
  f:close()
  if fl and not fl:match('^%s*$') then
    f = io.open(tmpfile, 'w')
    f:close()
    f = io.open(M.histfile, 'a+')
    f:write(fl .. '\n')
    f:close()
  end

  -- temp pending: https://github.com/nvim-telescope/telescope.nvim/issues/684
  actions.select_default(prompt_bufnr)
  actions.center(prompt_bufnr)
end -- -e-

function M.init() -- -s-
  M.euid = util.run_cmd('id -u', true)
  telescope.setup { -- -s-
    defaults = {
      mappings = {
        i = {
          ['<Esc>'] = actions.close,
          ['<C-u>'] = false,
          ['<C-j>'] = actions.prev_hist,
          ['<C-k>'] = actions.next_hist,
          ['<CR>'] = actions.append_to_hist,
        },
      },
      prompt_position = 'top',
      sorting_strategy = 'ascending',
      vimgrep_arguments = {
        'rg', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number',
        '--column', '--smart-case', '--glob', '!.git/**', '--glob', '!.vim/**', '--glob',
        '!**/target/**', '--glob', '!**/*.class',
      },
      prompt_prefix = '> ',
      selection_strategy = 'reset',
      layout_strategy = 'horizontal',
      layout_defaults = {
        horizontal = {width_padding = 0.1, height_padding = 0.2, preview_width = 0.65, mirror = false},
        vertical = {mirror = true},
      },
      file_ignore_patterns = {
        '\\.cache', '\\.lsp', '\\.clj-kondo', 'node_modules', 'package-lock\\.json', 'yarn\\.lock',
        '\\.git',
      },
      shorten_path = true,
      winblend = 5,
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
  -- -e-

  -- mappings -s-
  local n_s = {noremap = true, silent = true}
  local skm = vim.api.nvim_set_keymap
  util.command('Rg', [[lua require'mod.telescope'.grep(<f-args>)]], {nargs = '1'})
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
                                       [[ search = s, prompt_prefix = s .. ' > ', ]] ..
                                       [[ ngram_len = 1, }<CR>]]
  skm('n', '<M-]>', grep_string_under_cursor, n_s)
  skm('n', '‘', grep_string_under_cursor, n_s)

  skm('n', '<M-[>', [[<CMD>lua require'mod.telescope'.tags_absolute {shorten_path = true} <CR> ]],
      n_s)
  -- -e-

  if M.euid ~= '0' then assert(io.open(tmpfile, 'w')):close() end
end -- -e-

return M
