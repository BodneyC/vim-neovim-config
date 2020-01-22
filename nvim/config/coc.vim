set signcolumn=yes

call coc#add_extension(
      \ 'coc-explorer',
      \ 'coc-snippets',
      \ 'coc-tag',
      \ 'coc-syntax',
      \ 'coc-lists',
      \ 'coc-yank',
      \ 'coc-diagnostic',
      \ 'coc-calc',
      \ 'coc-docker',
      \ 'coc-rls',
      \ 'coc-python', 
      \ 'coc-json', 
      \ 'coc-tsserver', 
      \ 'coc-tslint-plugin',
      \ 'coc-eslint', 
      \ 'coc-html', 
      \ 'coc-emmet', 
      \ 'coc-css')
call coc#add_extension(
      \ 'coc-highlight',
      \ 'coc-terminal',
      \ 'coc-java')

let g:coc_filetypes = [
      \ 'Dockerfile',
      \ 'sh',
      \ 'vim',
      \ 'groovy',
      \ 'python', 
      \ 'yaml', 
      \ 'markdown', 
      \ 'json', 
      \ 'javascript', 
      \ 'javascript.jsx', 
      \ 'typescript', 
      \ 'typescript.jsx', 
      \ 'html', 
      \ 'css',]

call coc#config('eslint', {
      \ 'filetypes': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
      \ 'autoFixOnSave': v:true,
      \ })

let g:python_highlight_all = 1

function! IsCocEnabled()
  return index(g:coc_filetypes, &filetype) >= 0
endfunction

augroup vimrc-coc
  autocmd!
  autocmd FileType * if IsCocEnabled()
    \|  let &l:formatexpr = "CocAction('formatSelected')"
    \|  let &l:keywordprg = ":call CocAction('doHover')"
    \| endif
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <silent>  <C-m> <Plug>(coc-cursors-position)
xmap <silent>  <C-m> <Plug>(coc-cursors-range)
nmap <leader>x <Plug>(coc-cursors-operator)
nmap <silent> <leader>R :RenameWord<CR>
