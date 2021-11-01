local util = require('utl.util')

util.augroup({
  name = '__CONFIG_GENERAL__',
  autocmds = {
    {
      event = 'BufReadPost',
      glob = '*',
      cmd = [[if line("'\"") > 0 && line("'\"") <= line("$") | echom 'wank'  | exe "normal g`\"" | end]],
    },
    {
      event = 'BufReadPre',
      glob = '*',
      cmd = [[lua require('mod.functions').handle_large_file()]],
    },
    {
      event = 'FileType,BufEnter',
      glob = '*',
      cmd = [[lua require('ftplugin')(vim.bo.ft)]],
    },
  },
})

util.augroup({
  name = '__EXT_ASSOCS__',
  autocmds = {
    {event = 'BufRead,BufNewFile', glob = '*.MD,*.md', cmd = [[setf markdown]]},
    {event = 'BufRead,BufNewFile', glob = '*.rasi', cmd = [[setf css]]},
    {
      event = 'BufRead,BufNewFile',
      glob = 'Dockerfile*',
      cmd = [[setf dockerfile]],
    },
    {
      event = 'BufRead,BufNewFile',
      glob = 'Jenkinsfile*',
      cmd = [[set ft=groovy et ts=4 sw=4]],
    },
    {
      event = 'BufRead,BufNewFile',
      glob = '*.xml',
      cmd = [[set ft=xml et ts=4 sw=4]],
    },
  },
})

util.augroup({
  name = '__HIGHLIGHT__',
  autocmds = {
    {
      event = 'TextYankPost',
      glob = '*',
      cmd = [[silent! lua require('vim.highlight').on_yank()]],
    },
  },
})
