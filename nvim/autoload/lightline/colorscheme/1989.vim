let s:blue         = '#afffff'
let s:pink         = '#ffafdf'
let s:green        = '#afffd7'
let s:magenta      = '#8f8f87'
let s:purple       = '#dfafff'
let s:purple_light = '#ffdfff'

let s:foreground     = '#000000'
let s:background     = s:magenta
let s:inactive_light = '#d8c3db'
let s:inactive_dark  = '#ded1e0'
let s:window         = '#efefef'
let s:error          = '#ffafdf'

let s:tabline_bg          = s:magenta
let s:tabline_active_fg   = s:foreground
let s:tabline_active_bg   = s:window
let s:tabline_inactive_fg = s:background
let s:tabline_inactive_bg = s:purple_light
let s:statusline_active_fg = s:window
let s:statusline_active_bg = s:magenta

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [
      \ [ s:foreground, s:green ],
      \ [ s:foreground, s:purple_light ],
      \ [ s:foreground, s:statusline_active_bg ]]
let s:p.normal.right    = s:p.normal.left
let s:p.normal.middle   = [[ s:background, s:background ]]
let s:p.normal.error    = [[ s:background, s:error ]]
let s:p.normal.warning  = [[ s:background, s:green ]]

let s:p.inactive.left   = [
      \ [ s:foreground, s:inactive_light ],
      \ [ s:foreground, s:inactive_light]]
let s:p.inactive.right  = s:p.inactive.left
let s:p.inactive.middle = [[ s:inactive_dark,s:inactive_dark]]

let s:p.insert.left     = [
      \ [ s:foreground, s:blue ],
      \ [ s:foreground, s:purple_light ],
      \ [ s:foreground, s:statusline_active_bg ]]
let s:p.insert.right    = s:p.insert.left

let s:p.replace.left    = [
      \ [ s:foreground, s:pink ],
      \ [s:foreground, s:purple_light ],
      \ [ s:foreground, s:statusline_active_bg ] ]
let s:p.replace.right   = s:p.replace.left

let s:p.visual.left     = [
      \ [ s:foreground, s:purple ],
      \ [s:foreground, s:purple_light ],
      \ [ s:foreground, s:statusline_active_bg ] ]
let s:p.visual.right    = s:p.visual.left

let s:p.tabline.left    = [[ s:tabline_inactive_fg, s:tabline_inactive_bg ]]
let s:p.tabline.tabsel  = [[ s:tabline_active_fg, s:tabline_active_bg ]]
let s:p.tabline.middle  = [[ s:tabline_bg, s:tabline_bg ]]
let s:p.tabline.right   = s:p.normal.right

let g:lightline#colorscheme#1989#palette = lightline#colorscheme#fill(s:p)
