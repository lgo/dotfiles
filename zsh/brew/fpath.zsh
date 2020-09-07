# Include all of brew's autocompletion suggestions.
# This includes some common tools, such as git.
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
