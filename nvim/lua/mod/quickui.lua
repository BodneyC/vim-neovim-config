local skm = vim.api.nvim_set_keymap

local M = {}

function M.init()
  vim.fn['quickui#menu#reset']()

  vim.fn['quickui#menu#install']('&File', {
    {'&New File', 'enew'},
    {'&Open File', 'call fzf#vim#files("", fzf#vim#with_preview({}, "up:70%"))'},
    {'&Write', 'w'}, {'Write &All', 'wa'},
    {'&Save As', 'call feedkey(":sav ")'}, {'-', ''}, {'&Quit', 'q'},
    {'&Force Quit', 'q!'},
  })

  vim.fn['quickui#menu#install']('&Options', {
    {'&Undo', 'u'}, {'Re-do (&Y)', 'call feedkeys("\x12")'}, {'-', ''},
    {'Cu&t (+reg)', 'call feedkeys("\"+dd")'},
    {'C&opy (+reg)', 'call feedkeys("\"+yy")'},
    {'&Paste (+reg)', 'call feedkeys("\"+p")'}, {'-', ''},
    {'&Find', 'call feedkeys("/" . input("Search term: ") . "\x13")'}, {
      '&Sub Once', 'call feedkeys(":s//" . input("Replace term: ") . "/\x13")',
      'Replace your previous search',
    }, {
      'Sub L&ine', 'call feedkeys(":s//" . input("Replace term: ") . "/g\x13")',
      'Replace your previous search',
    }, {
      'Sub &All', 'call feedkeys(":%s//" . input("Replace term: ") . "/g\x13")',
      'Replace your previous search',
    }, {'-', ''}, {'Edit &Vim config', ':e $MYVIMRC'},
    {'Edit &Coc config', ':CocConfig'},
  })

  vim.fn['quickui#menu#install']('&Git', {
    {'Git &Add', 'Git add %'}, {'Git Add &.', 'Git add .'},
    {'Git &Commit', 'call feedkeys(":Gcommit -am \"\"\x1b[D")'},
    {'Git &Pull', 'Gpull'}, {'Git Pu&sh', 'Gpush'}, {'-', ''},
    {'La&zyGit', 'ToggleLazyGit'}, {'&WWW browse', 'Gbrowse'},
    {'&Blame', 'Gblame'}, {'&Diff split', 'Gdiffsplit'}, {'&Flog', 'Flog'},
  })

  vim.fn['quickui#menu#install']('&Settings', {
    {'&Set Indent', 'exe "SetIndent " . input("Indent: ")'},
    {'&Change Indent', 'exe "ChangeIndent " . input("Indent: ")'},
    {'H&ighlight at TW', 'MatchOver'},
  })

  vim.fn['quickui#menu#install']('&Tools', {
    {'Switch &Buffer', 'call quickui#tools#list_buffer("e")'},
    {'Show &Messages', 'call quickui#tools#display_messages()'},
    {'&Diff Screen', 'windo diffthis'}, {'Diff &Off', 'windo diffoff'},
    {'Spell &Checker', 'SpellChecker'},
    {'&Terminal', 'call ChooseTerm("term-split")'}, {'-', ''},
    {'&Spell (%{&spell? "On":"Off"})', 'set spell!'},
    {'C&ursor Line (%{&cursorline? "On":"Off"})', 'set cursorline!'},
    {'Cursor Co&lumn (%{&cursorcolumn? "On":"Off"})', 'set cursorcolumn!'},
  })

  vim.fn['quickui#menu#install']('&Plugin', {
    {'Coc &Restart', 'CocRestart'},
    {'Coc E&xplorer', 'CocCommand explorer --toggle'},
    {'Coc &Update', 'CocUpdate'}, {'-', ''}, {'&Vista', 'Vista!!'},
    {'&Mundo', 'MundoToggle'}, {'&Tagbar', 'TagbarToggle'},
    {'Toggle &Indent Lines', 'IndentLinesToggle'},
    {'&Reset Indent Lines', 'IndentLinesReset'}, {'&Startify', 'Startify'},
  })

  vim.fn['quickui#menu#install']('&Vim-plug', {
    {'Plug &Install', 'PlugInstall'}, {'Plug Up&date', 'PlugUpdate'},
    {'Plug Up&grade', 'PlugUpgrade'}, {'Plug &Status', 'PlugStatus'},
    {'Plug &Clean', 'PlugClean'},
  })

  vim.g.context_opts = {
    {'&Help word', 'call feedkeys(":H \x12\x17\x0D")'},
    {'&Spell', 'call feedkeys("z=")'}, {'-', ''},
    {'Find in &file', 'call feedkeys("/\x12\x17\x0D")'},
    {'Find in &dir', 'call feedkeys(":Rg \x12\x17\x0D")'},
  }

  vim.g.quickui_show_tip = 1
  vim.g.quickui_border_style = 2
  vim.g.quickui_color_scheme = 'papercol dark'

  skm('n', '<RightMouse>',
    '<LeftMouse>:call quickui#context#open(g:context_opts, { \'index\': g:quickui#context#cursor })<CR>',
    {silent = true})
  skm('n', '<M-0>',
    ':call quickui#context#open(g:context_opts, { \'index\': g:quickui#context#cursor })<CR>',
    {silent = true})
  skm('n', '<Leader><Leader>', ':call quickui#menu#open()<CR>',
    {silent = true, noremap = true})

end

return M
