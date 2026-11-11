provide-module config-tree-sitter %{
  evaluate-commands %sh{
    kak-tree-sitter --daemonize --kakoune --init "${kak_session}" \
      --with-highlighting --with-text-objects
  }
}
