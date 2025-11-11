#!/usr/bin/env bash
#
# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

echo "› macOS set defaults"

# Ask for the administrator password upfront
sudo -v

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Disable press-and-hold for keys in favor of key repeat.
# https://www.defaults-write.com/disable-press-and-hold-option-in-mac-os-x-10-7/
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable rubber band effect on scrolling past the ends of pages.
# https://www.defaults-write.com/disable-the-rubber-band-effecting-in-mac-os-x/
defaults write -g NSScrollViewRubberbanding -int 0

# Show the ~/Library folder.
chflags nohidden ~/Library

## Speed up macos animations
## https://www.defaults-write.com/speed-up-macos-high-sierra/
# Disable animation on open/close windows
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
# Disable animations when opening a Quick Look window.
defaults write -g QLPanelAnimationDuration -float 0
# Accelerated playback when adjusting the window size (Cocoa applications).
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable dashboard
defaults write com.apple.dashboard mcx-disabled -boolean true

# Make power button have shutdown dialog rather than just sleep
# https://www.defaults-write.com/re-activate-the-shutdown-dialog/
defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool no

# Disable ‘Stay on front’ for macos help windows
defaults write com.apple.helpviewer DevMode -bool true

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Disable Photos from opening when plugging in devices
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Expanded save panel by default
# https://www.defaults-write.com/expand-save-panel-default/
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true


# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false


# Disable "resume" (it is annoying, does weird things, and I like fresh restarts)
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Disable auto-correction
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Less intrusive crash reporting notification
# https://www.defaults-write.com/os-x-make-crash-reporter-appear-as-a-notification/
defaults write com.apple.CrashReporter UseUNC 1

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
# https://www.defaults-write.com/make-os-x-screenshots-without-window-shadows/
defaults write com.apple.screencapture disable-shadow -bool true

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Finder: show all filename extensions
# https://www.defaults-write.com/display-the-file-extensions-in-finder/
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Remove Dropbox’s green checkmark icons in Finder
file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Disable focus ring
# http://osxdaily.com/2016/08/17/disable-focus-ring-animation-mac-os/
defaults write -globalDomain NSUseAnimatedFocusRing -bool NO

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Reset Launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disable

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Prevent Chrome from going backward or forward in history with a gesture
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE

# Disable opening iTunes with the play button
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist

# Turn off the Power chime
defaults write com.apple.PowerChime ChimeOnNoHardware -bool true


#############
# PREFERENCES
#############


# =============
# Accessibility
# =============

# "Reduce Motion" changes œhe animation when the swipe effect of moving
# workspaces go away.
# tag:animation-disable
defaults write com.apple.universalaccess reduceMotion -bool true

# ===========
# Date & Time
# ===========
# Sets the clock to have a nice configuration:
# - 24hr
# - includes day of week and also date.
defaults write com.apple.menuextra.clock Date -string "EEE MMM d  H:mm"

# =================
# Language & Region
# =================
# Use metric and centimeters
defaults write NSGlobalDomain AppleMetricUnits -bool true
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
# Use a 24hr clock.
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true


# =================
# Energy saving
# =================

# Turns on lid wakeup
sudo pmset -a lidwake 1

# Automatic restart on power loss
sudo pmset -a autorestart 1

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Sets displaysleep to 5 minutes
sudo pmset -a displaysleep 5

# Do not allow machine to sleep on charger
sudo pmset -c sleep 0

# Set machine sleep to 5 minutes on battery
sudo pmset -b sleep 5


################
# APPLE SOFTWARE
################


# ======
# Dock
# ======

# Disable the delay when you hide the Dock
defaults write com.apple.Dock autohide-delay -float 0

# Disable workspace swoosh animation
# https://www.defaults-write.com/disable-the-spaces-animation-in-mac-os-x/
defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES

# Enables gesture to jump back to prior workspace with 4-finger tap.
defaults write com.apple.dock double-tap-jump-back -bool TRUE

#  Disable launchpad fade effects
# https://www.defaults-write.com/disable-launchpad-fade-effects/
defaults write com.apple.dock springboard-show-duration -int 0
defaults write com.apple.dock springboard-hide-duration -int 0

# Increase background blur on launchpad
defaults write com.apple.dock springboard-blur-radius -int 50

# Run the screensaver if we're in the bottom-right hot corner.
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0

# Fix for not working Exposè/Mission Control
# https://www.defaults-write.com/fix-for-not-working-exposemission-control/
defaults write com.apple.dock mcx-expose-disabled -bool FALSE


# Disable animations when you open an application from the Dock.
defaults write com.apple.dock launchanim -bool false
# Make all animations faster that are used by Mission Control.
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable dashboard on dock.
defaults write com.apple.dock dashboard-in-overlay -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

# Don’t automatically rearrange Spaces based on most recent use
# https://www.defaults-write.com/disable-automatically-rearrange-spaces-based-on-recent-use/
defaults write com.apple.dock mru-spaces -bool false

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Disable the Launchpad gesture (pinch with thumb and three fingers)
#defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# ======
# Finder
# ======

# Finder > View > As List. Always open with list view -- this is a big difference!
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Hide icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
# https://www.defaults-write.com/display-full-posix-path-in-os-x-finder-title-bar/
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder > Preferences > Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder > Preferences > Show warning before removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

# Disable animation when opening the Info window in Finder (cmd⌘ + i).
defaults write com.apple.finder DisableAllAnimations -bool true

# Show hidden files
# https://www.defaults-write.com/show-hidden-files-in-os-x-finder/
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Disable the "warn on empty trash" prompt
# https://www.defaults-write.com/disable-the-warning-before-emptying-the-trash/
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Disable "desktop"
# https://www.defaults-write.com/os-x-how-to-quickly-hide-the-desktop-icons/
defaults write com.apple.finder CreateDesktop -bool FALSE

# Add a "Stop Finder" button to the Finder dropdown
defaults write com.apple.finder QuitMenuItem -bool true


# ======
# App Store
# ======

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true


# ======
# Activity Monitor
# ======

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0


# ======
# Terminal
# ======

# Removes the "Last Login" shown when opening a Terminal prompt.
touch ~/.hushlogin

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0


# ======
# Safari
# ======

# Hide Favorites bar
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#####################
# CUSTOM APPLICATIONS
#####################

# =========
# UTC Clock
# =========
# Do not show the date. It is quite poorly formatted.
defaults write net.retina.UTCMenuClock ShowDate -bool false
# We do not enjoy seconds here either! Too distracting!
defaults write net.retina.UTCMenuClock ShowSeconds -bool false

# =========
# iTerm2
# =========

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome Canary" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Opera" \
	"Photos" \
	"Safari" \
	"SizeUp" \
	"Spectacle" \
	"SystemUIServer" \
	"Terminal" \
	"Transmission" \
	"Tweetbot" \
	"Twitter" \
	"iCal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."

