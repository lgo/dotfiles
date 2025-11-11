# Logout configs.
setopt nullglob
setopt extendedglob

# all of our logout zsh files
typeset -U logout_files
logout_files=($DOTFILES/zsh/**/*logout.zsh)

# run all logout files
for file in ${logout_files}; do
    source "$file"
done

unset logout_files
unsetopt nullglob
unsetopt extendedglob
