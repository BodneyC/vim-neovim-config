return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
      headings = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      bullets = { '●', '○', '◆', '◇' },
      -- Window options to use that change between rendered and raw view
      win_options = {
        conceallevel = {
          default = vim.api.nvim_get_option_value('conceallevel', {}),
          rendered = 0,
        },
        concealcursor = {
          default = vim.api.nvim_get_option_value('concealcursor', {}),
          rendered = 'nvic',
        },
      },
    })
  end,
}
