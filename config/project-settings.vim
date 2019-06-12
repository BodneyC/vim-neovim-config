" function! ApplyLocalSettings(dirname)
"   let l:netrwProtocol = strpart(a:dirname, 0, stridx(a:dirname, "://"))
"   if l:netrwProtocol != ""
"     return
"   endif
"   let l:settingsFile = a:dirname . "/.project.vim"
"   if filereadable(l:settingsFile)
"     cd `=a:dirname`
"     exec ":source " . l:settingsFile
"     return
"   endif
"   let l:parentDir = strpart(a:dirname, 0, strridx(a:dirname, "/"))
"   if isdirectory(l:parentDir)
"     call ApplyLocalSettings(l:parentDir)
"   endif
" endfunction
" augroup project-settings
"   autocmd!
"   autocmd! BufEnter * call ApplyLocalSettings(expand("%:p:h"))
" augroup END
