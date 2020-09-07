-- This applescript will open a new iTerm window.
-- It is extremely helpful when using spotlight to open iterm
-- in the current workspace.
-- NOTE: This requires accessibility permissions due to the
-- use of System Events, in particular we "click" menu items.

tell application "System Events"
	set ProcessList to name of every process
	-- Check if iTerm2 is open.
	if "iTerm2" is in ProcessList then
		-- If already open, tell iTerm to open a new window.
		tell process "iTerm2"
			click menu item "New Window" of menu 1 of menu bar item "Shell" of menu bar 1
		end tell
	else
		-- If not open, just open iTerm
		tell application "/Applications/iTerm.app" to activate
	end if
end tell

