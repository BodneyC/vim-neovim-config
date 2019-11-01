" =============================================================================
" Filename: autoload/lightline/colorscheme/VimSpectre300light.vim
" Author: BodneyC
" License: MIT License
" Last Change: 2019-10-31
" =============================================================================

let s:red    = '#e07d38'
let s:green  = '#967d96'
let s:blue   = '#4286c9'
let s:pink   = '#c26e84'
let s:olive  = '#699e34'
let s:navy   = '#7d5e7d'
let s:orange = '#d579e8'
let s:purple = '#8959a8'
let s:aqua   = '#b86ab4'

" Basics:
let s:foreground = '#7d5e7d'
let s:background = '#f0ddf0'
let s:window     = '#efefef'
let s:status     = s:aqua
let s:error      = '#ffafdf'

" Tabline:
let s:tabline_bg          = s:navy
let s:tabline_active_fg   = s:foreground
let s:tabline_active_bg   = s:window
let s:tabline_inactive_fg = s:background
let s:tabline_inactive_bg = s:aqua

" Statusline:
let s:statusline_active_fg   = s:window
let s:statusline_active_bg   = s:navy
let s:statusline_inactive_fg = s:foreground
let s:statusline_inactive_bg = '#dadada'

let s:p                 = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left     = [ [ s:foreground, s:background ], [ s:statusline_active_fg, s:aqua ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.normal.right    = [ [ s:foreground, s:background ], [ s:statusline_active_fg, s:aqua ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.normal.middle   = [ [ s:statusline_active_fg, s:statusline_active_bg ]]
let s:p.normal.error    = [ [ s:background, s:error ] ]
let s:p.normal.warning  = [ [ s:background, s:olive ] ]
let s:p.inactive.right  = [ [ s:foreground, s:background ], [ s:foreground, s:background ] ]
let s:p.inactive.left   = [ [ s:foreground, s:background ], [ s:foreground, s:background ] ]
let s:p.inactive.middle = [ [ s:foreground, s:background ], ]
let s:p.insert.left     = [ [ s:background, s:blue ], [ s:statusline_active_fg, s:aqua ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.replace.left    = [ [ s:background, s:pink ], [s:statusline_active_fg, s:aqua ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.visual.left     = [ [ s:background, s:orange ], [s:statusline_active_fg, s:aqua ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.tabline.left    = [ [s:tabline_inactive_fg, s:tabline_inactive_bg ]]
let s:p.tabline.tabsel  = [ [s:tabline_active_fg, s:tabline_active_bg ] ]
let s:p.tabline.middle  = [ [s:tabline_bg, s:tabline_bg]]
let s:p.tabline.right   = copy(s:p.normal.right)

let g:lightline#colorscheme#VimSpectre300light#palette = lightline#colorscheme#fill(s:p)
