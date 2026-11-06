local icons = require('config.icons').dap

local function dap(fn, ...)
  local args = { ... }
  return function()
    require('dap')[fn](unpack(args))
  end
end

local function with_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  local args_str = type(args) == 'table' and table.concat(args, ' ') or args --[[@as string]]

  config = vim.deepcopy(config)
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str)) --[[@as string]]
    if config.type == 'java' then
      return new_args
    end
    return require('dap.utils').splitstr(new_args)
  end
  return config
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    },
    keys = {
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'Breakpoint condition',
      },
      { '<leader>db', dap('toggle_breakpoint'), desc = 'Toggle breakpoint' },
      { '<leader>dc', dap('continue'), desc = 'Run/Continue' },
      { '<leader>da', dap('continue', { before = with_args }), desc = 'Run with args' },
      { '<leader>dC', dap('run_to_cursor'), desc = 'Run to cursor' },
      { '<leader>dg', dap('goto_'), desc = 'Go to line (no execute)' },
      { '<leader>di', dap('step_into'), desc = 'Step into' },
      { '<leader>dj', dap('down'), desc = 'Down' },
      { '<leader>dk', dap('up'), desc = 'Up' },
      { '<leader>dl', dap('run_last'), desc = 'Run last' },
      { '<leader>do', dap('step_out'), desc = 'Step out' },
      { '<leader>dO', dap('step_over'), desc = 'Step over' },
      { '<leader>dP', dap('pause'), desc = 'Pause' },
      { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
      { '<leader>ds', dap('session'), desc = 'Session' },
      { '<leader>dt', dap('terminate'), desc = 'Terminate' },
      { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Widgets' },
    },
    config = function()
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

      for name, text in pairs({
        DapBreakpoint = icons.breakpoint,
        DapBreakpointCondition = icons.breakpoint_condition,
        DapBreakpointRejected = icons.breakpoint_rejected,
        DapLogPoint = icons.log_point,
      }) do
        vim.fn.sign_define(name, { text = text, texthl = '' })
      end

      require('dap.ext.vscode').json_decode = function(str)
        return vim.json.decode(require('plenary.json').json_strip_comments(str))
      end
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-neotest/nvim-nio' },
    keys = {
      { '<leader>du', function() require('dapui').toggle({}) end, desc = 'DAP UI' },
      { '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = { 'n', 'x' } },
    },
    opts = {},
    config = function(_, opts)
      local dap, dapui = require('dap'), require('dapui')
      dapui.setup(opts)
      dap.listeners.after.event_initialized.dapui_config = function()
        dapui.open({})
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close({})
      end
    end,
  },

  { 'leoluz/nvim-dap-go', ft = 'go', dependencies = { 'mfussenegger/nvim-dap' }, opts = {} },

  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-python').setup(vim.fn.expand('~/.virtualenvs/debugpy/bin/python'))
    end,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = { automatic_installation = true, handlers = {} },
  },
}
