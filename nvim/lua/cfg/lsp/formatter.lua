local function only_opts(opts)
  return {
    function()
      return opts
    end,
  }
end

local function shfmt()
  local pwd = os.getenv('PWD')
  local args = { '-w', '-i=2', '-bn', '-ci', '-sr' }
  if vim.fn.filereadable(pwd .. '/.editorconfig') == 1 then
    args = { '-w' }
  end
  local fname = vim.fn.expand('%')
  if fname:match('.bats$') then
    table.insert(args, '--language-dialect=bats')
  end
  return {
    exe = 'shfmt',
    cwd = pwd,
    args = args,
    stdin = false,
  }
end

require('formatter').setup({
  filetype = {
    sh = shfmt,
    zsh = shfmt,
    lua = only_opts({
      exe = 'lua-format',
      args = { '-i' },
      stdin = false,
    }),
    go = only_opts({
      exe = 'gofmt',
      args = { '-w' },
      stdin = true,
    }),
    javascript = only_opts({
      exe = 'prettier',
      args = {
        '--stdin-filepath',
        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
        '--single-quote',
      },
      stdin = true,
    }),
    json = only_opts({
      exe = 'prettier',
      args = {
        '--stdin-filepath',
        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
        '--double-quote',
      },
      stdin = true,
    }),
    markdown = only_opts({
      exe = 'prettier',
      args = {
        '--stdin-filepath',
        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
        '--double-quote',
      },
      stdin = true,
    }),
    python = only_opts({
      exe = 'autopep8',
      args = { '--in-place' },
      stdin = true,
    }),
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ['*'] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require('formatter.filetypes.any').remove_trailing_whitespace,
    },
  },
})
