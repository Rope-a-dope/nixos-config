provide-module config-hop %{
  evaluate-commands %sh{ @hop-kak@ --init }

  map global user h ':hop-kak<ret>' -docstring 'Hop to character'
  map global user w ':hop-kak-words<ret>' -docstring 'Hop to word'

  declare-option str hop_kak_keyset 'etisura,cnovpdwqxyghfbjz'

  define-command hop-kak %{
    eval -no-hooks -- %sh{
      @hop-kak@ --keyset "$kak_opt_hop_kak_keyset" --sels "$kak_selections_desc"
    }
  }

  define-command hop-kak-words %{
    evaluate-commands -draft %{
      execute-keys 'gtGbxs\w+<ret>'
      evaluate-commands -no-hooks -client "%val{client}" -- %sh{
        @hop-kak@ --keyset "$kak_opt_hop_kak_keyset" --sels "$kak_selections_desc"
      }
    }
  }
}
