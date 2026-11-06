local tools = { 'markdownlint', 'shellcheck' }

local function ensure_tools()
  local registry = require('mason-registry')
  registry.refresh(function()
    for _, name in ipairs(tools) do
      local ok, pkg = pcall(registry.get_package, name)
      if ok and not pkg:is_installed() then
        pkg:install()
      end
    end
  end)
end

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  dependencies = { 'williamboman/mason.nvim' },
  config = function()
    local lint = require('lint')
    local severity = vim.diagnostic.severity

    lint.linters.pkgbuild = {
      cmd = vim.fn.stdpath('data') .. '/lazy/vim-pkgbuild/scripts/shellcheck_pkgbuild.sh',
      stdin = false,
      append_fname = true,
      ignore_exitcode = true,
      stream = 'stdout',
      parser = require('lint.parser').from_pattern(
        '^[^:]+:(%d+):(%d+): (%w+): (.+)$',
        { 'lnum', 'col', 'severity', 'message' },
        { error = severity.ERROR, warning = severity.WARN, note = severity.INFO },
        { source = 'pkgbuild' }
      ),
    }

    lint.linters.markdownlint = require('lint.util').wrap(lint.linters.markdownlint, function(d)
      local level, message = d.message:match('^(%a+) (.+)$')
      if level then
        d.severity = level == 'error' and severity.ERROR or severity.WARN
        d.message = message
      end
      return d
    end)

    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      pkgbuild = { 'pkgbuild' },
    }

    ensure_tools()

    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
      group = vim.api.nvim_create_augroup('config_lint', { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
    vim.schedule(function()
      lint.try_lint()
    end)
  end,
}
