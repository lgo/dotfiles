local function enableDoNotDisturb()
  hs.execute("defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean true")
  hs.execute("defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturbDate -date \"`date -u +\"%Y-%m-%d %H:%M:%S +000\"`\"")
  hs.execute("killall NotificationCenter")
end

superKey
  :bind('p'):toFunction("Pairing mode", function()
  enableDoNotDisturb()

  hs.alert("Entering pairing mode")
end)
