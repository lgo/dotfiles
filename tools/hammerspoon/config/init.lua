-- Add SpoonInstall. This must be downloaded from
-- http://www.hammerspoon.org/Spoons/SpoonInstall.html on new installs.
local function enableBasicReload()
    local function reloadConfig(_)
        hs.reload()
    end
    hs.pathwatcher.new(hs.configdir, reloadConfig):start()
end

local okSpoonInstall, spoonInstall = pcall(hs.loadSpoon, "SpoonInstall")
if okSpoonInstall and spoonInstall and spoon.SpoonInstall then
    -- Add ReloadConfiguration which enables automatic configuration reloading.
    spoon.SpoonInstall:andUse("ReloadConfiguration")
    if spoon.ReloadConfiguration then
        spoon.ReloadConfiguration:start()
    end
else
    enableBasicReload()
    hs.printf("SpoonInstall not found; using basic reload watcher.")
end

-- Key modifiers.
super = {'ctrl', 'alt', 'cmd', 'shift'}
hyper = {'ctrl', 'alt', 'cmd'}

-- Load and create a new switcher.
--
-- HyperKey allows registering in a global hotkey registry that has a help menu.
local okHyperKey, HyperKey = pcall(hs.loadSpoon, "HyperKey")
if okHyperKey and HyperKey then
    hyperKey = HyperKey:new(hyper)
    superKey = HyperKey:new(super)
else
    hs.printf("HyperKey spoon not found; hotkey registry disabled.")
end

-- Lua aliases.
inspect = hs.inspect.inspect
function p(variable)
    print(inspect(variable))
end

require "utc-clock-menubar"

-- require "automatic-monitor-switch"
-- require "audio-switcher"
-- require "slack"
-- require "quick-switch"
-- require "pairing-mode"
-- require "key-bindings"

-- require "space-management"
-- require "work-env"
