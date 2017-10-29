#!/bin/sh
#
# iTerm
#
# This creates and installs an app to open a new window of iterm on
# the current workspace

echo "› iTerm -- adding \"New Window\" version"

osacompile -o "/Applications/iTerm - New Window.app" ~/.dotfiles/iterm/new_window.applescript
cp -f "/Applications/iTerm.app/Contents/Resources/AppIcon.icns"  "/Applications/iTerm - New Window.app/Contents/Resources/applet.icns"
