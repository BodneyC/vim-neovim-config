call plug#begin('~/.local/share/nvim/plugged')
    Plug 'neovim/nvim-lsp'
    Plug 'haorenW1025/completion-nvim'
call plug#end()
lua require'nvim_lsp'.vimls.setup{on_attach=require'completion'.on_attach}
set completeopt=menuone,noinsert,noselect
