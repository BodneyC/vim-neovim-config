vim.g.fzf_history_dir = os.getenv('HOME')
    .. '/.local/share/nvim/fzf-history'
if vim.fn.isdirectory(vim.g.fzf_history_dir) == 0 then
  os.execute('mkdir -p ' .. vim.g.fzf_history_dir)
end

local historyfile = vim.g.fzf_history_dir .. '/lua-fzf-custom-history'
if vim.fn.filereadable(historyfile) == 0 then
  vim.cmd("silent exec '!touch " .. historyfile .. "'")
end

local history_idx = 0

-- NOTE: This will also store phrases even if you don't select an item...
local function fn_post_fzf()
end

local group = vim.api.nvim_create_augroup('__FZF_UNIQ_HISTORY', { clear = true })
-- Not ideal... but I don't care
vim.api.nvim_create_autocmd('VimEnter', {
  group = group,
  pattern = '*',
  callback = function()
    vim.system(
      { 'gawk', '-i', 'inplace', [[!uniq[$0]++]], historyfile },
      { text = true },
      function(obj)
        if obj.code ~= 0 then
          print(obj.signal .. '\n' .. obj.stdout .. '\n' .. obj.stderr)
        end
      end
    )
  end,
})

local feedkeys = require('utl.util').feedkeys

local function history_next()
  local lines = read_to_lines(historyfile)
  if not lines or #lines == 0 then
    return
  end
  if history_idx == 0 then
    history_idx = 1
  elseif history_idx + 1 <= #lines then
    history_idx = history_idx + 1
  end
  feedkeys('<C-u>' .. lines[history_idx], 'i')
end

local function history_prev()
  local lines = read_to_lines(historyfile)
  if not lines or #lines == 0 then
    return
  end
  if history_idx == 0 then
    history_idx = 1
  elseif history_idx - 1 > 0 then
    history_idx = history_idx - 1
  end
  feedkeys('<C-u>' .. lines[history_idx], 'i')
end

return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    { 'junegunn/fzf', build = './install --bin' },
  },
  config = function()
    -- calling `setup` is optional for customization
    local mapper = require('utl.mapper')
    local map = mapper({ noremap = true, silent = true })

    local fzf_preview_hl = 'TabLineFill'
    local fzf_border_hl = 'Normal'


    require('fzf-lua').setup({
      fzf_opts = {
        ['--history'] = historyfile,
      },
      files = {
        fd_opts =
        [[--color=never --hidden --type f --type l --exclude .git --exclude node_modules --exclude vendor --exclude .clj-kondo --exclude .lsp --exclude snippets]],
      },
      winopts = {
        height = 0.90,
        width = 0.92,
        row = 0.35,
        col = 0.50,
        border = {
          { ' ', fzf_border_hl },
          { ' ', fzf_border_hl },
          { ' ', fzf_border_hl },
          { ' ', fzf_border_hl },
          { ' ', fzf_border_hl },
          { ' ', fzf_border_hl },
          { ' ', fzf_border_hl },
          { ' ', fzf_border_hl },
        },
        -- border           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        preview = {
          border = 'noborder',
          wrap = 'nowrap',
          hidden = 'nohidden',
          vertical = 'down:45%',
          horizontal = 'right:58%',
          layout = 'flex',
          flip_columns = 120,
        },
      },
      hls = {
        preview_normal = fzf_preview_hl,
        preview_border = fzf_preview_hl,
      },
    })

    local fzf = require('fzf-lua')

    -- Daily
    map('n', '<space>r', fzf.live_grep, 'Search text')
    map('n', '<space>f', fzf.files, 'Search files')
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
      fzf.grep_cword({ prompt = 'Rg (' .. cword .. ')❯ ' })
    end

    map('n', '<M-]>', grep_cword, 'Grep string')
    map('n', '‘', grep_cword, 'Grep string')
  end
}
