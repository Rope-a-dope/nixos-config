provide-module config-surround %{
  # Surround operations
  declare-user-mode surround

  map global user m ':enter-user-mode surround<ret>' \
    -docstring 'Surround operations'

  map global surround s ':surround<ret>' \
    -docstring 'Surround selection'

  map global surround c ':change-surround<ret>' \
    -docstring 'Change surrounding pair'

  map global surround d ':delete-surround<ret>' \
    -docstring 'Delete surrounding pair'

  map global surround t ':select-surrounding-tag<ret>' \
    -docstring 'Select surrounding tag'
}
