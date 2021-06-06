DOTFILES="$HOME/.dotfiles"

#####################
# ZINIT             #
#####################
### Installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing zinit plugin manager (zdharma/zinit)…%f"
    command mkdir -p $HOME/.zinit
    command git clone https://github.com/zdharma/zinit $HOME/.zinit/bin && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
        print -P "%F{160}▓▒░ The clone has failed.%F"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#####################
# P10K              #
#####################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#####################
# MISC              #
#####################
# Stash your environment variables in ~/.localrc. This means they'll stay out of
# your main dotfiles repository (which may be public, like this one), but you'll
# have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

#####################
# PLUGINS           #
#####################
# ssh agent
zinit light bobsoppe/zsh-ssh-agent

source $DOTFILES/zsh/fzf.zsh

#####################
# LEGACY            #
#####################
# Interactive environment configs.
# setopt nullglob extendedglob

# # all of our non-path/env/profile/login/logout zsh files
# typeset -U path_files path_files interactive_files completion_files
# path_files=($DOTFILES/**/*path.zsh~**/*fpath.zsh)
# fpath_files=($DOTFILES**/*fpath.zsh)
# interactive_files=($DOTFILES/**/*.zsh~$DOTFILES**/*completion.zsh~$DOTFILES**/*path.zsh~$DOTFILES**/*env.zsh~$DOTFILES**/*profile.zsh~$DOTFILES**/*login.zsh~$DOTFILES**/*logout.zsh~$DOTFILES/zsh/p10k.zsh)
# completion_files=($DOTFILES/**/*completion.zsh)

# # Prevents tmux spawning duplicates for path (by de-duplicating the variable).
# typeset -aU path

# # path and env zsh files
# env_files=($DOTFILES/**/*env.zsh)

# # load the path files
# for file in ${path_files}; do
#   source "$file"
# done

# # load fpath config files
# for file in ${fpath_files}; do
#   source "$file"
# done

# # load interactive files (everything but the completion, path, env,
# # profile, login, and logout files)
# for file in ${interactive_files}; do
#   source "$file"
# done


# # load every completion after autocomplete loads
# for file in ${completion_files}; do
#   source "$file"
# done

# unset fpath_files interactive_files completion_files
# unsetopt nullglob extendedglob

# autoload -Uz compinit; compinit -u
# autoload -Uz bashcompinit; bashcompinit -u
# source ~/.bash_profile
# source ~/.bashrc
# eval "$(nodenv init -)"