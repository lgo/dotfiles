# arm64 variant of brew. Running `brew shellenv` on every interactive shell
# was adding roughly 150-200ms of latency from the Ruby bootstrap. Cache the
# environment it provides instead of spawning brew each time.
if [[ -z ${HOMEBREW_PREFIX:-} ]]; then
  export HOMEBREW_PREFIX="/usr/local"
  export HOMEBREW_CELLAR="/usr/local/Cellar"
  export HOMEBREW_REPOSITORY="/usr/local"
fi

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export MANPATH="/usr/local/share/man:${MANPATH:-}"
export INFOPATH="/usr/local/share/info:${INFOPATH:-}"
