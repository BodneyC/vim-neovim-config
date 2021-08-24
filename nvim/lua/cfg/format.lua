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
  lua = {{cmd = {'lua-format -i'}}},
  go = {{cmd = {'gofmt -w', 'goimports -w'}, tempfile_postfix = '.tmp'}},
  javascript = {{cmd = {'prettier -w', './node_modules/.bin/eslint --fix'}}},
  markdown = {
    {cmd = {'prettier -w'}}, {
      cmd = {'black'},
      start_pattern = '^```python$',
      end_pattern = '^```$',
      target = 'current',
    },
  },
}
