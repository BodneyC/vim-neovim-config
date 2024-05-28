return {
  'rhysd/clever-f.vim',
  config = function()
    vim.g.clever_f_mark_char_color = 'ModeMsg'
    vim.keymap.set('', ';', '<Plug>(clever-f-repeat-forward)', {})
    vim.keymap.set('', ',', '<Plug>(clever-f-repeat-back)', {})
    vim.keymap.set('n', '<Esc>', function()
      vim.fn['clever_f#reset']()
      vim.cmd([[normal! "<Esc>"]])
    end, {})
  end,
}
