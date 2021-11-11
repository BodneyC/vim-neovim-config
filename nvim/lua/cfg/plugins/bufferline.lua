require('bufferline').setup {
  options = {
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',

    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = false,

    offsets = {
      {
        text_align = 'left',
      },
    },
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = false,
    persist_buffer_sort = true,

    separator_style = 'slant',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'id',
  },
}
