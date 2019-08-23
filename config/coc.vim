set signcolumn=yes

call coc#add_extension(
      \ 'coc-snippets',
      \ 'coc-tag',
      \ 'coc-tabnine',
      \ 'coc-syntax',
      \ 'coc-lists',
      \ 'coc-yank',
      \ 'coc-post',
      \ 'coc-diagnostic',
      \ 'coc-calc',
      \ 'coc-docker',
      \ 'coc-sh',
      \ 'coc-rls',
      \ 'coc-python', 
      \ 'coc-json', 
      \ 'coc-tsserver', 
      \ 'coc-eslint', 
      \ 'coc-html', 
      \ 'coc-emmet', 
      \ 'coc-css')
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
call coc#config('prettier', {
      \ 'singleQuote': v:true,
      \ 'trailingComma': 'all',
      \ 'jsxBracketSameLine': v:true,
      \ 'eslintIntegration': v:true,
      \ })

let g:python_highlight_all = 1

function! IsCocEnabled()
  return index(g:coc_filetypes, &filetype) >= 0
endfunction

augroup vimrc-coc
  autocmd!
  autocmd FileType * if IsCocEnabled()
    \|let &l:formatexpr = "CocAction('formatSelected')"
    \|let &l:keywordprg = ":call CocAction('doHover')"
    \|endif
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
