require'format'.setup {
  ['*'] = {{cmd = {'sed -i \'s/[ \t]*$//\''}}},
  lua = {
    {
      cmd = {
        'lua-format -i --no-keep-simple-control-block-one-line ' ..
            '--no-keep-simple-function-one-line ' ..
            '--break-after-table-lb --break-before-table-rb ' ..
            '--no-chop-down-table ' .. '--extra-sep-at-table-end ' ..
            '--double-quote-to-single-quote --indent-width=2 ',
      },
    },
  },
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
