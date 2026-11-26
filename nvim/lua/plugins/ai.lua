local ai = require('util.ai')

return {
  -- Copilot: auto-attaches when signed in via `:Copilot auth`, except under a
  -- `.nocopilot` marker (see util/ai.lua)
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
      -- Per buffer, so a session started elsewhere still never attaches to a
      -- blocked project. copilot-cmp only serves buffers the client is
      -- attached to, so this also keeps Copilot out of nvim-cmp.
      should_attach = function(bufnr, bufname)
        if ai.copilot_blocked(bufname) then
          return false
        end
        return require('copilot.config.should_attach').default(bufnr, bufname)
      end,
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
      { '<leader>ac', '<Cmd>ClaudeCode<CR>', desc = 'Claude: Toggle' },
      { '<leader>af', '<Cmd>ClaudeCodeFocus<CR>', desc = 'Claude: Focus' },
      { '<leader>ar', '<Cmd>ClaudeCode --resume<CR>', desc = 'Claude: Resume' },
      { '<leader>aC', '<Cmd>ClaudeCode --continue<CR>', desc = 'Claude: Continue' },
      { '<leader>am', '<Cmd>ClaudeCodeSelectModel<CR>', desc = 'Claude: Select model' },
      { '<leader>ab', '<Cmd>ClaudeCodeAdd %<CR>', desc = 'Claude: Add buffer' },
      { '<leader>as', '<Cmd>ClaudeCodeSend<CR>', mode = 'v', desc = 'Claude: Send selection' },
      { '<leader>as', '<Cmd>ClaudeCodeTreeAdd<CR>', desc = 'Claude: Add file', ft = 'neo-tree' },
      { '<leader>aa', '<Cmd>ClaudeCodeDiffAccept<CR>', desc = 'Claude: Accept diff' },
      { '<leader>ad', '<Cmd>ClaudeCodeDiffDeny<CR>', desc = 'Claude: Deny diff' },
    },
  },
}
