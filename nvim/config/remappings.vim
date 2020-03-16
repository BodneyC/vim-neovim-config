let mapleader="\<Space>"

function! s:win_move(k)
  let t:curwin = winnr()
  exec "wincmd " . a:k
  if(a:k == 'h' || expand('%') =~# 'coc-explorer') | return | endif
  if(t:curwin == winnr())
    if(match(a:k, '[jk]')) | wincmd v
    else | wincmd s | endif
    exec "wincmd " . a:k
  endif
endfunction

let $FZF_DEFAULT_OPTS='--layout=reverse --margin=1,1'
let g:fzf_layout = { 'window': 'call FloatingCentred()' }

function! FzfOpenNotExplorer(command_str)
  if expand('%') =~# 'coc-explorer' && winnr('$') > 1
    exe "normal! \<C-w>\<C-w>"
  endif
  exe 'normal! ' . a:command_str . "\<CR>"
endfunction

" Mode ----| Modifiers ----| Key(s) ------| Action ----------------------------------------------------- "
nnoremap                    <leader>E      :e!<CR>
nnoremap                    <leader>Q      :qa!<CR>
nnoremap                    <leader>W      :wqa<CR>
nnoremap                    <leader>e      :e<CR>
nnoremap                    <leader>q      :q<CR>
nnoremap                    <leader>w      :w<CR>
nnoremap                    Q              q
nnoremap                    Q!             q!

nnoremap                    <F1>           :H <C-r><C-w><CR>
inoremap                    <F7>           <esc>:set spell!<CR>a
nnoremap                    <F7>           :set spell!<CR>

inoremap    <silent><expr>  <BS>           pear_tree#insert_mode#Backspace()
inoremap    <silent><expr>  <C-f>          pear_tree#insert_mode#JumpOut()
inoremap    <silent><expr>  <Esc>          pear_tree#insert_mode#Expand()
inoremap    <silent><expr>  <Space>        pear_tree#insert_mode#Space()

map                                      <Plug>NERDCommenterToggle
nnoremap                    <C-q>          <Tab>
nnoremap                    <leader>*      :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap    <silent>        <leader>/      :noh<CR>
nnoremap    <silent>        <leader>;      :Commands<CR>
nnoremap    <silent>        <leader>M      :call FzfOpenNotExplorer(':Maps')<CR>
nnoremap    <silent>        <leader>T      :TagbarToggle<CR>
nnoremap    <silent>        <leader>U      :MundoToggle<CR>
nnoremap    <silent>        <leader>V      :Vista!!<CR>

nnoremap    <silent>        <C-h>          :call <SID>win_move('h')<CR>
nnoremap    <silent>        <C-j>          :call <SID>win_move('j')<CR>
nnoremap    <silent>        <C-k>          :call <SID>win_move('k')<CR>
nnoremap    <silent>        <C-l>          :call <SID>win_move('l')<CR>
nnoremap    <silent>        <leader>"      :sbn<CR>
nnoremap    <silent>        <leader>#      <C-^>
nnoremap    <silent>        <leader>%      :vert sbn<CR>
nnoremap    <silent>        <leader>b1     :b1<CR>
nnoremap    <silent>        <leader>b2     :b2<CR>
nnoremap    <silent>        <leader>b3     :b3<CR>
nnoremap    <silent>        <leader>b4     :b4<CR>
nnoremap    <silent>        <leader>bD     :%bd\|e#\|bn\|bd<CR>
nnoremap    <silent>        <leader>bd     :if len(getbufinfo({'buflisted':1})) > 1 \| bn\|bd# \| endif<CR>
nnoremap    <silent>        <leader>be     :enew<CR>
nnoremap    <silent>        <leader>bl     :call FzfOpenNotExplorer(':Buffer')<CR>
nnoremap    <silent>        <S-down>       :m+<CR>
nnoremap    <silent>        <S-up>         :m-2<CR>
nnoremap    <silent>        <S-Tab>        :bp<CR>
nnoremap    <silent>        <Tab>          :bn<CR>

nnoremap    <silent>        <leader>ce     :CocCommand explorer --toggle<CR>
nnoremap    <silent>        <leader>f      :call FzfOpenNotExplorer(":call fzf#vim#files('', fzf#vim#with_preview({}, 'up:70%'))")<CR>
nnoremap    <silent>        <leader>gg     :Git<CR>
nnoremap    <silent>        <leader>gl     :ToggleLazyGit<CR>
nnoremap    <silent>        <leader>i      :IndentLinesToggle<CR>
nnoremap    <silent>        <leader>m      :call FzfOpenNotExplorer(':Marks')<CR>
nnoremap    <silent>        <leader>nt     :NERDTreeToggle<CR>
nnoremap    <silent>        <leader>r      :call FzfOpenNotExplorer(':Rg')<CR>
nnoremap    <silent>        <leader>z      :ZoomToggle<CR>
nnoremap    <silent>        [<Leader>      :<C-u>call append(line('.') - 1, repeat([''], v:count1))<CR>
nnoremap    <silent>        ]<Leader>      :<C-u>call append(line('.'), repeat([''], v:count1))<CR>

xnoremap                    <              <gv
xnoremap                    >              >gv
xnoremap                    <leader>e      :EasyAlign<CR>
xnoremap                    <S-tab>        <gv
xnoremap                    <Tab>          >gv
inoremap                    <S-down>       <Esc>:m+<CR>a
inoremap                    <S-up>         <Esc>:m-2<CR>a
xnoremap                    <S-down>       :m'>+<CR>gv=gv
xnoremap                    <S-up>         :m-2<CR>gv=gv

" Mode ----| Arguments ----| Name --------| Action ----------------------------------------------------- "
command!    -nargs=0        ToggleLazyGit  w | call FloatingTerm('lazygit')
command!                    Wqa            wqa
command!                    WQa            wqa
command!                    WQ             wq
command!                    Wq             wq
command!                    W              w
command!                    Q              q
command!    -bang -nargs=*  Rg             call fzf#vim#grep(
                                                \ 'rg -g "!{node_modules,.git,package-lock.json,yarn.lock}" --hidden '
                                                \   . '--ignore-vcs --column --no-heading --line-number --color=always '
                                                \   . shellescape(<q-args>),
                                                \ 0,
                                                \ { 'options': $FZF_COMPLETION_OPTS . '--delimiter : --nth 4..' },
                                                \ <bang>0)
