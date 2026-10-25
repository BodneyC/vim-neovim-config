local set_breakpoint = function()
  require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
end

local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or
      {} --[[@as string[] | string ]]
  local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
    if config.type and config.type == "java" then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

return {
  "mfussenegger/nvim-dap",
  recommended = true,
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>dB", set_breakpoint,                                                desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end,             desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end,                      desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end,                 desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end,                         desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end,                     desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end,                          desc = "Down" },
    { "<leader>dk", function() require("dap").up() end,                            desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end,                      desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end,                      desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end,                     desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end,                         desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end,                   desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end,                       desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end,                     desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end,              desc = "Widgets" },
  },

  config = function()
    -- load mason-nvim-dap here, after all adapters have been setup
    local status_ok, _ = pcall(require, "mason-nvim-dap.nvim")
    if status_ok then
      require("mason-nvim-dap").setup()
    end

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    local dapicons = {
      Error = { " ", "DiagnosticError" },
      Inactive = { " ", "MsgArea" },
      Warning = { " ", "DiagnosticWarn" },
      Normal = { "  ", "Special" },
    }

    for name, sign in pairs(dapicons) do
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- setup dap config by VsCode launch.json file
    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end
  end,
}
