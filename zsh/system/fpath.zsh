# Restrict `fpath` to zsh topic folders only. Previously we added every
# top-level directory in the repo which made `compinit` stat a few dozen extra
# paths and cost ~20ms per shell.
for topic_folder in $DOTFILES/zsh/* $DOTFILES/zsh-devbox/*; do
  [[ -d $topic_folder ]] || continue
  fpath=($topic_folder $fpath)
done
