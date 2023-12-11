return {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false,        -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },

  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
    {
      filter = {
        event = "msg_show",
        kind = "search_count",
      },
      opts = { skip = true },
    },
  },

  messages = {
    enabled = true,            -- enables the Noice messages UI
    view = 'notify',           -- default view for messages
    view_error = 'notify',     -- view for errors
    view_warn = 'notify',      -- view for warnings
    view_history = 'messages', -- view for :messages
    view_search = false,       -- view for search count messages. Set to `false` to disable
  },

  views = {
    cmdline_popup = {
      border = {
        style = "none",
        padding = { 1, 2 },
      },
      filter_options = {},
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
  },

  popupmenu = {
    enabled = true,  -- enables the Noice popupmenu UI
    backend = "nui", -- backend to use to show regular cmdline completions
    relative = "editor",
    position = { row = 8, col = "50%", },
    size = { width = 60, height = 10, },
    border = { style = "rounded", padding = { 0, 1 }, },
    win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" }, },
  },
}
