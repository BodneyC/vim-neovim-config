let mapleader="\<Space>"

" In-vim
nnoremap <leader>W :wqa<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>e :e<CR>
nnoremap <leader>E :e!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>* :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <leader>/ :noh<CR>
nnoremap Q         q
nnoremap Q!        q!

command! Wqa       wqa
command! WQa       wqa
command! WQ        wq
command! Wq        wq
command! W         w
command! Q         q

xnoremap <         <gv
xnoremap >         >gv
xnoremap <s-tab>   <gv
xnoremap <tab>     >gv

nnoremap <silent>  <leader>" :sbn<CR>
nnoremap <silent>  <leader>% :vert sbn<CR>
nnoremap <silent>  <leader>z :ZoomToggle<CR>

nnoremap <silent> [<Leader> :<C-u>call append(line('.') - 1, repeat([''], v:count1))<CR>
nnoremap <silent> ]<Leader> :<C-u>call append(line('.'), repeat([''], v:count1))<CR>

" F-keys
nnoremap <F1> :H <C-r><C-w><CR>
nnoremap <F7> :set spell!<CR>
inoremap <F7> <esc>:set spell!<CR>a

" Buffers
nnoremap <C-q> <C-i>
nnoremap <Tab>    :w\|bn<CR>
nnoremap <S-Tab>  :w\|bp<CR>
nnoremap <silent> <leader>bd :bn<CR>:bd#<CR>
nnoremap <silent> <leader>bD :%bd\|e#\|bn\|bd<CR>
nnoremap <silent> <leader>be :enew<CR>
nnoremap <silent> <leader>#  <C-^>
nnoremap <silent> <leader>b1 :b1<CR>
nnoremap <silent> <leader>b2 :b2<CR>
nnoremap <silent> <leader>b3 :b3<CR>
nnoremap <silent> <leader>b4 :b4<CR>

" Moving lines up and down
xnoremap <S-up>   :m-2<CR>gv=gv
xnoremap <S-down> :m'>+<CR>gv=gv
nnoremap <S-up>   :m-2<CR>
nnoremap <S-down> :m+<CR>
inoremap <S-up>   <Esc>:m-2<CR>a
inoremap <S-down> <Esc>:m+<CR>a

" Navigation
function! s:win_move(k)
  let t:curwin = winnr()
  exec "wincmd " . a:k
  if(a:k == 'h' || expand('%') == '[coc-explorer]')
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
nnoremap <silent> <C-h> :call <SID>win_move('h')<CR>
nnoremap <silent> <C-j> :call <SID>win_move('j')<CR>
nnoremap <silent> <C-k> :call <SID>win_move('k')<CR>
nnoremap <silent> <C-l> :call <SID>win_move('l')<CR>

" Coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <silent><expr> <CR>
      \ pumvisible() ? "\<C-y>" : pear_tree#insert_mode#PrepareExpansion()

nmap <silent> <leader>F  <Plug>(coc-format)
vmap <silent> <leader>F  <Plug>(coc-format-selected)

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> gK :CocCommand git.chunkInfo<CR>

nnoremap <silent> <leader>l :CocList<CR>
nnoremap <silent> <leader>d :CocList --auto-preview diagnostics<CR>
nnoremap <silent> <leader>s :CocList commands<CR>

command! RGBPicker :call CocAction('pickColor')<CR>
command! RGBOptions :call CocAction('colorPresentation')<CR>

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
command! -nargs=0 -range -bar CocFormat call s:CocFormat(<range>, <line1>, <line2>)

" Plugins
xnoremap <leader>e :EasyAlign<CR>

nnoremap <silent> <leader>U :MundoToggle<CR>
nnoremap <silent> <leader>V :Vista!!<CR>
nnoremap <silent> <leader>T :TagbarToggle<CR>

let $FZF_DEFAULT_OPTS='--layout=reverse --margin=1,1'

function! FloatingFzf()
  call FloatingCentred()
endfunction
let g:fzf_layout = { 'window': 'call FloatingFzf()' }

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg -g "!{node_modules,.git,package-lock.json,yarn.lock}" --hidden '
      \   . '--ignore-vcs --column --no-heading --line-number --color=always '
      \   . shellescape(<q-args>),
      \ 0,
      \ { 'options': $FZF_COMPLETION_OPTS . '--delimiter : --nth 4..' },
      \ <bang>0)

function! FZFOpen(command_str)
  if expand('%') =~# 'NERD_tree' && winnr('$') > 1
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction
nnoremap <silent> <leader>r :call FZFOpen(':Rg')<CR>
nnoremap <silent> <leader>bl :call FZFOpen(':Buffer')<CR>
nnoremap <silent> <leader>; :Commands<CR>
nnoremap <silent> <leader>f :call FZFOpen(
      \ ":call fzf#vim#files('', fzf#vim#with_preview({}, 'up:70%'))")<CR>
nnoremap <silent> <leader>m :call FZFOpen(':Marks')<CR>
nnoremap <silent> <leader>M :call FZFOpen(':Maps')<CR>

nnoremap <silent> <leader>i :IndentLinesToggle<CR>

map  <Plug>NERDCommenterToggle

nnoremap <silent> <leader>ce :CocCommand explorer --toggle<CR>
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>

inoremap <silent><expr> <BS>    pear_tree#insert_mode#Backspace()
inoremap <silent><expr> <Esc>   pear_tree#insert_mode#Expand()
inoremap <silent><expr> <Space> pear_tree#insert_mode#Space()
inoremap <silent><expr> <C-f>   pear_tree#insert_mode#JumpOut()

nnoremap <silent> <leader>gg :Git<CR>

command! -nargs=0 ToggleLazyGit w | call FloatingTerm('lazygit')
nnoremap <silent> <leader>gl :ToggleLazyGit<CR>
