# Lightweight git prompt hook for shells that are not using Powerlevel10k
# or Starship. These prompts already render rich git status; adding another
# hook would duplicate work. When they are absent (for example inside a minimal
# SSH session) we fall back to `vcs_info` so the prompt still surfaces the
# current branch without extra plugins.

[[ -n ${STARSHIP_SHELL:-} ]] && return
(( ${+functions[prompt_powerlevel10k_setup]} || ${+functions[prompt_p10k_setup]} || ${+functions[p10k]} )) && return

autoload -Uz colors vcs_info
colors

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%F{yellow}(%b)%f%F{red}%a%f '
zstyle ':vcs_info:git*' actionformats '%F{yellow}(%b|%a)%f '
zstyle ':vcs_info:*' check-for-changes false

_dotfiles_vcs_prompt() {
  vcs_info
}

typeset -gU precmd_functions
precmd_functions+=(_dotfiles_vcs_prompt)

case ${PROMPT:-} in
  '%n@%m %1~ %# '|'%m%# ')
    PROMPT='%F{green}%n@%m%f %F{blue}%~%f ${vcs_info_msg_0_}%# '
    ;;
esac
