provide-module config-expand %{
  require-module expand

  # Avoid conflict with the custom B buffer text object.
  set-option global expand_commands %{
    expand-impl %{ exec <a-a>b }
    expand-impl %{ exec <a-a>r }
    expand-impl %{ exec <a-i>i }
    expand-impl %{ exec '<a-:><a-;>k<a-K>^$<ret><a-i>i' }
    expand-impl %{ exec '<a-:>j<a-K>^$<ret><a-i>i' }
  }

  declare-user-mode expand

  # Space e — expand once
  map global user e ':expand<ret>' -docstring 'Expand selection'

  # Space E — enter repeatable expansion mode
  map global user E ':expand; enter-user-mode -lock expand<ret>' \
    -docstring 'Expand selection repeatedly'

  # Space in expand mode — expand again
  map global expand <space> ':expand<ret>' -docstring 'Expand selection'
}
