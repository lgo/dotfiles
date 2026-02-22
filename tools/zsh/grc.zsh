# GRC colorizes nifty unix tools all over the place
if (($+commands[grc])); then
  _grc_bashrc=""

  if [[ -r /opt/homebrew/etc/grc.bashrc ]]; then
    _grc_bashrc=/opt/homebrew/etc/grc.bashrc
  elif [[ -r /usr/local/etc/grc.bashrc ]]; then
    _grc_bashrc=/usr/local/etc/grc.bashrc
  elif (($+commands[brew])); then
    _brew_prefix="$(brew --prefix 2>/dev/null || true)"
    if [[ -n "$_brew_prefix" && -r "$_brew_prefix/etc/grc.bashrc" ]]; then
      _grc_bashrc="$_brew_prefix/etc/grc.bashrc"
    fi
    unset _brew_prefix
  fi

  if [[ -n "$_grc_bashrc" ]]; then
    source "$_grc_bashrc"
  fi

  unset _grc_bashrc
fi
