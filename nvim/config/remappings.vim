let mapleader="\<Space>"
nmap <leader> <NOP>

let g:resize_increment = get(g:, 'resize_increment', 2)

func! s:edge_of_screen(dir)
  let w = winnr()
  silent! exe "normal! \<C-w>" . a:dir
  let n = winnr()
  silent! exe w . 'wincmd w'
  return w == n
endfunc

func! s:resize_in_direction(dir)
  if winnr('$') == 1 | return | endif
  exe (index(['h', 'l'], a:dir) != -1 ? 'vertical ' : '') . 'resize '
        \ . (<SID>edge_of_screen(a:dir) ? '-' : '+') . g:resize_increment
endfunc

func! s:win_move(k)
  let t:curwin = winnr()
  exe "wincmd " . a:k
  if(a:k == 'h' || expand('%') =~# 'coc-explorer')
    return
  endif
  if(t:curwin == winnr())
    if(match(a:k, '[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exe "wincmd " . a:k
  endif
endfunc

let $FZF_PREVIEW_COMMAND = "bat --italic-text=always --style=numbers --color=always {} ||"
      \ . " highlight -O ansi -l {} || coderay {} || rougify {} || cat {}"
let $FZF_DEFAULT_OPTS='--layout=reverse --margin=1,1'
let g:fzf_layout = { 'window': 'call FloatingCentred()' }
let g:fzf_history_dir = expand("$HOME/.fzf/.fzf_history_dir")

func! FzfOpenNotExplorer(command_str)
  if expand('%') =~# 'coc-explorer' && winnr('$') > 1
    exe "normal! \<C-w>\<C-w>"
  endif
  exe 'normal! ' . a:command_str . "\<CR>"
endfunc

func! FilesFzf(query)
  let fzf_opts = {
        \   'options': [
        \     '--query', a:query,
        \   ]
        \ }
  call fzf#vim#files('', fzf#vim#with_preview(fzf_opts, 'up:70%'))
endfunc

let s:rg_cmd = 'rg -g "!{node_modules,package-lock.json,yarn.lock}" '
      \  . '--hidden '
      \  . '--ignore-vcs '
      \  . '--column '
      \  . '--no-heading '
      \  . '--line-number '
      \  . '--color=always '
      \  . '-- '

func! RipgrepFzf(query, bang)
  let fzf_opts = {
        \   'options': [
        \     '--delimiter', ':',
        \     '--nth', '4..',
        \     '--query', a:query,
        \   ]
        \ }
  call fzf#vim#grep(s:rg_cmd . shellescape(a:query), 1,
        \ fzf#vim#with_preview(fzf_opts), a:bang)
endfunc

func! RipgrepFzfUnderCursor()
  let w = expand('<cword>')
  if w =~ "^[_a-zA-Z0-9]\\+$"
    let fzf_opts = { 'down': '20%', 'options': [ '--margin', '0,0' ] }
    call fzf#vim#grep(s:rg_cmd . shellescape(w), 1, fzf#vim#with_preview(fzf_opts), 0)
  else
    echo '"' . w . '" does not match /^[_a-za-Z0-9]+/'
  endif
endfunc

" Mode -| Modifiers ---| Key(s) --| Action ----------------------------------------------------- "
nnoremap <silent>       <leader>E  :e!<CR>
nnoremap <silent>       <leader>Q  :qa!<CR>
nnoremap <silent>       <leader>W  :wqa<CR>
nnoremap <silent>       <leader>e  :e<CR>
nnoremap <silent>       <leader>q  :q<CR>
nnoremap <silent>       <leader>w  :w<CR>
nnoremap                Q          q
nnoremap                Q!         q!

nnoremap <silent>       <F1>       :H <C-r><C-w><CR>
nnoremap <silent>       <F2>       :syn sync fromstart<CR>
nnoremap <silent>       <F7>       :set spell!<CR>
inoremap <silent>       <F7>       <C-o>:set spell!<CR>

" WIP
inoremap <silent><expr>  <BS>
      \ getline('.')[:col('.') - 2] =~ '^\s\+$'
      \ ? getline(line('.') - 1) =~ '^\s*$'
      \   ? getline('.') =~ '^\s*$'
      \     ? "<Esc>ck"
      \     : "<C-o>:exe line('.') - 1 . 'delete'<CR>"
      \   : "<C-w><BS>"
      \ : pear_tree#insert_mode#Backspace()

inoremap <silent><expr> <C-f>      pear_tree#insert_mode#JumpOut()
inoremap <silent><expr> <Esc>      pear_tree#insert_mode#Expand()
inoremap <silent><expr> <Space>    pear_tree#insert_mode#Space()

map                              <Plug>NERDCommenterToggle
nnoremap                <C-p>      <Tab>
nnoremap                <leader>*  :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <silent>       <leader>/  :noh<CR>
nnoremap <silent>       <leader>;  :Commands<CR>
nnoremap <silent>       <leader>M  :call FzfOpenNotExplorer(':Maps')<CR>
nnoremap <silent>       <leader>T  :TagbarToggle<CR>
nnoremap <silent>       <leader>U  :MundoToggle<CR>
nnoremap <silent>       <leader>V  :Vista!!<CR>

nnoremap <silent>       <C-M-h>    :call <SID>resize_in_direction('h')<CR>
nnoremap <silent>       <C-M-j>    :call <SID>resize_in_direction('j')<CR>
nnoremap <silent>       <C-M-k>    :call <SID>resize_in_direction('k')<CR>
nnoremap <silent>       <C-M-l>    :call <SID>resize_in_direction('l')<CR>

nnoremap <silent>       <leader>"  :sbn<CR>
nnoremap <silent>       <leader>#  <C-^>
nnoremap <silent>       <leader>%  :vert sbn<CR>
nnoremap <silent>       <leader>bD :BufOnly<CR>
nnoremap <silent><expr> <leader>bd Bclose
nnoremap <silent>       <leader>be :enew<CR>
nnoremap <silent>       <leader>bl :call FzfOpenNotExplorer(':Buffer')<CR>

nnoremap <silent>       <S-down>   :m+<CR>
nnoremap <silent>       <S-up>     :m-2<CR>
nnoremap <silent>       <S-Tab>    :bp<CR>
nnoremap <silent>       <Tab>      :bn<CR>
xnoremap                <          <gv
xnoremap                >          >gv
xnoremap                <leader>e  :EasyAlign<CR>
xnoremap                <S-tab>    <gv
xnoremap                <Tab>      >gv
inoremap                <S-down>   <C-o>:m+<CR>
inoremap                <S-up>     <C-o>:m-2<CR>
xnoremap                <S-down>   :m'>+<CR>gv=gv
xnoremap                <S-up>     :m-2<CR>gv=gv

nnoremap <silent>       <leader>ce :CocCommand explorer --toggle<CR>
nnoremap <silent>       <leader>f  :call FzfOpenNotExplorer(":FilesFzf")<CR>
nnoremap <silent>       <leader>gg :Git<CR>
nnoremap <silent>       <leader>gl :ToggleLazyGit<CR>
nnoremap <silent>       <leader>i  :IndentLinesToggle<CR>
nnoremap <silent>       <leader>m  :call FzfOpenNotExplorer(':Marks')<CR>
nnoremap <silent>       <leader>r  :call FzfOpenNotExplorer(':Rg')<CR>
nnoremap <silent>       <leader>z  :ZoomToggle<CR>
nnoremap <silent>       [<Leader>  :<C-u>call append(line('.') - 1, repeat([''], v:count1))<CR>
nnoremap <silent>       ]<Leader>  :<C-u>call append(line('.'), repeat([''], v:count1))<CR>
nnoremap <silent>       <M-]>      :call RipgrepFzfUnderCursor()<CR>
nnoremap <silent>       ‘          :call RipgrepFzfUnderCursor()<CR>
nnoremap <silent>       <leader>}  zf}

" Mode -| Arguments ---| Name -------| Action -------------------------- "
command! -nargs=0       ToggleLazyGit w | call FloatingTerm('lazygit')
command!                Wqa           wqa
command!                WQa           wqa
command!                WQ            wq
command!                Wq            wq
command!                W             w
command!                Q             q
command! -nargs=0       DiffThis      windo diffthis
command! -nargs=0       DiffOff       windo diffoff
command! -bang -nargs=* Rg            call RipgrepFzf(<q-args>, <bang>0)
command! -bang -nargs=* FilesFzf      call FilesFzf(<q-args>)
