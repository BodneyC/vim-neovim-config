set nocompatible
filetype off

let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/conf-plugin.vim

" Modular Config	
source ~/.config/nvim/config/interface.vim
source ~/.config/nvim/config/highlighting.vim
source ~/.config/nvim/config/remappings.vim
source ~/.config/nvim/config/terminal.vim
source ~/.config/nvim/config/files.vim
source ~/.config/nvim/config/coc.vim
source ~/.config/nvim/config/latex.vim
source ~/.config/nvim/config/pandoc.vim

"source ~/.config/nvim/config/project-settings.vim
