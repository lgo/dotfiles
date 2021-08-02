# Interactive environment configs.
setopt nullglob extendedglob

# Disables tracking certain things in Git by ZSH, which includes the colour
# of the Git status bar (orange) when there are untracked files. This is
# fairly slow for repositories such as pay-server.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# all of our non-path/env/profile/login/logout zsh files
typeset -U  interactive_files completion_files
interactive_files=($DOTFILES/**/*.zsh~$DOTFILES/**/*completion.zsh~$DOTFILES/**/*path.zsh~$DOTFILES/**/*env.zsh~$DOTFILES/**/*profile.zsh~$DOTFILES/**/*login.zsh~$DOTFILES/**/*logout.zsh)
completion_files=($DOTFILES/**/*completion.zsh)

# Prevents tmux spawning duplicates for path (by de-duplicating the variable).
typeset -aU path

# Load interactive files (everything else)
for file in "${interactive_files[@]}" "${${completion_files[@]}}"; do
  source "$file"
done

unset interactive_files completion_files
unsetopt nullglob extendedglob

# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

autoload -Uz compinit; compinit -u
autoload -Uz bashcompinit; bashcompinit -u

# Continue to source bash files so that if something adds a configuration to
# them, it will work without first editing files.
source ~/.bash_profile
source ~/.bashrc

_evalcache nodenv init -