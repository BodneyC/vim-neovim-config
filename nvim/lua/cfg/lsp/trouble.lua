require'trouble'.setup {
  position = 'bottom',
  icons = true,
  action_keys = {
    close = 'q', -- close the list
    cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
    refresh = 'r', -- manually refresh
    jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
    open_split = { 'i' }, -- open buffer in new split
    open_vsplit = { 's' }, -- open buffer in new vsplit
    open_tab = {}, -- { '<c-t>' }, -- open buffer in new tab
    jump_close = { 'o' }, -- jump to the diagnostic and close the list
    toggle_mode = 'm', -- toggle between 'workspace' and 'document' diagnostics mode
    toggle_preview = 'P', -- toggle auto_preview
    hover = 'K', -- opens a small popup with the full multiline message
    preview = 'p', -- preview the diagnostic location
    close_folds = { 'zM', 'zm' }, -- close all folds
    open_folds = { 'zR', 'zr' }, -- open all folds
    toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
    previous = 'k', -- preview item
    next = 'j', -- next item
   },
  use_diagnostic_signs = true,
 }
