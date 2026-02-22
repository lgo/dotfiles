# Antidote
# Profiling showed `antidote bundle` costs ~800ms when run on every shell.
# Instead we build a cached plugin script (default refresh every 6 hours) and
# source that, keeping interactive shells in the sub-50ms range.
_antidote_root=""
if command -v antidote >/dev/null 2>&1; then
  _antidote_bin="$(command -v antidote)"
  _antidote_root="${_antidote_bin%/bin/antidote}"
elif [[ -n ${ANTIDOTE_HOME:-} ]]; then
  _antidote_root="$ANTIDOTE_HOME"
elif [[ -r "$DOTFILES/.antidote/antidote.zsh" ]]; then
  _antidote_root="$DOTFILES/.antidote"
fi

if [[ -n $_antidote_root && -r "$_antidote_root/antidote.zsh" ]]; then
  source "$_antidote_root/antidote.zsh"
else
  _antidote_root=""
fi

if [[ -n $_antidote_root ]]; then
  _antidote_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/antidote"
  _antidote_cache_file="$_antidote_cache_dir/plugins-${ZSH_VERSION}.zsh"
  integer _antidote_cache_ttl=${DOTFILES_ANTIDOTE_CACHE_TTL:-21600}
  integer _antidote_cache_stale=0
  if [[ -r $_antidote_cache_file && _antidote_cache_ttl -gt 0 ]]; then
    zmodload zsh/stat 2>/dev/null
    if zstat -H _antidote_cache_info "$_antidote_cache_file" 2>/dev/null; then
      ((EPOCHSECONDS - _antidote_cache_info[mtime] > _antidote_cache_ttl)) && _antidote_cache_stale=1
    fi
  fi
  if [[ ! -r $_antidote_cache_file || _antidote_cache_stale == 1 || $DOTFILES/tools/zsh/antidote/zsh_plugins.txt -nt $_antidote_cache_file || ${ZDOTDIR:-$HOME}/.zsh_plugins.txt -nt $_antidote_cache_file ]]; then
    mkdir -p "$_antidote_cache_dir"
    antidote bundle <"${ZDOTDIR:-$HOME}/.zsh_plugins.txt" >|"$_antidote_cache_file"
  fi
  source "$_antidote_cache_file"
  unset _antidote_cache_dir _antidote_cache_file _antidote_cache_ttl _antidote_cache_stale _antidote_cache_info
fi
unset _antidote_root _antidote_bin

# Starship prompt.
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

setopt nullglob
setopt extendedglob

if [[ -e ~/.localrc ]]; then
  source ~/.localrc
fi

# Prevents tmux spawning duplicates for path (by de-duplicating the variable).
typeset -aU path

unsetopt nullglob extendedglob

# Continue to source bash files so that if something adds a configuration to
# them, it will work without first editing files.
: ${DOTFILES_LOAD_BASH_RC:=0}
if ((DOTFILES_LOAD_BASH_RC)); then
  if [[ -z ${__DOTFILES_LOGIN_PROFILE_LOADED:-} ]]; then
    [[ -r ~/.bash_profile ]] && source ~/.bash_profile
    [[ -r ~/.bashrc ]] && source ~/.bashrc
  fi
fi
