let mapleader="\<Space>"

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'H '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

imap <BS> <Plug>(PearTreeBackspace)
imap <Esc> <Plug>(PearTreeFinishExpansion)
imap <Space> <Plug>(PearTreeSpace)
imap <C-f> <Plug>(PearTreeJump)

nnoremap <silent> <leader>ce :CocCommand explorer --toggle<CR>

nnoremap <silent> <leader>ge :call GoyoEnter()<CR>
nnoremap <silent> <leader>gl :call GoyoLeave()<CR>

""""""" NERDTreeCommenter
map  <Plug>NERDCommenterToggle

""""""" Tags
nnoremap <leader>t :call MakeTagsFile()<CR>

""""""" LineJuggler
nnoremap <silent> [<Leader> :<C-u>call append(line('.') - 1, repeat([''], v:count1))<CR>
nnoremap <silent> ]<Leader> :<C-u>call append(line('.'), repeat([''], v:count1))<CR>

""""""" General leader
nnoremap <leader>W :wqa<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>e :e<CR>
nnoremap <leader>E :e!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>* :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <leader>/ :noh<CR>

""""""" Split
nnoremap <silent> <leader>" :sbn<CR>
nnoremap <silent> <leader>% :vert sbn<CR>

""""""" FZF

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
			\   'rg --hidden --column --no-heading --line-number --color=always '
      \   . shellescape(<q-args>),
      \ 0,
      \ { 'options': $FZF_COMPLETION_OPTS . '--delimiter : --nth 4..' },
      \ <bang>0)
nnoremap <silent> <leader>r :call FZFOpen(':Rg')<CR>

nnoremap <silent> <leader>; :Commands<CR>
nnoremap <silent> <leader>f :call FZFOpen(
      \   ":call fzf#vim#files('', fzf#vim#with_preview({}, 'up:70%'))")<CR>
nnoremap <silent> <leader>m :call FZFOpen(':Marks')<CR>
nnoremap <silent> <leader>M :call FZFOpen(':Maps')<CR>
nnoremap <silent> <leader>i :IndentLinesToggle<CR>

""""""" Plugin panes
nnoremap <silent> <leader>U :MundoToggle<CR>
nnoremap <silent> <leader>V :Vista!!<CR>
nnoremap <silent> <leader>T :TagbarToggle<CR>

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

""""""" Pmenu
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"
inoremap <silent><expr> <Tab>
      \ pumvisible()
      \   ? "\<C-n>"
      \   : <SID>check_back_space()
      \     ? "\<Tab>"
      \     : coc#refresh()
inoremap <silent><expr> <CR>
      \ pumvisible()
      \   ? "\<C-y>"
      \   : pear_tree#insert_mode#PrepareExpansion()

""""""" Formatting
command! -nargs=0 -range -bar CocFormat call s:CocFormat(<range>, <line1>, <line2>)
vmap <silent> <leader>F  <Plug>(coc-format-selected)
nmap <silent> <leader>F  <Plug>(coc-format)

""""""" Highlights
command! RGBPicker :call CocAction('pickColor')<CR>
command! RGBOptions :call CocAction('colorPresentation')<CR>

""""""""""""""""" Function Keys """""""""""""""""""

""""""" Help under cursor
nnoremap <F1> :H <C-r><C-w><CR>

""""""" Replaces
nnoremap <F2> :s//g<Left><Left>
nnoremap <F3> :%s//g<Left><Left>

""""""" Spell checking
nnoremap <F7> :set spell!<CR>
inoremap <F7> <esc>:set spell!<CR>a

""""""""""""""""" Buffer Control """""""""""""""""""

""""""" Buffers
nnoremap <Tab>    :bn<CR>
nnoremap <S-Tab>  :bp<CR>
nnoremap <silent> <leader>bd :bn<CR>:bd#<CR>
nnoremap <silent> <leader>bl :call FZFOpen(':Buffer')<CR>
nnoremap <silent> <leader>bD :%bd\|e#\|bn\|bd<CR>
nnoremap <silent> <leader>be :enew<CR>
nnoremap <silent> <leader>b# <C-^>
nnoremap <silent> <leader>#  <C-^>
nnoremap <silent> <leader>b1 :b1<CR>
nnoremap <silent> <leader>b2 :b2<CR>
nnoremap <silent> <leader>b3 :b3<CR>
nnoremap <silent> <leader>b4 :b4<CR>

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

"""""""""""""""""""""" Misc """"""""""""""""""""""

""""""" EasyAlign
xnoremap <leader>e :EasyAlign<CR>

""""""" Indenting
xnoremap <       <gv
xnoremap >       >gv
xnoremap <s-tab> <gv
xnoremap <tab>   >gv

""""""" Case beefs
nnoremap Q   q
nnoremap Q!  q!
command! Wqa wqa
command! WQa wqa
command! WQ  wq
command! Wq  wq
command! W   w
command! Q   q

" Old

" nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
" xnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

" nnoremap <leader>nt :NERDTreeToggle<CR>
" nnoremap <leader>nr :call NERDTreeResize()<CR>
