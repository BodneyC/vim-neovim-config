local util = require('utl.util')

util.augroup({
  name = '__CONFIG_GENERAL__',
  autocmds = {
    -- {
    --   event = 'BufReadPost',
    --   glob = '*',
    --   cmd = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "silent normal g`\"" | end]],
    -- },
    {
      event = 'BufReadPre',
      glob = '*',
      lua_fn = require('mod.functions').handle_large_file,
    },
    {
      event = 'FileType,BufEnter',
      glob = '*',
      -- cmd = [[lua require('ftplugin')(vim.bo.ft)]],
      lua_fn = function()
        require('ftplugin')(vim.bo.ft)
      end,
      silent = true,
    },
    {
      event = 'BufLeave',
      glob = '*',
      cmd = [[if &readonly == 0 && filereadable(bufname('%')) | silent! write | endif]],
    },
  },
})

util.augroup({
  name = '__EXT_ASSOCS__',
  autocmds = {
    {
      event = 'BufRead,BufNewFile',
      glob = '*.MD,*.md',
      cmd = [[setf markdown]],
    },
    {
      event = 'BufRead,BufNewFile',
      glob = '*.rasi',
      cmd = [[setf css]],
    },
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
      lua_fn = require('vim.highlight').on_yank,
      silent = true,
    },
  },
})
