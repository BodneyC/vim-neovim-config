local history_dir = vim.fn.stdpath('data') .. '/fzf-history'
local history_file = history_dir .. '/lua-fzf-custom-history'

local function prepare_history()
  vim.fn.mkdir(history_dir, 'p')
  if vim.fn.filereadable(history_file) == 0 then
    vim.fn.writefile({}, history_file)
  elseif vim.fn.executable('gawk') == 1 then
    vim.system({ 'gawk', '-i', 'inplace', '!seen[$0]++', history_file }, { text = true }, function(obj)
      if obj.code ~= 0 then
        vim.schedule(function()
          vim.notify('fzf history dedupe failed: ' .. obj.stderr, vim.log.levels.WARN)
        end)
      end
    end)
  end
end

return {
  'ibhagwan/fzf-lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    { 'junegunn/fzf', build = './install --bin' },
  },
  config = function()
    prepare_history()

    local fzf = require('fzf-lua')
    local border = 'Normal'
    local preview = 'TabLineFill'

    fzf.setup({
      fzf_opts = { ['--history'] = history_file },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git/'",
      },
      files = {
        fd_opts = table.concat({
          '--color=never --hidden --type f --type l',
          '--exclude .git --exclude node_modules --exclude vendor',
          '--exclude .clj-kondo --exclude .lsp --exclude snippets',
        }, ' '),
      },
      winopts = {
        height = 0.90,
        width = 0.92,
        row = 0.35,
        col = 0.50,
        border = vim.iter({ 1, 2, 3, 4, 5, 6, 7, 8 })
            :map(function()
              return { ' ', border }
            end)
            :totable(),
        preview = {
          border = 'noborder',
          wrap = false,
          hidden = false,
          vertical = 'down:45%',
          horizontal = 'right:58%',
          layout = 'flex',
          flip_columns = 120,
        },
      },
      hls = { preview_normal = preview, preview_border = preview },
    })

    local function grep_cword()
      fzf.grep_cword({ prompt = 'Rg (' .. vim.fn.expand('<cword>') .. ')❯ ' })
    end

    local map = require('util').map
    map('n', '<leader>r', fzf.live_grep, 'Search text')
    map('n', '<leader>f', fzf.files, 'Search files')
    map('n', '<leader>bl', fzf.buffers, 'List buffers')
    map('n', '<M-]>', grep_cword, 'Grep word under cursor')
    map('n', '‘', grep_cword, 'Grep word under cursor')

    map('n', '\\r', fzf.registers, 'Registers')
    map('n', '\\h', fzf.help_tags, 'Help tags')
    map('n', '\\m', fzf.keymaps, 'Keymaps')
    map('n', '\\M', fzf.marks, 'Marks')
    map('n', '\\c', fzf.colorschemes, 'Colorschemes')

    map('n', '\\gd', fzf.git_status, 'Git status')
    map('n', '\\gs', fzf.git_status, 'Git status')
    map('n', '\\gf', fzf.git_files, 'Git files')
    map('n', '\\gt', fzf.git_tags, 'Git tags')
    map('n', '\\gb', fzf.git_branches, 'Git branches')
    map('n', '\\gc', fzf.git_commits, 'Git commits')

    map('n', '\\a', fzf.lsp_code_actions, 'LSP code actions')
    map('n', '\\f', fzf.lsp_finder, 'LSP finder')
    map('n', '\\ld', fzf.lsp_document_symbols, 'LSP document symbols')
    map('n', '\\lw', fzf.lsp_workspace_symbols, 'LSP workspace symbols')
  end,
}
