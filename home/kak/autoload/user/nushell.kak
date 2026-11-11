provide-module config-nushell %{
  hook global WinCreate .*\.nu$ %{
    set-option buffer filetype nu
  }
}
