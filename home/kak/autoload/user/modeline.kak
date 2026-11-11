provide-module config-modeline %{
  # Swiper modeline
  set-face global SwiperModeline blue+r

  # Base modeline
  set-option global modelinefmt \
    '%opt{lsp_modeline_progress} {{context_info}} {{mode_info}} {black}| {cyan}%val{cursor_line}{black}:{blue}%val{cursor_char_column} {black}%val{buf_line_count}L {green}%val{bufname}{black} %opt{modeline_swiper}'
}
