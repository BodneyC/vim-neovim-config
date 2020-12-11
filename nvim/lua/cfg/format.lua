require'format'.setup {
  ['*'] = {{cmd = {'sed -i \'s/[ \t]*$//\''}}},
  lua = {
    {
      cmd = {
        -- Should probably just have a config file for this
        'lua-format -i --keep-simple-control-block-one-line --column-limit=100 ' ..
            '--no-keep-simple-function-one-line ' ..
            '--break-after-table-lb --break-before-table-rb --no-chop-down-table ' ..
            '--extra-sep-at-table-end --no-align-parameter --no-align-args ' ..
            '--double-quote-to-single-quote --indent-width=2 ',
      },
    },
  },
  go = {{cmd = {'gofmt -w', 'goimports -w'}, tempfile_postfix = '.tmp'}},
  javascript = {{cmd = {'prettier -w', './node_modules/.bin/eslint --fix'}}},
  markdown = {
    {cmd = {'prettier -w'}},
    {cmd = {'black'}, start_pattern = '^```python$', end_pattern = '^```$', target = 'current'},
  },
}
