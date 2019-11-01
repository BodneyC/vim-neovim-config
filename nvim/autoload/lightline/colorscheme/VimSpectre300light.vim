" =============================================================================
" Filename: autoload/lightline/colorscheme/VimSpectre300light.vim
" Author: BodneyC
" License: MIT License
" Last Change: 2019-10-31
" =============================================================================

let s:blue         = '#4286c9'
let s:pink         = '#c26e84'
let s:green        = '#699e34'
let s:magenta      = '#7d5e7d'
let s:purple       = '#8959a8'
let s:purple_light = '#b86ab4'

" Basics:
let s:foreground     = '#7d5e7d'
let s:background     = '#f0fdf0'
let s:inactive_light = '#d8c3db'
let s:inactive_dark  = '#ded1e0'
let s:window         = '#efefef'
let s:error          = '#ffafdf'

" Tabline:
let s:tabline_bg          = s:magenta
let s:tabline_active_fg   = s:foreground
let s:tabline_active_bg   = s:window
let s:tabline_inactive_fg = s:background
let s:tabline_inactive_bg = s:purple_light

" Statusline:
let s:statusline_active_fg = s:window
let s:statusline_active_bg = s:magenta

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:background, s:foreground ], [ s:statusline_active_fg, s:purple ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.normal.right    = s:p.normal.left
let s:p.normal.middle   = [ [ s:foreground, s:foreground ]]
let s:p.normal.error    = [ [ s:background, s:error ] ]
let s:p.normal.warning  = [ [ s:background, s:green ] ]

let s:p.inactive.left   = [ [ s:foreground, s:inactive_light ], [ s:foreground, s:inactive_light] ]
let s:p.inactive.right  = s:p.inactive.left
let s:p.inactive.middle = [ [ s:inactive_dark,s:inactive_dark], ]

let s:p.insert.left     = [ [ s:background, s:blue ], [ s:statusline_active_fg, s:purple ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.insert.right    = s:p.insert.left

let s:p.replace.left    = [ [ s:background, s:pink ], [s:statusline_active_fg, s:purple ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.replace.right   = s:p.replace.left

let s:p.visual.left     = [ [ s:background, s:purple ], [s:statusline_active_fg, s:purple ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.visual.right    = s:p.visual.left

let s:p.tabline.left    = [ [s:tabline_inactive_fg, s:tabline_inactive_bg ]]
let s:p.tabline.tabsel  = [ [s:tabline_active_fg, s:tabline_active_bg ] ]
let s:p.tabline.middle  = [ [s:tabline_bg, s:tabline_bg]]
let s:p.tabline.right   = s:p.normal.right

let g:lightline#colorscheme#VimSpectre300light#palette = lightline#colorscheme#fill(s:p)
