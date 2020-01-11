call quickui#menu#reset()

call quickui#menu#install('&File', [
      \ [ '&New File',   'enew'                                                       ],
      \ [ '&Open File',  'call fzf#vim#files("", fzf#vim#with_preview({}, "up:70%"))' ],
      \ [ '&Write',      'w'                                                          ],
      \ [ 'Write &All',  'wa'                                                         ],
      \ [ '&Save As',    'call feedkey(":sav ")'                                      ],
      \ [ '-',           ''                                                           ],
      \ [ '&Quit',       'q'                                                          ],
      \ [ '&Force Quit', 'q!'                                                         ],
      \ ] )

call quickui#menu#install('&Options', [
      \ [ '&Undo',            'u'                                                             ],
      \ [ 'Re-do (&Y)',       'call feedkeys("")'                                           ],
      \ [ '-',                ''                                                              ],
      \ [ 'Cu&t (+reg)',      '"+dd'                                                          ],
      \ [ 'C&opy (+reg)',     '"+yy'                                                          ],
      \ [ '&Paste (+reg)',    '"+p'                                                           ],
      \ [ '-',                ''                                                              ],
      \ [ '&Find',            'call feedkeys("/" . input("Search term: ") . "\<CR>")'         ],
      \ [ '&Sub Once',        'call feedkeys(":s//" . input("Replace term: ") . "/\<CR>")',   'Replace you previous search' ],
      \ [ 'Sub L&ine',        'call feedkeys(":s//" . input("Replace term: ") . "/g\<CR>")',  'Replace you previous search' ],
      \ [ 'Sub &All',         'call feedkeys(":%s//" . input("Replace term: ") . "/g\<CR>")', 'Replace you previous search' ],
      \ [ '-',                ''                                                              ],
      \ [ 'Edit &Vim config', ':e $MYVIMRC'                                                   ],
      \ [ 'Edit &Coc config', ':CocConfig'                                                    ],
      \ ] )

call quickui#menu#install('&Git', [
			\ [ 'Git &Add',    'Git add %'                                 ],
			\ [ 'Git Add &.',  'Git add .'                                 ],
			\ [ 'Git &Commit', 'call feedkeys(":Gcommit -am \"\"\<Left>")' ],
			\ [ 'Git &Pull',   'Gpull'                                     ],
			\ [ 'Git Pu&sh',   'Gpush'                                     ],
      \ [ '-',           ''                                          ],
      \ [ 'La&zyGit',    'ToggleLazyGit'                             ],
			\ [ '&WWW browse', 'Gbrowse'                                   ],
			\ [ '&Blame',      'Gblame'                                    ],
			\ [ '&Diff split', 'Gdiffsplit'                                ],
			\ [ '&Flog',       'Flog'                                      ],
      \ ] )

call quickui#menu#install('&Settings', [
      \ [ '&Set Indent',          'call SetIndent(input("Indent: ")'     ],
      \ [ '&Change Indent',       'call ChangeIndent(input("Indent: ")'  ],
      \ [ 'H&ighlight at Column', 'call HighlightAfterGlobalTextWidth()' ],
      \ ] )

call quickui#menu#install('&Tools', [
			\ [ 'Switch &Buffer',                                'call quickui#tools#list_buffer("e")'   ],
			\ [ 'Show &Messages',                                'call quickui#tools#display_messages()' ],
			\ [ '&Diff Screen',                                  'windo diffthis'                        ],
			\ [ 'Diff &Off',                                     'windo diffoff'                         ],
      \ [ 'Spell &Checker',                                'call SpellChecker()'                   ],
      \ [ '&Terminal',                                     'call ChooseTerm("term-split")'         ],
			\ [ '-',                                             ''                                      ],
      \ [ '&Spell (%{&spell? "On":"Off"})',                'set spell!'                            ],
			\ [ 'C&ursor Line (%{&cursorline? "On":"Off"})',     'set cursorline!'                       ],
			\ [ 'Cursor Co&lumn (%{&cursorcolumn? "On":"Off"})', 'set cursorcolumn!'                     ],
			\ ] )

call quickui#menu#install('&Plugin', [
			\ [ 'Coc &Restart',         'CocRestart'                   ],
			\ [ 'Coc E&xplorer',        'CocCommand explorer --toggle' ],
      \ [ '-',                    ''                             ],
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

let g:quickui_show_tip = 1
let g:quickui_border_style = 2
let g:quickui_color_scheme = 'papercol dark'

nnoremap <silent><Leader><Leader> :call quickui#menu#open()<CR>
