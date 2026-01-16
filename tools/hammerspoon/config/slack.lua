local function focusSlackMessageBox()
  hs.application.launchOrFocus("Slack")
  hs.timer.doAfter(0.3, function()
    hs.eventtap.keyStroke({'shift'}, 'F6', 500)
  end)
end

-- Focuses on the Slack message box.
superKey
  :bind('f'):toFunction("Slack: focus messages", focusSlackMessageBox)