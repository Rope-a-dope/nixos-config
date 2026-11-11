provide-module config-editing %{
  # Editing defaults
  set-option global tabstop 2
  set-option global indentwidth 2
  set-option global scrolloff 2,2

  # Toggle line comments
  map global normal '#' ':comment-line<ret>' -docstring 'Toggle line comments'

  # Line numbers: absolute on cursor line, relative elsewhere
  hook global WinSetOption .* %{
    try %{
      remove-highlighter window/number-lines
    }
    add-highlighter window/number-lines number-lines -relative -hlcursor -separator " "
  }

  # Matching delimiters
  add-highlighter global/matching show-matching -previous

  # Selection contrast
  set-face global PrimarySelection rgb:d3c6aa,rgb:475258
  set-face global SecondarySelection rgb:d3c6aa,rgb:3d484d

  # Highlight the current line number
  set-face global LineNumberCursor rgb:a7c080,default+b

  # Normal mode: cool cyan cursor
  set-face global PrimaryCursor black,bright-cyan+F
  set-face global PrimaryCursorEol black,bright-cyan

  # Insert mode: warm yellow cursor
  hook global ModeChange (push|pop):.*:insert %{
    set-face window PrimaryCursor black,bright-yellow+F
    set-face window PrimaryCursorEol black,bright-yellow
  }

  # Restore normal-mode cursor faces when leaving insert mode
  hook global ModeChange (push|pop):insert:.* %{
    unset-face window PrimaryCursor
    unset-face window PrimaryCursorEol
  }

  # Show indentation whitespace without visible dots, tabs, or line-break markers
  add-highlighter global/whitespace show-whitespaces -spc " " -tab "" -lf "" -nbsp ""

  # Highlight trailing whitespace
  set-face global TrailingWhitespace rgb:e67e80,rgb:3d484d
  add-highlighter global/trailing-whitespace regex \h+$ 0:TrailingWhitespace

  # Status line
  set-face global StatusLine rgb:d3c6aa,rgb:343f44
  set-face global StatusLineMode rgb:2d353b,rgb:a7c080+b
  set-face global StatusLineInfo rgb:d3c6aa,rgb:3d484d
  set-face global StatusLineValue rgb:dbbc7f,rgb:343f44

  # Buffer text object (use B to avoid conflict with built-in f)
  map global object 'B' '<esc>: text-object-buffer<ret>' -docstring 'buffer'

  map global user c ':cursorcolumn<ret>' -docstring 'Toggle cursor column'
}
