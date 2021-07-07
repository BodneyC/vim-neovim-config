local skm = vim.api.nvim_set_keymap

vim.g.vimspector_install_gadgets = {'debugpy', 'vscode-cpptools', 'CodeLLDB'}

skm('n', '<F5>', '<Plug>VimspectorContinue', {})
skm('n', '<F3>', '<Plug>VimspectorStop', {})
skm('n', '<F4>', '<Plug>VimspectorRestart', {})
skm('n', '<F6>', '<Plug>VimspectorPause', {})
skm('n', '<F9>', '<Plug>VimspectorToggleBreakpoint', {})
skm('n', '<leader><F9>', '<Plug>VimspectorToggleConditionalBreakpoint', {})
skm('n', '<F8>', '<Plug>VimspectorAddFunctionBreakpoint', {})
skm('n', '<leader><F8>', '<Plug>VimspectorRunToCursor', {})
skm('n', '<F10>', '<Plug>VimspectorStepOver', {})
skm('n', '<F11>', '<Plug>VimspectorStepInto', {})
skm('n', '<F12>', '<Plug>VimspectorStepOut', {})
