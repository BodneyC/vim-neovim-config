let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#command#latex_engine = "pdflatex"

" Turns out: Pandoc! pdf
"function pandoc#ConvPDF()
"	Pandoc pdf
"	!%:r.pdf
"endfunction
