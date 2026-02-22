# Has been ported to nix
# NOTE: Not intended to be used with zprofile, but can be.

# Login configs.
setopt nullglob
setopt extendedglob

# all of our login zsh files
typeset -U login_files
login_files=($DOTFILES/zsh/**/login.zsh)

# run all login files
for file in ${login_files}; do
  source "$file"
done

unset login_files
unsetopt nullglob
unsetopt extendedglob
