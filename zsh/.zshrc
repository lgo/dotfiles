# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -n ${ZSH_STARTUP_PROFILING:-} ]]; then
  zmodload zsh/zprof
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Antidote
# Profiling showed `antidote bundle` costs ~800ms when run on every shell.
# Instead we build a cached plugin script (default refresh every 6 hours) and
# source that, keeping interactive shells in the sub-50ms range.
source "$DOTFILES/.antidote/antidote.zsh"
_antidote_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/antidote"
_antidote_cache_file="$_antidote_cache_dir/plugins-${ZSH_VERSION}.zsh"
integer _antidote_cache_ttl=${DOTFILES_ANTIDOTE_CACHE_TTL:-21600}
integer _antidote_cache_stale=0
if [[ -r $_antidote_cache_file && _antidote_cache_ttl -gt 0 ]]; then
  zmodload zsh/stat 2>/dev/null
  if zstat -H _antidote_cache_info "$_antidote_cache_file" 2>/dev/null; then
    (( EPOCHSECONDS - _antidote_cache_info[mtime] > _antidote_cache_ttl )) && _antidote_cache_stale=1
  fi
fi
if [[ ! -r $_antidote_cache_file || _antidote_cache_stale == 1 || $DOTFILES/zsh/antidote/zsh_plugins.txt -nt $_antidote_cache_file || ${ZDOTDIR:-$HOME}/.zsh_plugins.txt -nt $_antidote_cache_file ]]; then
  mkdir -p "$_antidote_cache_dir"
  antidote bundle <"${ZDOTDIR:-$HOME}/.zsh_plugins.txt" >|"$_antidote_cache_file"
fi
source "$_antidote_cache_file"
unset _antidote_cache_dir _antidote_cache_file _antidote_cache_ttl _antidote_cache_stale _antidote_cache_info

# Powerlevel10k settings.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # Interactive environment configs.
setopt nullglob
setopt extendedglob

# # Disables tracking certain things in Git by ZSH, which includes the colour
# # of the Git status bar (orange) when there are untracked files. This is
# # fairly slow for repositories.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# # Stash your environment variables in ~/.localrc. This means they'll stay out
# # of your main dotfiles repository (which may be public, like this one), but
# # you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]; then
  source ~/.localrc
fi

# all of our non-path/env/profile/login/logout zsh files
typeset -U  interactive_files completion_files
interactive_files=($DOTFILES/zsh/**/*.zsh~$DOTFILES/zsh/**/*completion.zsh~$DOTFILES/zsh/**/*path.zsh~$DOTFILES/zsh/**/*env.zsh~$DOTFILES/zsh/**/*profile.zsh~$DOTFILES/zsh/**/*login.zsh~$DOTFILES/zsh/**/*logout.zsh)
completion_files=($DOTFILES/zsh/**/*completion.zsh)

# Prevents tmux spawning duplicates for path (by de-duplicating the variable).
typeset -aU path

# Load interactive files (everything else)
for file in "${interactive_files[@]}" "${${completion_files[@]}}"; do
  source "$file"
done

unset interactive_files completion_files
unsetopt nullglob extendedglob

# Continue to source bash files so that if something adds a configuration to
# them, it will work without first editing files.
: ${DOTFILES_LOAD_BASH_RC:=0}
if (( DOTFILES_LOAD_BASH_RC )); then
  if [[ -z ${__DOTFILES_LOGIN_PROFILE_LOADED:-} ]]; then
    [[ -r ~/.bash_profile ]] && source ~/.bash_profile
    [[ -r ~/.bashrc ]] && source ~/.bashrc
  fi
fi

autoload -Uz promptinit && promptinit

# Keep completion startup snappy. Generating a fresh zcompdump can take ~500ms,
# so we reuse a per-host cache and tell `compinit` to trust it until files
# change. Warm shells end up with compinit around ~15ms.
autoload -Uz compinit
_dotfiles_compdump="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-${HOST}-${ZSH_VERSION}"
if [[ ! -r $_dotfiles_compdump ]]; then
  compinit -i -d "$_dotfiles_compdump"
else
  compinit -C -i -d "$_dotfiles_compdump"
fi
unset _dotfiles_compdump

autoload -Uz bashcompinit && bashcompinit -u

. "$HOME/.local/bin/env"

export PATH="$HOME/.local/bin:$PATH"

if [[ -n ${ZSH_STARTUP_PROFILING:-} ]]; then
  zprof
fi
