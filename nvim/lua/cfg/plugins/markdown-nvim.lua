return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local conceallevel = 1
    local language_name = false
    if conceallevel > 0 then
      language_name = true
    end
    require('render-markdown').setup({
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
        language_name = language_name,
      },
    })
  end,
}
