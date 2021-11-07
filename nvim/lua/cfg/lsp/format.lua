require('format').setup {
  ['*'] = {
    {
      cmd = {
        [[sed -i 's/[ \t]*$//' -e '/./,$!d' -e :a -e '/^\n*$/{$d;N;ba' -e '}']],
      },
    },
  },
  -- sh = {{cmd = {'shfmt -w -i=2 -bn -ci -sr'}}},
  -- zsh = {{cmd = {'shfmt -w -i=2 -bn -ci -sr'}}},
  lua = {
    {
      cmd = {'lua-format -i'},
    },
  },
  go = {
    {
      cmd = {'gofmt -w', 'goimports -w'},
      tempfile_postfix = '.tmp',
    },
  },
  javascript = {
    {
      cmd = {'prettier -w', './node_modules/.bin/eslint --fix'},
    },
  },
  json = {
    {
      cmd = {
        function(file)
          vim.cmd([[%!jq]])
          return file
        end,
      },
    },
  },
  markdown = {
    {
      cmd = {'prettier -w'},
    },
  },
}
