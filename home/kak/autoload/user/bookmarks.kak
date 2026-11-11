provide-module config-bookmarks %{
  declare-user-mode bookmarks

  map global user _ ':enter-user-mode bookmarks<ret>' -docstring 'Selection marks'

  map global bookmarks s 'Z' -docstring 'Save selection mark'
  map global bookmarks r 'z' -docstring 'Restore selection mark'
}
