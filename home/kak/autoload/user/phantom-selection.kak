provide-module config-phantom-selection %{
  require-module phantom-selection

  declare-user-mode phantom-selection

  # Enter Phantom Selection mode
  map global user P ':enter-user-mode phantom-selection<ret>' \
    -docstring 'Phantom selections'

  # Phantom Selection actions
  map global phantom-selection a ':phantom-selection-add-selection<ret>' \
    -docstring 'Save current selections'

  map global phantom-selection n ':phantom-selection-iterate-next<ret>' \
    -docstring 'Next phantom selection'

  map global phantom-selection p ':phantom-selection-iterate-prev<ret>' \
    -docstring 'Previous phantom selection'

  map global phantom-selection s ':phantom-selection-select-all<ret>' \
    -docstring 'Restore all selections'

  map global phantom-selection c ':phantom-selection-clear<ret>' \
    -docstring 'Clear phantom selections'

  # Everforest-compatible highlight
  set-face global PhantomSelection rgb:2d353b,rgb:a7c080+F
}
