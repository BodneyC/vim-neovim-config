" Vim syntax file
" Language: Kitty Config
" Maintainer: BodneyC
" Latest Revision: 2020-02-16

if exists("b:current_syntax")
  finish
endif

syn match kittyConfLine  contains=kittyConfLeft,kittyConfRight '^[^ ]\+ \+.*$'
syn match kittyConfLeft  contained '^[^ ]\+'
syn match kittyConfRight contained ' \zs[^ ].*$'

syn match kittyConfMapCmd  '^map \ze.*'me=e-1 nextgroup=kittyConfMapFrom
syn match kittyConfMapFrom contained ' \+[^ ]\+\ze.*' nextgroup=kittyConfMapTo
syn match kittyConfMapTo   contained '\zs.*$'

syn match kittyConfComment '^#.*'

hi def kittyConfLeft  ctermbg=NONE ctermfg=blue  guibg=NONE guifg='#bdf5f8'
hi def kittyConfRight ctermbg=NONE ctermfg=red   guibg=NONE guifg='#fcb8b8'
hi def kittyConfMapTo ctermbg=NONE ctermfg=green guibg=NONE guifg='#c8fcc8'

hi def link kittyConfMapCmd  kittyConfLeft
hi def link kittyConfMapFrom kittyConfRight
hi def link kittyConfComment Comment

let b:current_syntax = 'kitty-conf'
