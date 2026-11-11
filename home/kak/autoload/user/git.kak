provide-module config-git %{
  declare-user-mode git

  # Enter Git mode
  map global user g ':enter-user-mode git<ret>' -docstring 'Git commands'

  # Git status
  map global git s ':git status -bs<ret>' -docstring 'Git status'

  # Git log
  map global git l ':git log --oneline --graph<ret>' -docstring 'Git log'

  # Git status buffer actions
  hook global WinSetOption filetype=git-status %{
    map window normal c ': git commit --verbose '
    map window normal l ': git log --oneline --graph -- <c-x>f'
    map window normal d ': -- %val{selections}<a-!><home> git diff '
    map window normal D ': -- %val{selections}<a-!><home> git diff --cached '
    map window normal a ': -- %val{selections}<a-!><home> git add '
    map window normal A ': -- %val{selections}<a-!><home> terminal git add -p '
    map window normal r ': -- %val{selections}<a-!><home> git reset '
    map window normal R ': -- %val{selections}<a-!><home> terminal git reset -p '
    map window normal o ': -- %val{selections}<a-!><home> git checkout '
  }

  # Git log buffer actions
  hook global WinSetOption filetype=git-log %{
    map window normal d ': %val{selections}<a-!><home> git diff '
    map window normal <ret> ': %val{selections}<a-!><home> git show '
    map window normal r ': %val{selections}<a-!><home> git reset '
    map window normal R ': %val{selections}<a-!><home> terminal git reset -p '
    map window normal o ': %val{selections}<a-!><home> git checkout '
  }
}
