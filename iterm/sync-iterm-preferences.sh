#!/usr/bin/env bash

# This simply sets the iterm preference location. I _believe_ iterm should be
# killed, otherwise it may munge the settings, but because this is in Git it is not
# too bad.
defaults write com.googlecode.iterm2 PrefsCustomFolder "$HOME/.dotfiles/iterm/preferences"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true