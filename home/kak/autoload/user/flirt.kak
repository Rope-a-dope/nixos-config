provide-module config-flirt %{
  # Change the current working directory through Flirt in a tmux popup
  define-command -docstring 'Change directory through Flirt' flirt-cd %{
    try %{
      cd %sh{ tmux popup -E flirt }
    }
  }
}
