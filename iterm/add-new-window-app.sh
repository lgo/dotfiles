#!/usr/bin/env bash
#
# iTerm
#
# This creates and installs an app to open a new window of iterm on
# the current workspace.
#
# NB: You will need to give the compiled applet permissions to work.
#
# Open Security & Privacy > Go to Privacy > Accessibility
#  > Click the (+) to add a new App > Navigate to Applications and select "iTerm - New Window.app".

echo "› iTerm -- adding \"New Window\" version"

osacompile -o "/Applications/iTerm - New Window.app" ~/.dotfiles/iterm/new_window.applescript
cp -f "/Applications/iTerm.app/Contents/Resources/AppIcon.icns"  "/Applications/iTerm - New Window.app/Contents/Resources/applet.icns"
