# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )) && (( $+commands[brew] )); then
  # TODO(joey): brew --prefix hardcoded.
  # source `brew --prefix`/etc/grc.bashrc
  source /usr/local/etc/grc.bashrc
fi
