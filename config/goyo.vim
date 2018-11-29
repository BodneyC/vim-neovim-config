"function! s:goyo_enter()
"  set noshowmode
"  set noshowcmd
"  set scrolloff=999
"  Limelight
"  " ...
"endfunction
"
"function! s:goyo_leave()
"  set showmode
"  set showcmd
"  set scrolloff=5
"  Limelight!
"  " ...
"endfunction
"
"autocmd! User GoyoEnter nested call <SID>goyo_enter()
"autocmd! User GoyoLeave nested call <SID>goyo_leave()
"

function goyo#Goyo_e() 
	Goyo
	Goyo!
	Goyo 65%x75%
	hi CursorLine guibg=#434343
	hi CursorColumn guibg=#434343
endfunction

function goyo#Goyo_l()
	Goyo!
	hi CursorLine guibg=#434343
	hi CursorColumn guibg=#434343
endfunction
