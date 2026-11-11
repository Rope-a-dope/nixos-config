# swiper utility to dynamically filter the content of a buffer.
#
# You typically want to use the swiper command by passing two arguments:
#   - The filter command, e.g. 'rg -i'.
#   - An optional pre-fill state command, which can be used to cache the content of its output when running
#     swiper for the first time on a buffer. For instance, 'evaluate-commands "%|fd -t file"'.
#
# Then, swiper will prompt you for terms that will be passed to the command you set and the content of the
# buffer will be dynamically filter with it. You can invoke swiper on the buffer again to edit the terms again
# or simply call swiper-disable to completely remove it and restore the original buffer content.

declare-option -docstring 'track when swiper is active on a given buffer' bool swiper_enabled false
declare-option -docstring 'dynamic terms used to filter swiper buffers' str swiper_terms
declare-option -hidden -docstring 'content of the buffer swiper works on; used for reverting' str swiper_content
declare-option -hidden -docstring 'args passed to swiper for a buffer to be used when resuming' str swiper_resume_args

# --- public commands

define-command -docstring 'swiper <prompt> <cmd> [finish-cmd]: dynamically filter the current buffer with <cmd>' -params 2..3 swiper %{
  evaluate-commands "swiper-setup-%opt{swiper_enabled} '%arg{1}' '%arg{2}' '%arg{3}'"
  swiper-prompt "%arg{1}" "%arg{2}" "%arg{3}"
}

define-command -docstring 'swiper-resume: resume a prompt on a swiper buffer' swiper-resume %{
  try %{
    evaluate-commands "swiper %opt{swiper_resume_args}"
  } catch %{
    info -title 'swiper-resume' 'error: not a swiper buffer; invoke swiper first'
  }
}

define-command -docstring 'swiper-disable: completely remove swiper' swiper-disable %{
  swiper-reset
  unset-option buffer swiper_terms
  unset-option buffer swiper_enabled
}

# --- private commands

define-command -params 2..3 swiper-setup-true nop
define-command -params 2..3 swiper-setup-false %{
  evaluate-commands "swiper-setup '%arg{1}' '%arg{2}' '%arg{3}'"
}

define-command -hidden -docstring 'swiper-setup <cmd> [prefill]: initialize swiper for the current buffer' -params 2..3 swiper-setup %{
  set-option buffer swiper_enabled true
  set-option buffer swiper_resume_args "'%arg{1}' '%arg{2}' '%arg{3}'"

  # set swiper_content to the content of the full buffer
  evaluate-commands -draft %{
    execute-keys '%"ay'
    set-option buffer swiper_content "%reg{a}"
  }
}


define-command -hidden -docstring 'swiper-prompt <prompt> <cmd> [finish-cmd]: open the swiper dynamic prompt by calling <cmd> on its content' -params 2..3 swiper-prompt %{
  prompt -init "%opt{swiper_terms}" -on-change "swiper-update-content ""%arg{2}""" -on-abort swiper-disable "%arg{1}:" %{
    execute-keys "%arg{3}"
  }
}

define-command -hidden -docstring 'swiper-update-content <cmd>: update the current buffer with the swiper terms and <cmd>' -params 1 swiper-update-content %{
  evaluate-commands -save-regs 'z' -draft %{
    # we use the z register to reset the buffer easily to the original content
    set-register z "%opt{swiper_content}"

    # filter the content with the command
    execute-keys "%%""zR|%arg{1} ""%val{text}""<ret>"

    # set the swiper terms; useful for modeline integration for instance
    set-option buffer swiper_terms "%val{text}"
  }
}

define-command -hidden -docstring 'swiper-reset: reset swiper to its initial state' swiper-reset %{
  # restore original content
  set-register z %opt{swiper_content}
  execute-keys '%"zRgg'

  # reset terms
  set-option buffer swiper_terms ''
}
