-- automatic-monitor-switch will register a USB device callback to execute
-- `swapmonitor` when a USB device is removed.
--
-- This effectively turns a USB switch into a display switcher, as documented in
-- https://www.notion.so/Making-a-software-KVM-using-only-a-USB-switch-5d49f5bba47c4c24a761d20c5804cd4b.

local device = "ES-87"
local usbWatcher = nil

local function usbDeviceCallback(data)
    if (data["productName"] == "ES-87") then
        if (data["eventType"] == "removed") then
            -- Call swapmonitor script to change the monitor's input source.
            hs.execute("swapmonitor", true)
        end
    end
end

-- Disabled! It was too buggy.
-- usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
-- usbWatcher:start()
