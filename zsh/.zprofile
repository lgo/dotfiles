# NOTE: Not intended to be used with zlogin, but can be.

# Login profile configs.
setopt nullglob

# Fetch all of our profile zsh files for loading.
typeset -U profile_files path_files fpath_files env_files
profile_files=($DOTFILES/**/profile.zsh)
# And also PATH defining files.
path_files=($DOTFILES/**/path.zsh)
# And also FPATH defining files.
fpath_files=($DOTFILES/**/fpath.zsh)
# And also env value files
env_files=($DOTFILES/**/env.zsh)

# Source all of the configuration files.
for file in "${profile_files[@]}" "${path_files[@]}" "${fpath_files[@]}" "${env_files[@]}"; do
    source "$file"
done

unset profile_files path_files fpath_files env_files
unsetopt nullglob

# Continue to source bash files so that if something adds a configuration to
# them, it will work without first editing files.
source ~/.bash_profile