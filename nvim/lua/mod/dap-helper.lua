local dap = require('dap')

dap.set_log_level('TRACE')

local M = {}

local DEFAULT_CONFIGS = {
  node = {
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    -- sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
  },
}

function M.debug_mocha(prog, file, term)
  local cfg = vim.deepcopy(DEFAULT_CONFIGS.node)
  cfg.request = 'launch'
  cfg.console = 'integratedTerminal'
  cfg.port = 9229
  if term then
    cfg.runtimeArgs = {prog, '--inspect-brk', file, '--grep', term}
  else
    cfg.runtimeArgs = {prog, '--inspect-brk', file}
  end
  dap.run(cfg)
end

function M.debug_jest(prog, file, test)
  local cfg = vim.deepcopy(DEFAULT_CONFIGS.node)
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

-- WIP, Ava doesn't really support this ATM
function M.debug_ava(prog, file, match)
  local cfg = vim.deepcopy(DEFAULT_CONFIGS.node)
  cfg.request = 'launch'
  cfg.console = 'integratedTerminal'
  cfg.port = 9230
  cfg.outputCapture = 'std'
  cfg.runtimeExecutable = prog
  if match then
    cfg.runtimeArgs = {'--serial', file, match}
  else
    cfg.runtimeArgs = {'--serial', file}
  end
  print(vim.inspect(cfg))
  dap.run(cfg)
end

function M.debug_node()
  dap.run(DEFAULT_CONFIGS.node)
end

return M
