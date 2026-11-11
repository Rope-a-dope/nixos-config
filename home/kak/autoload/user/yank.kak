provide-module config-yank %{
  # Clipboard mappings
  map global user p ':read-clipboard<ret>:execute-keys p<ret>' -docstring 'Paste from system clipboard'
  map global user y '<a-|>wl-copy<ret>' -docstring 'Yank selections to system clipboard'
  map global user P ':extra-yank-buffile<ret>' -docstring 'Yank current buffer path'
  map global user Y ':extra-yank-cursor<ret>' -docstring 'Yank file path and cursor position'

  # Read the Wayland clipboard
  define-command read-clipboard %{
    set-register dquote %sh{
      wl-paste --no-newline
    }
  }

  # Yank the current buffer path
  define-command extra-yank-buffile %{
    set-register p %val{buffile}
  }

  # Yank file path, line and column
  define-command extra-yank-cursor %{
    set-register '"' "%val{buffile} %val{cursor_line} %val{cursor_display_column}"
  }
}
