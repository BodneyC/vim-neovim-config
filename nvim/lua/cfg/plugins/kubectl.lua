return {
  {
    'ramilito/kubectl.nvim',
    keys = {
      {
        '<leader>k',
        function() require('kubectl').open() end,
        desc = 'Kubectl',
      },
    },
    config = function()
      require('kubectl').setup()
    end,
  },
}
