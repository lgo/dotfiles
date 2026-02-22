# Keep this minimal. Program-specific env/path/aliases are sourced explicitly
# from Nix-managed zsh init (not via globbing `~/.dotfiles/**`).
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Load local machine-specific exports (tokens, private endpoints, etc.) across
# shell modes. Guard to avoid double-sourcing when interactive init runs.
if [[ -z ${__DOTFILES_LOCALRC_LOADED:-} && -r "$HOME/.localrc" ]]; then
  export __DOTFILES_LOCALRC_LOADED=1
  source "$HOME/.localrc"
fi
