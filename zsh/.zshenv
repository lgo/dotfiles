# Environment configs.
setopt nullglob
setopt extendedglob

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES="$HOME/.dotfiles"

# your project folder that we can `c [tab]` to
export PROJECTS="$HOME/Code"

local _old_path="$PATH"

# env zsh files
typeset -U env_files
env_files=($DOTFILES/zsh/**/*env.zsh)

# load the env files
for file in ${env_files}; do
  source "$file"
done

if [[ $PATH != $_old_path ]]; then
  # `colors` isn't initialized yet, so define a few manually
  typeset -AHg fg fg_bold
  if [ -t 2 ]; then
    fg[red]=$'\e[31m'
    fg_bold[white]=$'\e[1;37m'
    reset_color=$'\e[m'
  else
    fg[red]=""
    fg_bold[white]=""
    reset_color=""
  fi

  cat <<MSG >&2
${fg[red]}Warning:${reset_color} your \`~/.zshenv.local' configuration seems to edit PATH entries.
Please move that configuration to \`.zshrc.local' like so:
  ${fg_bold[white]}cat ~/.zshenv.local >> ~/.zshrc.local && rm ~/.zshenv.local${reset_color}
(called from ${(%):-%N:%i})
MSG
fi

unset _old_path

unset path_files env_files
unsetopt nullglob
unsetopt extendedglob