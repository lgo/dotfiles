-- create a menubar item
local utcClock = hs.menubar.new()

-- function to update the title to UTC time
local function updateUTC()
    -- os.date with '!' forces UTC
    local t = os.date("!%m/%d %H:%M (UTC)", os.time())
    utcClock:setTitle(t)
end

-- set initial title immediately
updateUTC()

-- start a timer to update every minute
hs.timer.doEvery(60, updateUTC)
