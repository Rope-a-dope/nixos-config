provide-module config-search %{
  # Search match highlighting
  set-face global SearchMatch rgb:2d353b,rgb:dbbc7f+b
  add-highlighter global/search dynregex '%reg{/}' 0:SearchMatch

  # Clear search highlighting
  map global normal <a-backspace> ':set-register slash ""<ret>' \
  -docstring 'Clear search highlighting'

  # Search mode
  declare-user-mode search
  map global user s ':enter-user-mode search<ret>' -docstring 'search'
  map global search s ':swiper-resume<ret>' -docstring 'swiper-resume'
  map global search S ':swiper-search<ret>' -docstring 'search current buffer'
  map global search l ':live-grep<ret>' -docstring 'Live project grep'

  # Search the current buffer through Swiper
  declare-option -hidden str swiper_search_orig_buf

  define-command -docstring 'Search current buffer with Swiper' swiper-search %{
    evaluate-commands -save-regs '"ab' %{
      execute-keys '%"by'
      set-register a "%val{bufname}"

      edit -scratch "*%val{bufname}-swiper*"
      set-option buffer swiper_search_orig_buf "%reg{a}"
      execute-keys '%"bR'

      map buffer normal <ret> ':swiper-search-jump<ret>'
      add-highlighter buffer/swiper-search regex \
      '^(\d+)(:)([^\n]*)$' 1:cyan 2:black 3:green
    }

    swiper 'search buffer' 'rg -in' 'gg'
  }

  define-command -hidden swiper-search-jump %{
    execute-keys x
    edit "%opt{swiper_search_orig_buf}" %sh{
      line=${kak_selection%%:*}
      case "$line" in
      ''|*[!0-9]*) printf '1' ;;
      *) printf '%s' "$line" ;;
      esac
    }
  }

  # Swiper modeline
  declare-option str modeline_swiper ''

  hook global WinSetOption (swiper_terms=.+) %{
    set-option buffer modeline_swiper "swiper (%opt{swiper_terms}) "
  }

  hook global WinSetOption swiper_enabled=false %{
    set-option buffer modeline_swiper ''
  }
}
