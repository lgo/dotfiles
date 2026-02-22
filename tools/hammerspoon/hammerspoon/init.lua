-- Add SpoonInstall. This must be downloaded from
-- http://www.hammerspoon.org/Spoons/SpoonInstall.html on new installs.
hs.loadSpoon("SpoonInstall")

-- Add ReloadConfiguration which enables automatic configuration reloading.
spoon.SpoonInstall:andUse("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Key modifiers.
super = {'ctrl', 'alt', 'cmd', 'shift'}
hyper = {'ctrl', 'alt', 'cmd'}

-- Load and create a new switcher.
--
-- HyperKey allows registering in a global hotkey registry that has a help menu.
local HyperKey = hs.loadSpoon("HyperKey")
hyperKey = HyperKey:new(hyper)
superKey = HyperKey:new(super)

-- Lua aliases.
inspect = hs.inspect.inspect
function p(variable)
    print(inspect(variable))
end

require "automatic-monitor-switch"
require "audio-switcher"
require "slack"
require "quick-switch"
require "pairing-mode"
require "key-bindings"

-- require "space-management"
-- require "work-env"
