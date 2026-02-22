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

# Cache go-task completion script so shell startup stays fast.
if command -v task >/dev/null 2>&1; then
  _task_completion_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/task"
  _task_completion_cache_file="$_task_completion_cache_dir/completion.zsh"
  _task_bin="$(command -v task)"
  if [[ ! -r $_task_completion_cache_file || $_task_bin -nt $_task_completion_cache_file ]]; then
    mkdir -p "$_task_completion_cache_dir"
    task --completion zsh >|"$_task_completion_cache_file"
  fi
  source "$_task_completion_cache_file"
  unset _task_completion_cache_dir _task_completion_cache_file _task_bin
fi

if [[ -n ${ZSH_STARTUP_PROFILING:-} ]]; then
  zprof
fi
