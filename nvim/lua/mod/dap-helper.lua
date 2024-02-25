local dap = require('dap')

dap.set_log_level('INFO')

local M = {}

local DEFAULT_CONFIGS = {
  javascript = {
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = { '<node_internals>/**/*.js' },
  },
}
DEFAULT_CONFIGS.typescript = vim.deepcopy(DEFAULT_CONFIGS.javascript)

function M.debug_mocha(prog, file, term)
  local cfg = vim.deepcopy(DEFAULT_CONFIGS.javascript)
  cfg.request = 'launch'
  cfg.console = 'integratedTerminal'
  cfg.port = 9229
  if term then
    cfg.runtimeArgs = { prog, '--inspect-brk', file, '--grep', term }
  else
    cfg.runtimeArgs = { prog, '--inspect-brk', file }
  end
  dap.run(cfg)
end

function M.debug_jest(prog, file, test)
  local cfg = vim.deepcopy(DEFAULT_CONFIGS.javascript)
  cfg.request = 'launch'
  cfg.console = 'integratedTerminal'
  cfg.port = 9229
  cfg.runtimeArgs = {
    '--inspect-brk',
    prog,
    '--no-coverage',
    '-t',
    test,
    '--',
    file,
  }
  dap.run(cfg)
end

-- Gotta run the file first... e.g.
--  $ node --inspect-brk {file}
function M.run_dap()
  if vim.bo.ft == 'rust' then
    if vim.fn.exists(':RustDebuggables') == 1 then
      vim.cmd([[RustDebuggables]])
    end
  else
    if DEFAULT_CONFIGS[vim.bo.ft] == nil then
      print('No dap configuration for filetype: ' .. vim.bo.ft)
      return
    end
    dap.run(DEFAULT_CONFIGS[vim.bo.ft])
  end
end

return M
