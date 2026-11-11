provide-module config-email %{
  hook global BufSetOption filetype=mail %{
    add-highlighter -override global/column-limit column 72 default,black+d
  }
}
