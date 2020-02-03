set signcolumn=yes

call coc#add_extension(
      \ 'coc-explorer',
      \ 'coc-snippets',
      \ 'coc-tag',
      \ 'coc-syntax',
      \ 'coc-lists',
      \ 'coc-yank',
      \ 'coc-diagnostic',
      \ 'coc-docker',
      \ 'coc-rls',
      \ 'coc-python',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-tslint-plugin',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-emmet',
      \ 'coc-css'
      \ )
call coc#add_extension(
      \ 'coc-highlight',
      \ 'coc-terminal',
      \ 'coc-java',
      \ 'coc-vimlsp'
      \ )

let g:coc_filetypes = [
      \ 'Dockerfile',
      \ 'Jenkinsfile',
      \ 'java',
      \ 'kotlin',
      \ 'xml',
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
      \ 'css',
      \ 'rust',
      \ 'go'
      \ ]

let g:python_highlight_all = 1

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'H ' . expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! IsCocEnabled()
  return index(g:coc_filetypes, &filetype) >= 0
endfunction

function! s:go_to_definition()
  if IsCocEnabled()
    call CocAction('jumpDefinition')
  else
    execute 'tag ' . expand('<cword>')
  endif
endfunction
nnoremap <C-]> :call <SID>go_to_definition()<CR>

augroup vimrc-coc
  autocmd!
  autocmd FileType * if IsCocEnabled()
    \|  let &l:formatexpr = "CocAction('formatSelected')"
    \| endif
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <silent>  <C-m> <Plug>(coc-cursors-position)
xmap <silent>  <C-m> <Plug>(coc-cursors-range)
nmap <leader>x <Plug>(coc-cursors-operator)
nmap <silent> <leader>R :RenameWord<CR>
