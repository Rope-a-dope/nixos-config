provide-module config-completion %{
  # Tab: navigate snippet placeholders, otherwise insert a normal Tab
  map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Next snippet placeholder or Tab'

  # Navigate insert completion menu
  hook global InsertCompletionShow .* %{
    map window insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <c-n> }<ret>'
    map window insert <s-tab> <c-p>
  }
  hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
  }
}
