setlocal commentstring=//%s
au! FileType json syntax match Comment +\/\/.\+$+
command! -nargs=0 SortJSON :%!grep -v '^[\t ]*//' | jq --indent 2 -S '.'
