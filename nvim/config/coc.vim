" exists(...) returns false for autoloaded functions apparently
try
  silent call coc#add_extension()
catch /E117/
  finish
endtry

let s:coc_extensions = [[
      \ 'coc-actions',
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-docker',
      \ 'coc-eslint',
      \ 'coc-explorer',
      \ 'coc-go',
      \ 'coc-html',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-lists',
      \ ], [
      \ 'coc-highlight',
      \ 'coc-markdownlint',
      \ 'coc-python',
      \ 'coc-rls',
      \ 'coc-snippets',
      \ 'coc-tag',
      \ 'coc-tslint-plugin',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]]

function! s:AddCocExtensions()
  for ext_lst in s:coc_extensions
    exe 'CocInstall ' . join(ext_lst, ' ')
  endfor
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
  if CocAction('jumpDefinition') | return | endif
  redraw | echo
  for expr in ['<cword>', '<cWORD>', '<cexpr>']
    let tag = expand(expr)
    if len(taglist('^' . tag . '$'))
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

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

" Mode -| Modifiers ---| Key(s) --| Action ----------------------------------------------------- "
inoremap         <expr> <S-Tab>    pumvisible() ? "\<C-p>" : "\<C-d>"
inoremap <silent><expr> <CR>       pumvisible() ? "\<C-y>" : pear_tree#insert_mode#PrepareExpansion()
inoremap <silent><expr> <Tab>      pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
xmap     <silent>       <leader>a  :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap     <silent>       <leader>a  :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
nmap     <silent>       [c         <Plug>(coc-diagnostic-prev)
nmap     <silent>       [c         <Plug>(coc-diagnostic-prev)
nmap     <silent>       ]c         <Plug>(coc-diagnostic-next)
nmap     <silent>       gK         :CocCommand git.chunkInfo<CR>
nmap     <silent>       <C-m>      <Plug>(coc-cursors-position)
nmap     <silent>       <leader>F  <Plug>(coc-format)
nmap     <silent>       <leader>R  :RenameWord<CR>
nmap     <silent>       <leader>gd <Plug>(coc-definition)
nmap     <silent>       <leader>gi <Plug>(coc-implementation)
nmap     <silent>       <leader>gr <Plug>(coc-references)
nmap     <silent>       <leader>gt <Plug>(coc-type-definition)
nmap     <silent>       <leader>x  <Plug>(coc-cursors-operator)
nnoremap <silent>       K          :call <SID>show_documentation()<CR>
nnoremap <silent>       <C-]>      :call <SID>go_to_definition()<CR>
nnoremap <silent>       <leader>d  :CocList --auto-preview diagnostics<CR>
nnoremap <silent>       <leader>l  :CocList<CR>
nnoremap <silent>       <leader>s  :CocList commands<CR>
vmap     <silent>       <leader>F  <Plug>(coc-format-selected)
xmap     <silent>       <C-m>      <Plug>(coc-cursors-range)

" Mode --| Arguments -| Name ----------| Action ----------------------------------------------------- "
command!               RGBPicker        call CocAction('pickColor')
command!               RGBOptions       call CocAction('colorPresentation')
command!  -nargs=0     AddCocExtensions call <SID>AddCocExtensions()
command!  -nargs=0     RenameWord       CocCommand document.renameCurrentWord

" Autocmd -| Event --------| Condition -------| Action ------------------------------------------------- "
augroup coc-autocmds
  autocmd!
  autocmd   FileType        *                  let &formatexpr = "CocAction('formatSelected')"
  autocmd   CursorHold      *                  silent call CocActionAsync('highlight')
  " autocmd   CompleteDone    *                  if pumvisible() == 0 | pclose | endif
  autocmd   User            CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd   FileType        coc-explorer       setlocal wrapmargin=0 signcolumn=no | silent! IndentLinesDisable
augroup end
