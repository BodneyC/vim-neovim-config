local function shfmt()
  local cwd = require("conform.util").root_file({ ".editorconfig", ".git" })
  local args = { '-w', '-i=2', '-bn', '-ci', '-sr' }
  if vim.fn.filereadable(cwd .. '/.editorconfig') == 1 then
    args = { '-w' }
  end
  if vim.fn.expand('%'):match('.bats$') then
    table.insert(args, '--language-dialect=bats')
  end
  return {
    command = 'shfmt',
    cwd = cwd,
    prepend_args = args,
    stdin = false,
  }
end

return {
  'stevearc/conform.nvim',
  opts = {
    formatters = {
      jq = {
        command = "jq",
        prepend_args = { "." }
      },
      shfmt = shfmt,
    },
    formatters_by_ft = {
      json = { "jq" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  }
}
