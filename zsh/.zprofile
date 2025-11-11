# NOTE: Not intended to be used with zlogin, but can be.

# Login profile configs.
setopt nullglob
setopt extendedglob

typeset -U profile_files path_files fpath_files env_files
# PATH defining files (excluding FPATH).
path_files=($DOTFILES/zsh/**/*path.zsh~$DOTFILES/zsh/**/*fpath.zsh)
# Profile zsh files for loading.
profile_files=($DOTFILES/zsh/**/*profile.zsh)
# FPATH defining files.
fpath_files=($DOTFILES/zsh/**/*fpath.zsh)
# env value files
env_files=($DOTFILES/zsh/**/*env.zsh)

# Source all of the configuration files.
for file in "${path_files[@]}" "${fpath_files[@]}" "${env_files[@]}" "${profile_files[@]}"; do
    source "$file"
done

unset profile_files path_files fpath_files env_files
unsetopt nullglob
unsetopt extendedglob
