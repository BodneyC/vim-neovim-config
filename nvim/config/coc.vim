let s:coc_extensions = [ 'coc-css', 'coc-diagnostic', 'coc-docker', 'coc-emmet', 'coc-eslint',
      \ 'coc-explorer', 'coc-html', 'coc-json', 'coc-lists', 'coc-python', 'coc-rls',
      \ 'coc-snippets', 'coc-syntax', 'coc-tag', 'coc-tslint-plugin', 'coc-tsserver',
      \ 'coc-highlight', 'coc-java', 'coc-vimlsp', 'coc-yaml', 'coc-markdownlint']
for s:ext in s:coc_extensions
  exe 'call coc#add_extension("' . s:ext . '")'
endfor

let g:coc_filetypes = [ 'Dockerfile', 'Jenkinsfile', 'css', 'go', 'groovy', 'html', 'java',
      \ 'javascript', 'javascript.jsx', 'json', 'kotlin', 'markdown', 'python', 'rust', 'sh',
      \ 'typescript', 'typescript.jsx', 'vim', 'xml', 'yaml', ]

function! IsCocEnabled()
  return index(g:coc_filetypes, &filetype) >= 0
endfunction

function! s:show_documentation()
  if &filetype == 'vim'
    exe 'H ' . expand('<cword>')
  elseif &filetype == 'sh' || &filetype == 'zsh'
    if ! CocAction('doHover')
      call FloatingMan(expand('<cword>'))
    endif
  else
    call CocAction('doHover')
  endif
endfunction

function! s:go_to_definition()
  if IsCocEnabled() && CocAction('jumpDefinition') | return | endif
  redraw | echo
  for l:expr in ['<cword>', '<cWORD>', '<cexpr>']
    let l:tag = expand(l:expr)
    if len(taglist('^' . l:tag . '$'))
      try
        exec 'tag ' . expand('<cword>')
        return
      catch | endtry
    endif
  endfor
  redraw | echo "Tag not found"
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

" Mode ----| Modifiers ----| Key(s) ------| Action ----------------------------------------------------- "
inoremap            <expr>  <S-Tab>        pumvisible() ? "\<C-p>" : "\<C-d>"
inoremap    <silent><expr>  <CR>           pumvisible() ? "\<C-y>" : pear_tree#insert_mode#PrepareExpansion()
inoremap    <silent><expr>  <Tab>          pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
nmap        <silent>        [c             <Plug>(coc-diagnostic-prev)
nmap        <silent>        ]c             <Plug>(coc-diagnostic-next)
nmap        <silent>        gK             :CocCommand git.chunkInfo<CR>
nmap        <silent>        <C-m>          <Plug>(coc-cursors-position)
nmap        <silent>        <leader>F      <Plug>(coc-format)
nmap        <silent>        <leader>R      :RenameWord<CR>
nmap        <silent>        <leader>gd     <Plug>(coc-definition)
nmap        <silent>        <leader>gi     <Plug>(coc-implementation)
nmap        <silent>        <leader>gr     <Plug>(coc-references)
nmap        <silent>        <leader>gt     <Plug>(coc-type-definition)
nmap        <silent>        <leader>x      <Plug>(coc-cursors-operator)
nnoremap    <silent>        K              :call <SID>show_documentation()<CR>
nnoremap    <silent>        <C-]>          :call <SID>go_to_definition()<CR>
nnoremap    <silent>        <leader>d      :CocList --auto-preview diagnostics<CR>
nnoremap    <silent>        <leader>l      :CocList<CR>
nnoremap    <silent>        <leader>s      :CocList commands<CR>
vmap        <silent>        <leader>F      <Plug>(coc-format-selected)
xmap        <silent>        <C-m>          <Plug>(coc-cursors-range)

" Mode ----| Arguments ----| Name --------| Action ----------------------------------------------------- "
command!                    RGBPicker      :call CocAction('pickColor')<CR>
command!                    RGBOptions     :call CocAction('colorPresentation')<CR>
command!    -nargs=0        RenameWord     CocCommand document.renameCurrentWord

" Autocmd -| Event --------| Condition -------| Action ------------------------------------------------- "
augroup vimrc-coc
  autocmd!
  autocmd   FileType        *                  if IsCocEnabled() | let &l:formatexpr = "CocAction('formatSelected')" | endif
  autocmd   CursorHold      *                  silent call CocActionAsync('highlight')
  autocmd   CompleteDone    *                  if pumvisible() == 0 | pclose | endif
  autocmd   User            CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd   FileType        coc-explorer       setlocal wrapmargin=0 signcolumn=no
augroup end
