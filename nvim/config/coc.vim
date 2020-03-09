set signcolumn=yes

call coc#add_extension(
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-docker',
      \ 'coc-emmet',
      \ 'coc-eslint',
      \ 'coc-explorer',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-python',
      \ 'coc-rls',
      \ 'coc-snippets',
      \ 'coc-syntax',
      \ 'coc-tag',
      \ 'coc-tslint-plugin',
      \ 'coc-tsserver',
      \ 'coc-yank',
      \ )
call coc#add_extension(
      \ 'coc-highlight',
      \ 'coc-java',
      \ 'coc-terminal',
      \ 'coc-vimlsp',
      \ )

let g:coc_filetypes = [
      \ 'Dockerfile',
      \ 'Jenkinsfile',
      \ 'css',
      \ 'go',
      \ 'groovy',
      \ 'html',
      \ 'java',
      \ 'javascript',
      \ 'javascript.jsx',
      \ 'json',
      \ 'kotlin',
      \ 'markdown',
      \ 'python',
      \ 'rust',
      \ 'sh',
      \ 'typescript',
      \ 'typescript.jsx',
      \ 'vim',
      \ 'xml',
      \ 'yaml',
      \ ]

function! IsCocEnabled()
  return index(g:coc_filetypes, &filetype) >= 0
endfunction

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'H ' . expand('<cword>')
  elseif &filetype == 'sh' || &filetype == 'zsh'
    if ! CocAction('doHover')
      call FloatingMan(expand('<cword>'))
    endif
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:go_to_tag()
  try
    exec 'tag ' . expand('<cword>')
    return
  catch
  endtry
  try
    exec 'tag ' . expand('<cWORD>')
    return
  catch
  endtry
  echom "Tag not found"
endfunction

function! s:go_to_definition()
  if IsCocEnabled() 
    if CocAction('jumpDefinition')
      return
    endif
    redraw
    echo ''
  endif
  call <SID>go_to_tag()
endfunction
nnoremap <silent> <C-]> :call <SID>go_to_definition()<CR>

augroup vimrc-coc
  autocmd!
  autocmd FileType * if IsCocEnabled()
        \| let &l:formatexpr = "CocAction('formatSelected')"
        \| endif
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <silent> <C-m> <Plug>(coc-cursors-position)
xmap <silent> <C-m> <Plug>(coc-cursors-range)
nmap <silent> <leader>x <Plug>(coc-cursors-operator)
nmap <silent> <leader>R :RenameWord<CR>
