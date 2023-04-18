local M = {}

M.disabled_sexp_mappings = {
  sexp_flow_to_prev_close = '', -- '<M-[>'
  sexp_flow_to_next_open = '<C-]>', -- '<M-]>'
  sexp_flow_to_prev_open = '', -- '<M-{>'
  sexp_flow_to_next_close = '', -- '<M-}>'
  sexp_flow_to_prev_leaf_head = '', -- '<M-S-b>',
  sexp_flow_to_next_leaf_head = '', -- '<M-S-w>',
  sexp_flow_to_prev_leaf_tail = '', -- '<M-S-g>',
  sexp_flow_to_next_leaf_tail = '', -- '<M-S-e>',
  sexp_move_to_prev_top_element = '',
  sexp_move_to_next_top_element = '',
  sexp_select_prev_element = '',
  sexp_select_next_element = '',
  sexp_indent = '',
  sexp_indent_top = '',
  sexp_round_head_wrap_list = '',
  sexp_round_tail_wrap_list = '',
  sexp_square_head_wrap_list = '',
  sexp_square_tail_wrap_list = '',
  sexp_curly_head_wrap_list = '',
  sexp_curly_tail_wrap_list = '',
  sexp_round_head_wrap_element = '',
  sexp_round_tail_wrap_element = '',
  sexp_square_head_wrap_element = '',
  sexp_square_tail_wrap_element = '',
  sexp_curly_head_wrap_element = '',
  sexp_curly_tail_wrap_element = '',
  sexp_insert_at_list_head = '',
  sexp_insert_at_list_tail = '',
  sexp_splice_list = '',
  sexp_convolute = '',
  sexp_raise_list = '',
  sexp_raise_element = '',
  sexp_swap_list_backward = '',
  sexp_swap_list_forward = '',
  sexp_swap_element_backward = '',
  sexp_swap_element_forward = '',
  sexp_emit_head_element = '',
  sexp_emit_tail_element = '',
  sexp_capture_prev_element = '',
  sexp_capture_next_element = '',
}

return M
