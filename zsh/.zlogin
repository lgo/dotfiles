# NOTE: Not intended to be used with zprofile, but can be.

# Login configs.
setopt nullglob

# all of our login zsh files
typeset -U login_files
login_files=($DOTFILES/**/login.zsh)

# run all login files
for file in ${login_files}; do
    source "$file"
done

unset login_files
unsetopt nullglob

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
