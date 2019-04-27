set signcolumn=yes

function s:CocFormat(range, line1, line2) abort
  if a:range == 0
    call CocAction('format')
  else
    call cursor(a:line1, 1)
    normal! V
    call cursor(a:line2, 1)
    call CocAction('formatSelected', 'V')
  endif
endfunction
command! -nargs=0 -range -bar CocFormat call s:CocFormat(<range>, <line1>, <line2>)
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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
augroup vimrc-language-python
  autocmd!
  autocmd FileType python Indent 4
augroup END

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

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

nmap <silent> <space>gd <Plug>(coc-definition)
nmap <silent> <space>gt <Plug>(coc-type-definition)
nmap <silent> <space>gi <Plug>(coc-implementation)
nmap <silent> <space>gr <Plug>(coc-references)

nnoremap <silent> <space>l :CocList<CR>
nnoremap <silent> <space>d :CocList --auto-preview diagnostics<CR>
nnoremap <silent> <space>c :CocList commands<CR>
