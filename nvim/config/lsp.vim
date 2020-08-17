hi! HoverMatch guibg=#382832

function! s:hover_match()
  let w = expand('<cword>')
  if (w =~ '^[#_a-zA-Z0-9]*$')
    exe '2match HoverMatch "' . w . '"'
  else
    2match none
  endif
endfunction

augroup lsp
  au!
  au BufEnter   * lua    require'completion'.on_attach()
  au CursorHold * silent lua vim.lsp.util.show_line_diagnostics()
  au CursorHold * silent call <SID>hover_match()
augroup END

set completeopt=menuone,noinsert,noselect
set shortmess+=c

function! s:show_documentation()
  if &filetype == 'vim'
    exe 'H ' . expand('<cword>')
  elseif &filetype == 'sh' || &filetype == 'zsh'
    if luaeval("vim.lsp.buf.hover()") == v:null
      call FloatingMan(expand('<cword>'))
    endif
  else
    lua vim.lsp.buf.hover()
  endif
endfunction

function! s:go_to_definition()
  if luaeval("vim.lsp.buf.definition()") == v:null
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
  endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

nnoremap <silent>       gd        :lua vim.lsp.buf.definition()<CR>
nnoremap <silent>       gh        :lua vim.lsp.buf.hover()<CR>
nnoremap <silent>       gD        :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent>       <C-k>     :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent>       1gD       :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent>       gr        :lua vim.lsp.buf.references()<CR>
nnoremap <silent>       g0        :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent>       gW        :lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent>       ]c        :NextDiagnosticCycle<CR>
nnoremap <silent>       [c        :PrevDiagnosticCycle<CR>
nnoremap <silent>       K         :call <SID>show_documentation()<CR>
nnoremap <silent>       <C-]>     :call <SID>go_to_definition()<CR>
nnoremap <silent>       <leader>F :lua vim.lsp.buf.formatting()<CR>
inoremap <silent><expr> <Tab>     pumvisible()
      \ ? "\<C-n>"
      \ : <SID>check_back_space()
      \   ? "\<Tab>"
      \   : completion#trigger_completion()
inoremap <silent><expr> <S-Tab>   pumvisible()
      \ ? "\<C-p>"
      \ : <SID>check_back_space()
      \   ? "\<S-Tab>"
      \   : completion#trigger_completion()

let g:diagnostic_auto_popup_while_jump = 0
let g:completion_enable_auto_signature = 0
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '
let g:space_before_virtual_text = 2
let g:diagnostic_enable_underline = 1
let g:UltiSnipsExpandTrigger="<M-U>"
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_tabnine_max_num_results=3
let g:completion_auto_change_source = 1
let g:completion_chain_complete_list = {
    \  'default': [
    \    { 'complete_items': [ 'lsp', 'path', 'ts', 'snippet', 'buffers', 'tabnine'  ] },
    \    { 'mode': '<C-p>' }, { 'mode': '<C-n>' }
    \  ]
    \ }
