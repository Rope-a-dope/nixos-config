provide-module config-directory %{
  # Directory navigation
  declare-user-mode user-open

  map global user o ':enter-user-mode user-open<ret>' -docstring 'Open directory navigation'

  # Change to a directory (prompts for a path)
  map global user-open d ':cd ' -docstring 'Change directory'

  # Change to the current buffer's directory
  map global user-open . ':cd %sh{dirname "$kak_buffile"}<ret>' \
    -docstring 'Change to buffer directory'
}
