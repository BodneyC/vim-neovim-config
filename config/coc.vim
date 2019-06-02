set signcolumn=yes

let g:coc_filetypes = []

call coc#add_extension('coc-css')
let g:coc_filetypes += ['css']

call coc#add_extension('coc-html', 'coc-emmet')
let g:coc_filetypes += ['html']

call coc#add_extension('coc-tsserver', 'coc-eslint', 'coc-prettier')
let g:coc_filetypes += ['javascript', 'javascript.jsx', 'typescript', 'typescript.jsx']
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

call coc#add_extension('coc-json')
let g:coc_filetypes += ['json']

let g:coc_filetypes += ['markdown']

let g:coc_filetypes += ['yaml']

call coc#add_extension('coc-python')
let g:coc_filetypes += ['python']

let g:python_highlight_all = 1

function IsCocEnabled()
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
