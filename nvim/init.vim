set nocompatible
filetype off

if empty($TERMTHEME)
  echoe "$TERMTHEME not set, theming results may vary"
endif

let g:python_host_prog = systemlist('command -v python2')[0]
let g:python3_host_prog = systemlist('command -v python3')[0]

let g:polyglot_disabled = ['autoindent']

" Modular Config	
runtime config/plugins.vim
runtime config/conf-plugin.vim

runtime config/interface.vim
runtime config/airline.vim
runtime config/highlighting.vim
runtime config/remappings.vim
runtime config/quickui.vim
runtime config/terminal.vim
runtime config/functions.vim
runtime config/defx.vim
runtime config/pear_tree.vim

runtime config/lsp.vim
lua require'nvim-init'
