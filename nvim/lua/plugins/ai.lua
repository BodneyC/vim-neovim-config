local ai = require('util.ai')

return {
  -- Copilot: only auto-attaches when signed in (see util/ai.lua). `:Copilot auth`
  -- is always available so a new machine can be signed in without config changes.
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = ai.copilot_enabled() and 'InsertEnter' or nil,
    dependencies = { 'zbirenbaum/copilot-cmp' },
    opts = {
      -- Suggestions are surfaced through nvim-cmp instead
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = { markdown = true, gitcommit = true, yaml = true },
    },
    config = function(_, opts)
      require('copilot').setup(opts)
      require('copilot_cmp').setup()
    end,
  },

  -- Claude Code: only loaded when the `claude` CLI is installed.
  {
    'coder/claudecode.nvim',
    cond = ai.claude_enabled,
    dependencies = { 'folke/snacks.nvim' },
    cmd = {
      'ClaudeCode',
      'ClaudeCodeFocus',
      'ClaudeCodeSend',
      'ClaudeCodeAdd',
      'ClaudeCodeTreeAdd',
      'ClaudeCodeSelectModel',
      'ClaudeCodeDiffAccept',
      'ClaudeCodeDiffDeny',
    },
    opts = {},
    keys = {
      { '<leader>a', nil, desc = 'AI/Claude Code' },
      { '<leader>ac', '<Cmd>ClaudeCode<CR>', desc = 'Toggle Claude' },
      { '<leader>af', '<Cmd>ClaudeCodeFocus<CR>', desc = 'Focus Claude' },
      { '<leader>ar', '<Cmd>ClaudeCode --resume<CR>', desc = 'Resume Claude' },
      { '<leader>aC', '<Cmd>ClaudeCode --continue<CR>', desc = 'Continue Claude' },
      { '<leader>am', '<Cmd>ClaudeCodeSelectModel<CR>', desc = 'Select Claude model' },
      { '<leader>ab', '<Cmd>ClaudeCodeAdd %<CR>', desc = 'Add buffer to Claude' },
      { '<leader>as', '<Cmd>ClaudeCodeSend<CR>', mode = 'v', desc = 'Send selection to Claude' },
      { '<leader>as', '<Cmd>ClaudeCodeTreeAdd<CR>', desc = 'Add file to Claude', ft = 'neo-tree' },
      { '<leader>aa', '<Cmd>ClaudeCodeDiffAccept<CR>', desc = 'Accept Claude diff' },
      { '<leader>ad', '<Cmd>ClaudeCodeDiffDeny<CR>', desc = 'Deny Claude diff' },
    },
  },
}
