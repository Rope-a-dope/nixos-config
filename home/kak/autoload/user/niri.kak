provide-module config-niri %{
  declare-user-mode window-niri

  map global window-niri Q ':q!<ret>'                        -docstring 'close window (force)'
  map global window-niri c ':niri-select-up-or-left<ret>'    -docstring 'move left or up'
  map global window-niri r ':niri-select-down-or-right<ret>' -docstring 'move right or down'
  map global window-niri v ':niri-split-right<ret>'          -docstring 'horizontal split'
  map global window-niri q ':q<ret>'                         -docstring 'close window'

  define-command niri-select-up-or-left %{
    nop %sh{
      niri msg action focus-window-up-or-column-left
    }
  }

  define-command niri-select-down-or-right %{
    nop %sh{
      niri msg action focus-window-down-or-column-right
    }
  }

  define-command niri-split-right %{
    nop %sh{
      niri msg action spawn -- $TERM kak -c $kak_session
    }
  }
}
