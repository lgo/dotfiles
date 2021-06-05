-- Space management is a module for automatic layout management of spaces and
-- screens. It supports a setup with either 1 (laptop) display or 2 (laptop +
-- external) displays.
--
-- It is motivated by xmonad-like configuration, where it is possible to
-- configure which screens windows will move to and also specific screens
-- configurations.
--
-- Two modes are provided:
--
--   * Strict, which strictly maintains basic window location on screens and the
--     layout of on-screen windows.
--
--   * Soft, which will coerce windows to a structured format on a hotkey press
--     otherwise it will only maintain single-screen auto-layout.
--
-- Auto-layout is handled in a BSP-style, where the screen will form a tree-like
-- divide of windows.
--
-- In both strict and soft mode, spaces will be assigned a type based. In strict
-- mode, they are strictly typed and configured. In soft mode, they are typed
-- based on their contents (eg: editor vs. browser vs. music player).

------------------
--- Screen watcher
------------------

-- Set screen watcher, in case you connect a new monitor, or unplug a monitor
local screens = {}
local screenArr = {}

-- Identifier for the laptop LCD.
local laptopScreenIdentifier = "Color LCD"

laptopScreen = nil
externalScreen = nil

-- otherScreens will filter out the laptopScreen from the other screens.
function otherScreens(screens, laptopScreen)
  local out = {}

  for k, v in pairs(screens) do
    if v:id() ~= laptopScreen:id() then out[k] = v end
  end

  return out
end

-- reloadScreens will reload the `screens`, `laptopScreen`, and `externalScreen`
-- variables based on the currently connected screens.
function reloadScreens()
  -- TODO(joey): Handle screen changes.
  screens = hs.screen.allScreens()
  laptopScreen = hs.screen.find(laptopScreenIdentifier)
  other = otherScreens(screens, laptopScreen)
  if #other == 1 then externalScreen = other[1] else externalScreen = nil end
  print("Reloading screen variables.")
  print("laptopScreen: ", inspect(laptopScreen))
  print("externalScreen: ", inspect(externalScreen))
end

-- Start the reloadScreens watcher for screen changes, and run it once to
-- populate the values.
local screenwatcher = hs.screen.watcher.new(reloadScreens)
screenwatcher:start()
reloadScreens()

---------------------------------
--- Specialized window management
---------------------------------

-- Escapes characters in a pattern to always be literals. Because % is a valid
-- escape for all characters, we can simply prepend every char with %.
function escape_pattern(text)
  local escaped, _ = text:gsub("([^%w])", "%%%1")
  return escaped
end

function windowFilterVscodeRepo(repo_name)
  -- Expects the VS Code window title to be set in settings with:
  -- "window.title": "${rootName}${separator}${activeEditorMedium}",
  --
  -- Additionally, the input needs to be escaped to be able to match, otherwise
  -- patterns like "pay-server" would not work.
  local title_prefix = string.format("^%s — ", escape_pattern(repo_name))
  return hs.window.filter.new {'Code'}:setAppFilter('Code', {allowTitles = title_prefix})
end

---------------------------
--- Space window management
---------------------------

-- inspect(twoDisplayScreenLayouts["external"][1]["filter"]:getWindows())

twoDisplayScreenLayouts = {
  external = {
    {
      name = "pay-server",
      filter = windowFilterVscodeRepo('pay-server')
    },
    {
      name = "zoolander",
    },
    {
      name = "uppsala",
    },
    {
      name = "personal dev",
    },
  },
  -- Display
  laptop = {
    -- Screen 1
    {
      name = "work chrome",
    },
    {
      name = "slack",
      filter = hs.window.filter.new {'Slack'}
    },
    {
      name = "personal chrome",
    }
  },
}

hs.settings.set("_ASMundocumentedSpacesRaw", true)
spaces = require("hs._asm.undocumented.spaces")

-- Emergency "break the glass" to reset spaces, when using raw spaces.raw
-- methods.
resetSpaces = function()
  local s = require("hs._asm.undocumented.spaces")
  -- bypass check for raw function access
  local si = require("hs._asm.undocumented.spaces.internal")
  for k,v in pairs(s.spacesByScreenUUID()) do
      local first = true
      for a,b in ipairs(v) do
          if first and si.spaceType(b) == s.types.user then
              si.showSpaces(b)
              si._changeToSpace(b)
              first = false
          else
              si.hideSpaces(b)
          end
          si.spaceTransform(b, nil)
      end
      si.setScreenUUIDisAnimating(k, false)
  end
  hs.execute("killall Dock")
end

function coerceSpaces()
  if externalScreen == nil then
    -- TODO(joey): Add a single display format.
    print("No single display mode supported yet")
  else
    print("Running coerce space")
    for screenName, layout in pairs(twoDisplayScreenLayouts) do
      local screen = nil
      if screenName == "laptop" then
        screen = laptopScreen
      elseif screenName == "external" then
        screen = externalScreen
      else
        print("Unknown display name screenName=", screenName)
        return
      end

      local spaceLayoutForScreen = spaces.layout()[screen:getUUID()]
      for i, space in ipairs(layout) do
        local space_id = spaceLayoutForScreen[i]

        print(string.format("Coercing layout for screen=%s idx=%d name=%s space_id=%d", screenName, i, space["name"], space_id))
        -- TODO(joey): Create space if screen does not already have the space.

        local wf = space["filter"]
        if wf then
          local windows = wf:getWindows()
          for _, window in ipairs(windows) do
            spaces.moveWindowToSpace(window:id(), space_id)
          end
        end
      end 
    end
  end
end

function strictSpaceLayouts()
  if externalScreen == nil then
    -- TODO(joey): Add a single display format.
    print("No single display mode supported yet")
  else
    print("Running space layouts")
    for screenName, layout in pairs(twoDisplayScreenLayouts) do
      local screen = nil
      if screenName == "laptop" then
        screen = laptopScreen
      elseif screenName == "external" then
        screen = externalScreen
      else
        print("Unknown display name screenName=", screenName)
        return
      end

      local spaceLayoutForScreen = spaces.layout()[screen:getUUID()]
      print(string.format("Now building layout for screen=%s", screenName))
      for i, space in ipairs(layout) do
        local space_id = spaceLayoutForScreen[i]

        print(string.format("Executing layout for screen=%s idx=%d name=%s space_id=%d", screenName, i, space["name"], space_id))
        -- TODO(joey): Create space if screen does not already have the space.

        local wf = space["filter"]
        if wf then
          wf:subscribe(hs.window.filter.windowCreated, (function(window, appName, eventName)
            print("I am running...")
            spaces.moveWindowToSpace(window:id(), space_id)
          end), true --[[ immediate ]])
        end
      end 
    end
  end
end

-- Attempts to relayout the space for the following window. This is provided as
-- a convenience function to avoid having to do a complete re-layout.
function spaceRelayout(window)
end

-- Add hotkey for a one-time window coercion.
superKey
  :bind('a'):toFunction('Space Manager: coerce', coerceSpaces)

coerceSpaces()

local strictWindowMode = true

if strictWindowMode then
  strictSpaceLayouts()
end
-- TODO(joey): Add an active window management element.