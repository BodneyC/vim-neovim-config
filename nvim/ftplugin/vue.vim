set ts=2 sts=2 sw=2
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin") || exists("loaded_xmledit")
  finish
endif
" sboles, init these variables so vim doesn't complain on wrap cancel
let b:last_wrap_tag_used = ""
let b:last_wrap_atts_used = ""

" Strlen -> A strlen func with multi-byte support                {{{1
" Luc Hermitte: Suggested this trickery.
if !exists("*s:Strlen")
func s:Strlen(text)
  return strlen(substitute(a:text, '.', 'a', 'g'))
endfunc
endif

" WrapTag -> Places an XML tag around a visual selection.            {{{1
" Brad Phelan: Wrap the argument in an XML tag
" Added nice GUI support to the dialogs.
" Rewrote func to implement new algorythem that addresses several bugs.
if !exists("*s:WrapTag")
func s:WrapTag(text)
    if (line(".") < line("'<"))
        let insert_cmd = "o"
    elseif (col(".") < col("'<"))
        let insert_cmd = "a"
    else
        let insert_cmd = "i"
    endif
    if <SID>Strlen(a:text) > 10
        let input_text = strpart(a:text, 0, 10) . '...'
    else
        let input_text = a:text
    endif
    if exists("b:last_wrap_tag_used")
        let default_tag = b:last_wrap_tag_used
    else
        let default_tag = ""
    endif
    let wraptag = inputdialog('Tag to wrap "' . input_text . '" : ', default_tag)
    if <SID>Strlen(wraptag)==0
        undo
        return
    else
        if wraptag == default_tag && exists("b:last_wrap_atts_used")
            let default_atts = b:last_wrap_atts_used
        else
            let default_atts = ""
        endif
        let atts = inputdialog('Attributes in <' . wraptag . '> : ', default_atts)
    endif
    if (visualmode() ==# 'V')
        let text = strpart(a:text,0,<SID>Strlen(a:text)-1)
        if (insert_cmd ==# "o")
            let eol_cmd = ""
        else
            let eol_cmd = "\<Cr>"
        endif
    else
        let text = a:text
        let eol_cmd = ""
    endif
    if <SID>Strlen(atts)==0
        let text = "<".wraptag.">".text."</".wraptag.">"
        let b:last_wrap_tag_used = wraptag
        let b:last_wrap_atts_used = ""
    else
        let text = "<".wraptag." ".atts.">".text."</".wraptag.">"
        let b:last_wrap_tag_used = wraptag
        let b:last_wrap_atts_used = atts
    endif
    execute "normal! ".insert_cmd.text.eol_cmd
endfunc
endif

" NewFileXML -> Inserts <?xml?> at top of new file.                  {{{1
if !exists("*s:NewFileXML")
func s:NewFileXML( )
    " Where is g:did_xhtmlcf_inits defined?
    if &filetype == 'docbk' || &filetype == 'xml' || (!exists ("g:did_xhtmlcf_inits") && exists ("g:xml_use_xhtml") && (&filetype == 'html' || &filetype == 'xhtml'))
        if append (0, '<?xml version="1.0"?>')
            normal! G
        endif
    endif
endfunc
endif


" IncreaseCommentLevel -> Wrap selection in comments, fix nested comments. {{{1
if !exists("*s:IncreaseCommentLevel")
func s:IncreaseCommentLevel( )
    " Visual block mode is not supported yet.
    if (visualmode() !=# 'v' && visualmode() !=# 'V')
        return
    endif
    let iscursoratend = (line(".") ==# line("'>"))
    let indent = matchstr(getline("'<"), '\%^\s*')
    setlocal report=99999
    let oldvreg = getreg('v')
    let oldvregtype = getregtype('v')
    normal! gv"vy
    let commblock = getreg('v')
    " Increase depth level of existing nested comment blocks.
    let commblock = substitute(commblock, '<!{\([0-9]\+\)}\*\*', '\="<!{".(submatch(1) + 1)."}**"', 'g')
    let commblock = substitute(commblock, '\*\*{\([0-9]\+\)}>', '\="**{".(submatch(1) + 1)."}>"', 'g')
    " Replace existing comment tags with a level placeholder.
    let commblock = substitute(commblock, '<!--', '<!{1}**', 'g')
    let commblock = substitute(commblock, '-->', '**{1}>', 'g')
    if (visualmode() ==# 'V')
        let commblock = indent . "<!--\n" . commblock . indent . "-->\n"
    else
        let commblock = '<!--' . commblock . '-->'
    endif
    call setreg('v', commblock, visualmode())
    normal! gv"vpgv
    " Fix selection direction and cursor position.
    if ((iscursoratend && line(".") ==# line("'<")) || ( ! iscursoratend && line(".") ==# line("'>")))
        normal! o
    endif
    call setreg("v", oldvreg, oldvregtype)
    set report&
endfunc
endif


" DecreaseCommentLevel -> Removes comment tags from selection, fix nested comments. {{{1
if !exists("*s:DecreaseCommentLevel")
func s:DecreaseCommentLevel( )
    " Visual block mode is not supported yet.
    if (visualmode() !=# 'v' && visualmode() !=# 'V')
        return
    endif
    " If end or begin comment is on a newline, switch to Visual line mode
    if (visualmode() ==# 'v'
                \ && (getline("'<") =~# '^\s*<!--\s*$' || getline("'>") =~# '^\s*-->\s*$'))
        execute "normal!" "\<ESC>gvV\<ESC>"
        "return
    endif
    let iscursoratend = (getpos(".") ==# getpos("'>"))
    setlocal report=99999
    let oldvreg = getreg('v')
    let oldvregtype = getregtype('v')
    normal! gv"vy
    let commblock = getreg('v')
    " Remove comment tags, make sure to remove would-be-empty lines as well.
    let commblock = substitute(commblock, '\(^\|\n\)\zs\s*<!--\n\|\n\zs\s*-->\n\|<!--\|-->', '', 'g')
    " Decrease depth level of existing nested comment blocks.
    let commblock = substitute(commblock, '<!{\([0-9]\+\)}\*\*', '\="<!{".(submatch(1) - 1)."}**"', 'g')
    let commblock = substitute(commblock, '\*\*{\([0-9]\+\)}>', '\="**{".(submatch(1) - 1)."}>"', 'g')
    " Restore comment tags which have dropped to level 0.
    let commblock = substitute(commblock, '<!{0}\*\*', '<!--', 'g')
    let commblock = substitute(commblock, '\*\*{0}>', '-->', 'g')
    call setreg('v', commblock, visualmode())
    normal! gv"vpgv
    " Fix selection direction and cursor position.
    if ((iscursoratend && line(".") ==# line("'<")) || ( ! iscursoratend && line(".") ==# line("'>")))
        normal! o
    endif
    call setreg("v", oldvreg, oldvregtype)
    set report&
endfunc
endif



" Callback -> Checks for tag callbacks and executes them.            {{{1
if !exists("*s:Callback")
func s:Callback( xml_tag, isHtml )
    let text = 0
    if a:isHtml == 1 && exists ("*HtmlAttribCallback")
        let text = HtmlAttribCallback (a:xml_tag)
    elseif exists ("*XmlAttribCallback")
        let text = XmlAttribCallback (a:xml_tag)
    endif
    if text != '0'
        execute "normal! i " . text ."\<Esc>l"
    endif
endfunc
endif


" IsParsableTag -> Check to see if the tag is a real tag.            {{{1
if !exists("*s:IsParsableTag")
func s:IsParsableTag( tag )
    " The "Should I parse?" flag.
    let parse = 1

    " make sure a:tag has a proper tag in it and is not a instruction or end tag.
    if a:tag !~ '^<[[:alnum:]_:\-].*>$'
        let parse = 0
    endif

    " make sure this tag isn't already closed.
    if strpart (a:tag, <SID>Strlen (a:tag) - 2, 1) == '/'
        let parse = 0
    endif

    return parse
endfunc
endif


" ParseTag -> The major work hourse for tag completion.              {{{1
if !exists("*s:ParseTag")
func s:ParseTag( )
    " Save registers
    let old_reg_save = @"
    let old_save_x   = @x

    if (!exists("g:xml_no_auto_nesting") && strpart (getline ("."), col (".") - 2, 2) == '>>')
        let multi_line = 1
        execute "normal! \"xX"
    else
        let multi_line = 0
    endif
    let do_append_for_xhtml = 0

    let @" = ""
    execute "normal! \"xy%%"
    let ltag = @"
    if (&filetype == 'html' || &filetype == 'xhtml') && (!exists ("g:xml_no_html"))
        let html_mode = 1
        let ltag = substitute (ltag, '[^[:graph:]]\+', ' ', 'g')
        let ltag = substitute (ltag, '<\s*\([^[:alnum:]_:\-[:blank:]]\=\)\s*\([[:alnum:]_:\-]\+\)\>', '<\1\2', '')
    else
        let html_mode = 0
    endif

    if <SID>IsParsableTag (ltag)
        " find the break between tag name and atributes (or closing of tag)
        let index = matchend (ltag, '[[:alnum:]_:\.\-]\+')

        let tag_name = strpart (ltag, 1, index - 1)
        if strpart (ltag, index) =~ '[^/>[:blank:]]'
            let has_attrib = 1
        else
            let has_attrib = 0
        endif

        " That's (index - 1) + 2, 2 for the '</' and 1 for the extra character the
        " while includes (the '>' is ignored because <Esc> puts the curser on top
        " of the '>'
        let index = index + 2

        " print out the end tag and place the cursor back were it left off
        if html_mode && tag_name =~? '^\(img\|input\|param\|frame\|br\|hr\|meta\|link\|base\|area\)$'
            if has_attrib == 0
                call <SID>Callback (tag_name, html_mode)
            endif
            if exists ("g:xml_use_xhtml")
                execute "normal! i /\<Esc>l"
                if col(".") == col("$") - 1
                  let do_append_for_xhtml = 1
                endif
            endif
        else
            if multi_line
                " Can't use \<Tab> because that indents 'tabstop' not 'shiftwidth'
                " Also >> doesn't shift on an empty line hence the temporary char 'x'
                let com_save = &comments
                set comments-=n:>
                execute "normal! a\<Cr>\<Cr>\<Esc>kAx\<Esc>>>$\"xx"
                echom com_save
                echom substitute(com_save, " ", "\\\\ ", "g")
                execute "set comments=\"" . substitute(com_save, " ", "\\\\ ", "g") . "\""
            else
                if has_attrib == 0
                    call <SID>Callback (tag_name, html_mode)
                endif
                if exists("g:xml_jump_string")
                    let index = index + <SID>Strlen(g:xml_jump_string)
                    let jump_char = g:xml_jump_string
                    call <SID>InitEditFromJump()
                else
                    let jump_char = ""
                endif
                execute "normal! a</" . tag_name . ">" . jump_char . "\<Esc>" . index . "h"
            endif
        endif
    endif

    " restore registers
    let @" = old_reg_save
    let @x = old_save_x

    if multi_line || do_append_for_xhtml
        startinsert!
    else
        if col(".") == col("$") - 1
            startinsert!
        else
            execute "normal! l"
            startinsert
        endif
    endif
endfunc
endif


" ParseTag2 -> Experimental func to replace ParseTag             {{{1
"if !exists("*s:ParseTag2")
"func s:ParseTag2( )
    " My thought is to pull the tag out and reformat it to a normalized tag
    " and put it back.
"endfunc
"endif


" BuildTagName -> Grabs the tag's name for tag matching.             {{{1
if !exists("*s:BuildTagName")
func s:BuildTagName( )
  "First check to see if we Are allready on the end of the tag. The / search
  "forwards command will jump to the next tag otherwise

  " Store contents of register x in a variable
  let b:xreg = @x

  exe "normal! v\"xy"
  if @x=='>'
     " Don't do anything
  else
     exe "normal! />/\<Cr>"
  endif

  " Now we head back to the < to reach the beginning.
  exe "normal! ?<?\<Cr>"

  " Capture the tag (a > will be catured by the /$/ match)
  exe "normal! v/\\s\\|$/\<Cr>\"xy"

  " We need to strip off any junk at the end.
  let @x=strpart(@x, 0, match(@x, "[[:blank:]>\<C-J>]"))

  "remove <, >
  let @x=substitute(@x,'^<\|>$','','')

  " remove spaces.
  let @x=substitute(@x,'/\s*','/', '')
  let @x=substitute(@x,'^\s*','', '')

  " Swap @x and b:xreg
  let temp = @x
  let @x = b:xreg
  let b:xreg = temp
endfunc
endif

" TagMatch1 -> First step in tag matching.                           {{{1
" Brad Phelan: First step in tag matching.
if !exists("*s:TagMatch1")
func s:TagMatch1()
  " Save registers
  let old_reg_save = @"

  "Drop a marker here just in case we have a mismatched tag and
  "wish to return (:mark looses column position)
  normal! mz

  call <SID>BuildTagName()

  "Check to see if it is an end tag. If it is place a 1 in endtag
  if match(b:xreg, '^/')==-1
    let endtag = 0
  else
    let endtag = 1
  endif

 " Extract the tag from the whole tag block
 " eg if the block =
 "   tag attrib1=blah attrib2=blah
 " we will end up with
 "   tag
 " with no trailing or leading spaces
 let b:xreg=substitute(b:xreg,'^/','','g')

 " Make sure the tag is valid.
 " Malformed tags could be <?xml ?>, <![CDATA[]]>, etc.
 if match(b:xreg,'^[[:alnum:]_:\-]') != -1
     " Pass the tag to the matching
     " routine
     call <SID>TagMatch2(b:xreg, endtag)
 endif
 " Restore registers
 let @" = old_reg_save
endfunc
endif


" TagMatch2 -> Second step in tag matching.                          {{{1
" Brad Phelan: Second step in tag matching.
if !exists("*s:TagMatch2")
func s:TagMatch2(tag,endtag)
  let match_type=''

  " Build the pattern for searching for XML tags based
  " on the 'tag' type passed into the func.
  " Note we search forwards for end tags and
  " backwards for start tags
  if a:endtag==0
     "let nextMatch='normal /\(<\s*' . a:tag . '\(\s\+.\{-}\)*>\)\|\(<\/' . a:tag . '\s*>\)'
     let match_type = '/'
  else
     "let nextMatch='normal ?\(<\s*' . a:tag . '\(\s\+.\{-}\)*>\)\|\(<\/' . a:tag . '\s*>\)'
     let match_type = '?'
  endif

  if a:endtag==0
     let stk = 1
  else
     let stk = 1
  end

 " wrapscan must be turned on. We'll recored the value and reset it afterward.
 " We have it on because if we don't we'll get a nasty error if the search hits
 " BOF or EOF.
 let wrapval = &wrapscan
 let &wrapscan = 1

  "Get the current location of the cursor so we can
  "detect if we wrap on ourselves
  let lpos = line(".")
  let cpos = col(".")

  if a:endtag==0
      " If we are trying to find a start tag
      " then decrement when we find a start tag
      let iter = 1
  else
      " If we are trying to find an end tag
      " then increment when we find a start tag
      let iter = -1
  endif

  "Loop until stk == 0.
  while 1
     " exe search.
     " Make sure to avoid />$/ as well as /\s$/ and /$/.
     exe "normal! " . match_type . '<\s*\/*\s*' . a:tag . '\([[:blank:]>]\|$\)' . "\<Cr>"

     " Check to see if our match makes sence.
     if a:endtag == 0
         if line(".") < lpos
             call <SID>MisMatchedTag (0, a:tag)
             break
         elseif line(".") == lpos && col(".") <= cpos
             call <SID>MisMatchedTag (1, a:tag)
             break
         endif
     else
         if line(".") > lpos
             call <SID>MisMatchedTag (2, '/'.a:tag)
             break
         elseif line(".") == lpos && col(".") >= cpos
             call <SID>MisMatchedTag (3, '/'.a:tag)
             break
         endif
     endif

     call <SID>BuildTagName()

     if match(b:xreg,'^/')==-1
        " Found start tag
        let stk = stk + iter
     else
        " Found end tag
        let stk = stk - iter
     endif

     if stk == 0
        break
     endif
  endwhile

  let &wrapscan = wrapval
endfunc
endif

" MisMatchedTag -> What to do if a tag is mismatched.                {{{1
if !exists("*s:MisMatchedTag")
func s:MisMatchedTag( id, tag )
    "Jump back to our formor spot
    normal! `z
    normal zz
    echohl WarningMsg
    " For debugging
    "echo "Mismatched tag " . a:id . ": <" . a:tag . ">"
    " For release
    echo "Mismatched tag <" . a:tag . ">"
    echohl None
endfunc
endif

" DeleteTag -> Deletes surrounding tags from cursor.                 {{{1
" Modifies mark z
if !exists("*s:DeleteTag")
func s:DeleteTag( )
    if strpart (getline ("."), col (".") - 1, 1) == "<"
        normal! l
    endif
    if search ("<[^\/]", "bW") == 0
        return
    endif
    normal! mz
    call s:TagMatch1()
    normal! d%`zd%
endfunc
endif

" VisualTag -> Selects Tag body in a visual selection.                {{{1
" Modifies mark z
if !exists("*s:VisualTag")
func s:VisualTag( )
    if strpart (getline ("."), col (".") - 1, 1) == "<"
        normal! l
    endif
    if search ("<[^\/]", "bW") == 0
        return
    endif
    normal! mz
    call s:TagMatch1()
    normal! %
    exe "normal! " . visualmode()
    normal! `z
endfunc
endif

" InsertGt -> close tags only if the cursor is in a HTML or XML context {{{1
" Else continue editing
if !exists("*s:InsertGt")
func s:InsertGt( )
  let save_matchpairs = &matchpairs
  set matchpairs-=<:>
  
  " Check if a closing '>' already exists
  " This is useful while using a plugin like delimitMate
  " or a inoremap which autocompletes the closing >
  " otherwise, an excess '>' is added
  if (getline('.')[col('.')] == '<')
    " Nest the tags
    execute "normal! li>"
  elseif (getline('.')[col('.')] == '>')
    " closing > exists
    execute "normal! la"
  else
    " insert closing >
    execute "normal! a>"
  endif

  execute "set matchpairs=" . save_matchpairs
  " When the current char is text within a tag it will not proccess as a
  " syntax'ed element and return nothing below. Since the multi line wrap
  " feture relies on using the '>' char as text within a tag we must use the
  " char prior to establish if it is valid html/xml
  "
  if (getline('.')[col('.') - 1] == '>')
    let char_syn=synIDattr(synID(line("."), col(".") - 1, 1), "name")
  endif
  if !exists("g:xml_tag_syntax_prefixes")
    let tag_syn_patt = 'html\|xml\|docbk'
  else
    let tag_syn_patt = g:xml_tag_syntax_prefixes
  endif
  if -1 == match(char_syn, "xmlProcessing") && 0 == match(char_syn, tag_syn_patt)
    call <SID>ParseTag()
  else
    if col(".") == col("$") - 1
      startinsert!
    else
      execute "normal! l"
      startinsert
    endif
  endif
endfunc
endif

" InitEditFromJump -> Set some needed autocommands and syntax highlights for EditFromJump. {{{1
if !exists("*s:InitEditFromJump")
func s:InitEditFromJump( )
    " Add a syntax highlight for the xml_jump_string.
    execute "syntax match Error /\\V" . g:xml_jump_string . "/"
endfunc
endif

" ClearJumpMarks -> Clean out extranious left over xml_jump_string garbage. {{{1
if !exists("*s:ClearJumpMarks")
func s:ClearJumpMarks( )
    if exists("g:xml_jump_string")
       if g:xml_jump_string != ""
           execute ":%s/" . g:xml_jump_string . "//ge"
       endif
    endif
endfunc
endif

" EditFromJump -> Jump to the end of the tag and continue editing. {{{1
" g:xml_jump_string must be set.
if !exists("*s:EditFromJump")
func s:EditFromJump( )
    if exists("g:xml_jump_string")
        if g:xml_jump_string != ""
            let foo = search(g:xml_jump_string, 'csW') " Moves cursor by default
            execute "normal! " . <SID>Strlen(g:xml_jump_string) . "x"
            if col(".") == col("$") - 1
                startinsert!
            else
                startinsert
            endif
        endif
    else
        echohl WarningMsg
        echo "Function disabled. xml_jump_string not defined."
        echohl None
    endif
endfunc
endif

" Gets the current HTML tag by the cursor.
if !exists("*s:GetCurrentTag")
	func s:GetCurrentTag()
		return matchstr(matchstr(getline('.'),
		\ '<\zs\(\w\|=\| \|''\|"\)*>\%'.col('.').'c'), '^\a*')
	endfunc
endif

" Cleanly return after autocompleting an html/xml tag.
if !exists("*s:MoveCursor")
	func s:MoveCursor()
		let tag = s:GetCurrentTag()
		return (tag != '') && (match(getline('.'), '</'.tag.'>') > -1) ? "\<cr>\<cr>\<up>" : "\<cr>"
	endfunc
endif

" Mappings and Settings.                                             {{{1
" This makes the '%' jump between the start and end of a single tag.
setlocal matchpairs+=<:>
setlocal commentstring=<!--%s-->

" Have this as an escape incase you want a literal '>' not to run the
" ParseTag func.
if !exists("g:xml_tag_completion_map")
    inoremap <buffer> <LocalLeader>. >
    inoremap <buffer> <LocalLeader>> >
else
    execute "inoremap <buffer> <LocalLeader>. " . g:xml_tag_completion_map
    execute "inoremap <buffer> <LocalLeader>> " . g:xml_tag_completion_map
endif

" Jump between the beggining and end tags.
nnoremap <buffer> <LocalLeader>5 :call <SID>TagMatch1()<Cr>
nnoremap <buffer> <LocalLeader>% :call <SID>TagMatch1()<Cr>
vnoremap <buffer> <LocalLeader>5 <Esc>:call <SID>VisualTag()<Cr>
vnoremap <buffer> <LocalLeader>% <Esc>:call <SID>VisualTag()<Cr>

" Wrap selection in XML tag
vnoremap <buffer> <LocalLeader>x "xx:call <SID>WrapTag(@x)<Cr>
nnoremap <buffer> <LocalLeader>d :call <SID>DeleteTag()<Cr>

" Comment selection
vnoremap <buffer> <Plug>(XMLEditWrapComment) <Esc>:call <SID>IncreaseCommentLevel()<CR>
vnoremap <buffer> <Plug>(XMLEditUnwrapComment) <Esc>:call <SID>DecreaseCommentLevel()<CR>
" The LocalLeader mappings might conflict. Don't map if a binding exists.
if !exists("g:xml_no_comment_map") && empty(maparg("<LocalLeader>c", "v"))
    vmap <buffer> <LocalLeader>c <Plug>(XMLEditWrapComment)
endif
if !exists("g:xml_no_comment_map") && empty(maparg("<LocalLeader>u", "v"))
    vmap <buffer> <LocalLeader>u <Plug>(XMLEditUnwrapComment)
endif

" Parse the tag after pressing the close '>'.
if !exists("g:xml_tag_completion_map")
    " inoremap <buffer> > ><Esc>:call <SID>ParseTag()<Cr>
    inoremap <buffer> > <Esc>:call <SID>InsertGt()<Cr>
    " After the closing tag has been added and we press enter, this inserts 2
    " linebreaks and moves our cursor up 1 line.
    execute "inoremap <buffer> <expr> <cr> \"" . <SID>MoveCursor() . "\""
else
    execute "inoremap <buffer> " . g:xml_tag_completion_map . " <Esc>:call <SID>InsertGt()<Cr>"
endif

nnoremap <buffer> <LocalLeader><LocalLeader> :call <SID>EditFromJump()<Cr>
inoremap <buffer> <LocalLeader><LocalLeader> <Esc>:call <SID>EditFromJump()<Cr>
" Clear out all left over xml_jump_string garbage
nnoremap <buffer> <LocalLeader>w :call <SID>ClearJumpMarks()<Cr>
" The syntax files clear out any predefined syntax definitions. Recreate
" this when ever a xml_jump_string is created. (in ParseTag)

augroup __XML__
    au!
    au BufNewFile * call <SID>NewFileXML()
    " Remove left over garbage from xml_jump_string on file save.
    au BufWritePre <buffer> call <SID>ClearJumpMarks()
augroup end
"}}}1
finish
