return {
  "lervag/vimtex",
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_syntax_enabled = false
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = '.aux',
      out_dir = '',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      hooks = {},
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
  end,
  ft = 'tex',
}
