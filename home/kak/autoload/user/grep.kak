provide-module config-grep %{
  map global user / ':grep ' -docstring 'Grep'

  # Better :grep!
  set-option global grepcmd 'rg --column --smart-case --sort path'

  map global goto p ':grep-previous-match<ret>' -docstring 'Grep previous match'
  map global goto n ':grep-next-match<ret>' -docstring 'Grep next match'
}
