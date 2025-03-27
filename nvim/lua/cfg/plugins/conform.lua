local function latexindent()
  local cwd = vim.fs.root(vim.fn.expand('%:p:h'), { ".git" })
  local args = {}
  if vim.fn.filereadable(cwd .. '/.latexindent.yaml') == 1 then
    args = { '-l=' .. cwd .. '/.latexindent.yaml', '-' }
  end
  return {
    command = 'latexindent',
    args = args,
    stdin = true,
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
      latexindent_custom = latexindent,
    },
    formatters_by_ft = {
      json = { "jq" },
      -- tex = { "latexindent_custom" },
      bib = { "bibtex-tidy" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  }
}
