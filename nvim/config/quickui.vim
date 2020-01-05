call quickui#menu#reset()

call quickui#menu#install('&File', [
      \ [ '&New File',   'enew'                                                       ],
      \ [ '&Open File',  'call fzf#vim#files("", fzf#vim#with_preview({}, "up:70%"))' ],
      \ [ '&Write',      'w'                                                          ],
      \ [ 'Write &All',  'wa'                                                         ],
      \ [ '&Save As',    'call feedkey(":sav ")'                                      ],
      \ [ '--',          ''                                                           ],
      \ [ '&Quit',       'q'                                                          ],
      \ [ '&Force Quit', 'q!'                                                         ],
      \ ] )

call quickui#menu#install('&Plugin', [
			\ [ 'Coc &Restart',         'CocRestart'                   ],
			\ [ 'Coc E&xplorer',        'CocCommand explorer --toggle' ],
      \ [ '--',                   ''                             ],
			\ [ '&Vista',               'Vista!!'                      ],
			\ [ '&Mundo',               'MundoToggle'                  ],
			\ [ '&Tagbar',              'TagbarToggle'                 ],
			\ [ 'Toggle &Indent Lines', 'IndentLinesToggle'            ],
			\ [ '&Reset Indent Lines',  'IndentLinesReset'             ],
			\ [ '&Startify',            'Startify'                     ],
      \ ] )

call quickui#menu#install('&Vim-plug', [
			\ [ 'Plug &Install', 'PlugInstall' ],
			\ [ 'Plug Up&date',  'PlugUpdate'  ],
			\ [ 'Plug Up&grade', 'PlugUpgrade' ],
			\ [ 'Plug &Status',  'PlugStatus'  ],
			\ [ 'Plug &Clean',   'PlugClean'   ],
			\ ] )

call quickui#menu#install('&Git', [
			\ [ 'Git &Add',    'Git add %'                        ],
			\ [ 'Git Add &.',  'Git add .'                        ],
			\ [ 'Git &Commit', 'call feedkeys(":Gcommit -am \"")' ],
			\ [ 'Git &Pull',   'Gpull'                            ],
			\ [ 'Git Pu&sh',   'Gpush'                            ],
      \ [ '--',          ''                                 ],
			\ [ '&WWW browse', 'Gbrowse'                          ],
			\ [ '&Blame',      'Gblame'                           ],
			\ [ '&Diff split', 'Gdiffsplit'                       ],
			\ [ '&Flog',       'Flog'                             ],
      \ ] )

call quickui#menu#install('&Tools', [
			\ [ 'Switch &Buffer',                              'call quickui#tools#list_buffer("e")'   ],
			\ [ 'Show &Messages',                              'call quickui#tools#display_messages()' ],
			\ [ '&Diff Screen',                                'windo diffthis'                        ],
			\ [ 'Diff &Off',                                   'windo diffoff'                         ],
			\ [ '-',                                           ''                                      ],
			\ [ '&Spell %{&spell? "Off":"On"}',                'set spell!'                            ],
			\ [ '&Cursor Line %{&cursorline? "Off":"On"}',     'set cursorline!'                       ],
			\ [ 'Cursor &Column %{&cursorcolumn? "Off":"On"}', 'set cursorcolumn!'                     ],
			\ ] )

let g:quickui_show_tip = 1
let g:quickui_border_style = 2
let g:quickui_color_scheme = 'papercol dark'

nnoremap <silent><Leader><Leader> :call quickui#menu#open()<CR>
