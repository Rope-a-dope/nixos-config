provide-module config-lsp %{
  evaluate-commands %sh{kak-lsp}

  # LSP progress report
  declare-option -hidden str lsp_modeline_progress ""

  define-command -hidden -params 6 -override lsp-handle-progress %{
    set-option global lsp_modeline_progress %sh{
      if ! "$6"; then
        echo "$2${5:+" ($5%)"}${4:+": $4"}"
      fi
    }
  }

  lsp-enable
}
