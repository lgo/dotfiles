local wm = require('window-management')


hyperKey
  :bind('left'):toFunction("Spotify: previous", hs.spotify.previous)
  :bind('right'):toFunction("Spotify: next", hs.spotify.next)
  :bind('down'):toFunction("Spotify: play/pause", hs.spotify.playpause)


local function popoutChromeTab()
  hs.application.launchOrFocus('/Applications/Google Chrome.app')

  local chrome = hs.appfinder.appFromName("Google Chrome")
  local moveTab = {'Tab', 'Move Tab to New Window'}

  chrome:selectMenuItem(moveTab)
end


-- popout the current chrome tab and view 50-50 side by side
hs.hotkey.bind(super, ']', function()
  -- Move current window to the left half
  wm.leftHalf()

  hs.timer.doAfter(100 / 1000, function()
    -- Pop out the current tab and move it to the right
    popoutChromeTab()
    wm.rightHalf()
  end)
end)
