provide-module config-pickers %{
  # Find file with fzf
  map global user f ':popup --title Find-file --kak-script %{edit %opt{popup_output}} -- fish -c "command find . -type f | fzf"<ret>' \
  -docstring 'Find file with fzf'

  # Buffer management
  declare-user-mode user-buffer

  map global user b ':enter-user-mode user-buffer<ret>' -docstring 'Buffer management'
  map global user-buffer i ':info-buffers<ret>' -docstring 'Show buffer list'
  map global user-buffer h ':buffer-first<ret>' -docstring 'First buffer'
  map global user-buffer l ':buffer-last<ret>' -docstring 'Last buffer'
  map global user-buffer o ':buffer-only<ret>' -docstring 'Keep only current buffer'

  # Fuzzy buffer picker
  define-command buffer-picker %{
    peneira 'buffers: ' %{
      printf '%s\n' $kak_quoted_buflist
    } %{
      buffer %arg{1}
    }
  }

  map global user-buffer b ':buffer-picker<ret>' -docstring 'Fuzzy buffer picker'
  map global user-buffer ')' ':buffer-next<ret>' -docstring 'Next buffer'
  map global user-buffer d ':delete-buffer<ret>' -docstring 'Delete buffer'
  map global user-buffer D ':delete-buffer!<ret>' -docstring 'Force-delete buffer'
  map global user-buffer r ':rename-buffer ' -docstring 'Rename buffer'

  # Peneira file and navigation pickers
  map global user F ':peneira-files<ret>' -docstring 'Find file with Peneira'
  map global user l ':peneira-lines<ret>' -docstring 'Find line in current buffer'
  map global user S ':peneira-symbols<ret>' -docstring 'Find symbol in current buffer'
}
