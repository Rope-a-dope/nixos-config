provide-module config-harpoon %{
  declare-user-mode harpoon

  # Enter Harpoon mode
  map global user H ':enter-user-mode harpoon<ret>' -docstring 'Harpoon'

  # Harpoon actions
  map global harpoon a ':harpoon-add<ret>' -docstring 'Add current file'

  map global harpoon l ':harpoon-show-list<ret>' -docstring 'Show Harpoon list'

  # Direct navigation
  map global normal <a-1> ':harpoon-nav 1<ret>'
  map global normal <a-2> ':harpoon-nav 2<ret>'
  map global normal <a-3> ':harpoon-nav 3<ret>'
  map global normal <a-4> ':harpoon-nav 4<ret>'
  map global normal <a-5> ':harpoon-nav 5<ret>'
  map global normal <a-6> ':harpoon-nav 6<ret>'
  map global normal <a-7> ':harpoon-nav 7<ret>'
  map global normal <a-8> ':harpoon-nav 8<ret>'
  map global normal <a-9> ':harpoon-nav 9<ret>'
}
