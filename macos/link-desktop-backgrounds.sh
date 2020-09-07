#!/usr/bin/env bash
#
# Adds the desktop background folder to the Settings > Desktop & Screen Saver
# list of user folders.
#
BACKGROUND_DIR=$HOME/.dotfiles/macos/desktop_backgrounds

existing_user_folders=$(/usr/libexec/PlistBuddy -c "Print :DSKDesktopPrefPane:UserFolderPaths" ~/Library/Preferences/com.apple.systempreferences.plist | sed '1d;$d')

if [[ $existing_user_folders =~ $BACKGROUND_DIR ]]; then
  # Path already added, so just exit.
  echo "$BACKGROUND_DIR is already a User Folder"
  exit 0
fi

# /usr/libexec/PlistBuddy -c "Add :DSKDesktopPrefPane:UserFolderPaths:0 string $BACKGROUND_DIR" ~/Library/Preferences/com.apple.systempreferences.plist
echo "Added $BACKGROUND_DIR to Desktop User Folders"
