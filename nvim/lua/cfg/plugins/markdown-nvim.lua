return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local conceallevel = 0
    require('render-markdown').setup({
      latex = { enabled = false },
      heading = { icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' } },
      bullet = { icons = { '●', '○', '◆', '◇' } },
      -- Window options to use that change between rendered and raw view
      win_options = {
        conceallevel = {
          default = vim.api.nvim_get_option_value('conceallevel', {}),
          rendered = conceallevel,
        },
        concealcursor = {
          default = vim.api.nvim_get_option_value('concealcursor', {}),
          rendered = 'nvic',
        },
      },
      code = {
        language_name = false,
      },
    })
  end,
}
