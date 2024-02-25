local mapper = require('utl.mapper')
local map = mapper({ noremap = true, silent = true })

local fzf = require 'fzf-lua'

local historyfile = vim.g.fzf_history_dir .. '/lua-fzf-custom-history'
if vim.fn.filereadable(historyfile) == 0 then
  vim.cmd('silent exec \'!touch ' .. historyfile .. '\'')
end

local history_idx = 0

local function read_to_lines(filepath)
  local file = io.open(filepath, 'r');
  if not file then
    vim.print('Unable to open file (' .. filepath .. ') for reading')
    return
  end
  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()
  return lines
end

local feedkeys = require('utl.util').feedkeys

local function history_next()
  local lines = read_to_lines(historyfile)
  if not lines or #lines == 0 then return end
  if history_idx == 0 then
    history_idx = 1
  elseif history_idx + 1 <= #lines then
    history_idx = history_idx + 1
  end
  feedkeys('<C-u>' .. lines[history_idx], 'i')
end

local function history_prev()
  local lines = read_to_lines(historyfile)
  if not lines or #lines == 0 then return end
  if history_idx == 0 then
    history_idx = 1
  elseif history_idx - 1 > 0 then
    history_idx = history_idx - 1
  end
  feedkeys('<C-u>' .. lines[history_idx], 'i')
end

-- NOTE: This will also store phrases even if you don't select an item...
local function fn_post_fzf(_, _)
  history_idx = 0
  -- NOTE: The phrase is in the first element of the second parameter... but
  --  they remove it before calling this func for some reason, luckily they
  --  store it in an accessible place, the config module
  local phrase = require('fzf-lua.config').__resume_data.opts.query
  -- NOTE: Arguably should check for certain 'command' phrases like 'esc', not
  --  only can I not be bothered to figure them all out but you may have just
  --  searched 'esc'...
  if not phrase or type(phrase) ~= 'string' then
    return
  end
  local file = io.open(historyfile, 'r');
  if not file then
    vim.print('Unable to open fzf-lua history file (' .. historyfile .. ') for reading')
    return
  end
  local lines = {}
  for line in file:lines() do
    if line ~= phrase then
      table.insert(lines, line)
    end
  end
  table.insert(lines, 1, phrase)
  file:close()
  file = io.open(historyfile, 'w')
  if not file then
    vim.print('Unable to open fzf-lua history file (' .. historyfile .. ') for writing')
    return
  end
  local content = ''
  for _, line in pairs(lines) do
    if line ~= '' then
      content = content .. line .. '\n'
    end
  end
  file:write(content)
  file:close()
end

local function apply_opts(fn)
  return function()
    fn({ fn_post_fzf = fn_post_fzf })
  end
end

-- Daily
map('n', '<space>r', apply_opts(fzf.live_grep), 'Search text')
map('n', '<space>f', apply_opts(fzf.files), 'Search files')
map('n', '<space>bl', fzf.buffers, 'List buffers')

-- Vim
map('n', [[\r]], fzf.registers, 'Registers')
map('n', [[\h]], fzf.help_tags, 'Help tags')
map('n', [[\m]], fzf.keymaps, 'Keymaps')
map('n', [[\M]], fzf.marks, 'Marks')
map('n', [[\c]], fzf.colorschemes, 'Marks')

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

local function grep_cword()
  local cword = vim.fn.expand('<cword>')
  fzf.grep_cword { prompt = 'Rg (' .. cword .. ')❯ ' }
end

map('n', '<M-]>', grep_cword, 'Grep string')
map('n', '‘', grep_cword, 'Grep string')

return {
  winopts = {
    height    = 0.90,
    width     = 0.92,
    row       = 0.35,
    col       = 0.50,
    border    = {
      { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' },
      { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' },
      { ' ', 'TabLineFill' }, { ' ', 'TabLineFill' },
    },
    -- border           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    preview   = {
      border       = 'noborder',
      wrap         = 'nowrap',
      hidden       = 'nohidden',
      vertical     = 'down:45%',
      horizontal   = 'right:58%',
      layout       = 'flex',
      flip_columns = 120,
    },
    on_create = function()
      vim.keymap.set('t', '<C-j>', history_next, { silent = true, buffer = true })
      vim.keymap.set('t', '<C-k>', history_prev, { silent = true, buffer = true })
    end,
  },
  hls     = {
    preview_normal = 'TabLineFill',
    preview_border = 'TabLineFill',
  },
}
