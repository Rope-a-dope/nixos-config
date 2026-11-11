provide-module config-repl %{
  declare-user-mode repl

  # REPL command prefix
  map global user r ':enter-user-mode repl<ret>' -docstring 'REPL commands'

  # Launch REPLs
  map global repl p ':repl-buffer-new python3 -i<ret>' -docstring 'Python REPL'

  map global repl e ':repl-buffer-new iex<ret>' -docstring 'Elixir IEx'

  # Send current selection to the most recently launched REPL
  map global repl s ':repl-buffer-send-text<ret>' -docstring 'Send selection to REPL'
}
