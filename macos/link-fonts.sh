#!/usr/bin/env bash

# Sets up the link for fonts.

# Check if the link is already set.
[[ "$(readlink $HOME/Library/Fonts)" = "$HOME/.dotfiles/fonts" ]] && exit 0

# Move any existing fonts over to the dotfiles directory.
[[ -d "$HOME/Library/Fonts" ]] && mv $HOME/Library/Fonts/** $HOME/.dotfiles/fonts
# Remove the home directory, either if it was a link or folder.
[[ -L "$HOME/Library/Fonts" ]] && rm $HOME/Library/Fonts
[[ -d "$HOME/Library/Fonts" ]] && rmdir $HOME/Library/Fonts

# Link!
ln -s ~/.dotfiles/fonts ~/Library/Fonts
