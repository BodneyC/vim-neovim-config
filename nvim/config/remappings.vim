let mapleader="\<Space>"

""""""""""""""" Assisting Functions """""""""""""""

let g:bclose_no_plugin_maps=1

function! s:CocFormat(range, line1, line2) abort
  if a:range == 0
    call CocAction('format')
  else
    call cursor(a:line1, 1)
    normal! V
    call cursor(a:line2, 1)
    call CocAction('formatSelected', 'V')
  endif
endfunction

function! WinMove(k)
  let t:curwin = winnr()
  exec "wincmd " . a:k
  if(a:k == 'h')
    return
  endif
  if(t:curwin == winnr())
    if(match(a:k, '[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd " . a:k
  endif
endfunction

function! Goyo_e() abort
  Goyo
  Goyo!
  Goyo 65%x75%
endfunction
function! Goyo_l() abort
  Goyo!
  so ~/.config/nvim/config/highlighting.vim
endfunction

function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(&lines / 2)
  let width = float2nr(&columns / 1.7)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = float2nr((&lines - height) / 2)

  let opts = {
        \   'relative': 'editor',
        \   'row': vertical,
        \   'col': horizontal,
        \   'width': width,
        \   'height': height,
        \   'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

function! MakeTagsFile()
  if len(g:virk_root_dir) > 0 && g:virk_tags_enable != 0
    VSMakeTagsFile
  elseif ! exists('g:gutentags_generate_on_write')
    !DIR=$(git rev-parse --show-toplevel) && ctags -Rf $DIR/.git/tags $DIR
  else
    echom "VS tags disabled, gutentags in operation"
  endif
endfunction

function NERDTreeResize()
  let curWin = winnr()
  NERDTreeFocus
  silent! normal! gg"byG
  let maxcol = max(map(split(@b, "\n"), 'strlen(v:val)')) - 3
  exec 'vertical resize' maxcol
  exec curWin 'wincmd w'
endfunction
command! -nargs=0 NERDTreeResize :call NERDTreeResize()

"""""""""""""""" Leader Remappings """"""""""""""""

""""""" NERDTree
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nr :call NERDTreeResize()<CR>

nnoremap <leader>ge :call Goyo_e()<CR>
nnoremap <leader>gl :call Goyo_l()<CR>

""""""" NERDTreeCommenter
map  <Plug>NERDCommenterToggle

""""""" Tags
nnoremap <leader>t :call MakeTagsFile()<CR>

""""""" General leader
nnoremap <leader>W :wqa<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>e :e<CR>
nnoremap <leader>E :e!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>* :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <leader>/ :noh<CR>

""""""" Update .vimrc
nnoremap <leader>cs :so $MYVIMRC<CR>
nnoremap <leader>ce :e $MYVIMRC<CR>

""""""" Split
nnoremap <leader>" :sbn<CR>
nnoremap <leader>% :vert sbn<CR>

""""""" FZF
nnoremap <leader>f :call FZFOpen(":call fzf#vim#files('', fzf#vim#with_preview({}, 'up:70%'))")<CR>
nnoremap <leader>bl :call FZFOpen(':Buffer')<CR>
nnoremap <leader>r :call FZFOpen(':Rg')<CR>
nnoremap <leader>m :call FZFOpen(':Marks')<CR>
nnoremap <leader>M :call FZFOpen(':Maps')<CR>
nnoremap <leader>i :IndentLinesToggle<CR>

""""""" Plugin panes
nnoremap <Leader>R :Ranger<CR>
nnoremap <leader>U :MundoToggle<CR>
nnoremap <leader>V :Vista!!<CR>
nnoremap <leader>T :TagbarToggle<CR>

""""""""""""" Conquer of Completion """""""""""""""

""""""" Definitions
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

""""""" Commands
nnoremap <silent> <leader>l :CocList<CR>
nnoremap <silent> <leader>d :CocList --auto-preview diagnostics<CR>
nnoremap <silent> <leader>s :CocList commands<CR>

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

""""""" Tab completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

""""""" Formatting
command! -nargs=0 -range -bar CocFormat call s:CocFormat(<range>, <line1>, <line2>)
vmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format)

""""""""""""""""" Function Keys """""""""""""""""""

""""""" Help under cursor
nnoremap <F1> :help <C-r><C-w><CR>

""""""" Replaces
nnoremap <F2> :s//g<Left><Left>
nnoremap <F3> :%s//g<Left><Left>

""""""" Spell checking
nnoremap <F7> :set spell!<CR>
inoremap <F7> <esc>:set spell!<CR>a

""""""""""""""""" Buffer Control """""""""""""""""""

""""""" Buffers
nnoremap <Tab>   :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <leader>bd :bn<CR>:bd#<CR>
nnoremap <leader>be :enew<CR>
nnoremap <leader>b# <C-^>
nnoremap <leader>b1 :b1<CR>
nnoremap <leader>b2 :b2<CR>
nnoremap <leader>b3 :b3<CR>
nnoremap <leader>b4 :b4<CR>

""""""" Open file/links
nnoremap <silent> <leader>ox :call netrw#BrowseX(expand('<cfile>'),netrw#CheckIfRemote())<CR>
vnoremap <silent> <leader>ox :<C-u>call netrw#BrowseXVis()<CR>
nnoremap <silent> <leader>of :e <cfile><CR>

""""""""""""""""""" Movement """""""""""""""""""""

""""""" Moving lines up and down
xnoremap <S-up>   :m-2<CR>gv=gv
xnoremap <S-down> :m'>+<CR>gv=gv
nnoremap <S-up>   :m-2<CR>
nnoremap <S-down> :m+<CR>
inoremap <S-up>   <Esc>:m-2<CR>
inoremap <S-down> <Esc>:m+<CR>

""""""" Moving between panes
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>
inoremap <C-h> <Esc><C-h>
inoremap <C-j> <Esc><C-j>
inoremap <C-k> <Esc><C-k>
inoremap <C-l> <Esc><C-l>

"""""""""""""""""""""" Misc """"""""""""""""""""""

""""""" Indenting
xnoremap < <gv
xnoremap > >gv
xnoremap <s-tab> <gv
xnoremap <tab> >gv

""""""" Case beefs
nnoremap Q q
nnoremap Q! q!
command! Wqa wqa
command! WQa wqa
command! WQ wq
command! Wq wq
command! W w
command! Q q

command! -nargs=0 ConvLineEndings %s///g
