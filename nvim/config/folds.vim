set foldmarker=-s-,-e-
set foldmethod=marker

let s:CommentMark = { -> split(&commentstring, '%s')[0] }
