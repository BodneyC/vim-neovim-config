set nocompatible
filetype off

let g:term_theme = "light"
if empty(g:term_theme)
  echoe "$TERMTHEME not set, theming results may vary"
endif

let g:python_host_prog = systemlist('command -v python2')[0]
let g:python3_host_prog = systemlist('command -v python3')[0]

" Modular Config	
source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/conf-plugin.vim

source ~/.config/nvim/config/interface.vim
source ~/.config/nvim/config/airline.vim
source ~/.config/nvim/config/highlighting.vim
source ~/.config/nvim/config/remappings.vim
source ~/.config/nvim/config/quickui.vim
source ~/.config/nvim/config/terminal.vim
source ~/.config/nvim/config/functions.vim

source ~/.config/nvim/config/lsp.vim
luafile ~/.config/nvim/config/lsp.lua
luafile ~/.config/nvim/config/ts.lua
