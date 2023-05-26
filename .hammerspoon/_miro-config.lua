hs.loadSpoon("MiroWindowsManager")

local hyper = { "ctrl", "shift", "cmd" }

hs.window.animationDuration = 0.1
-- spoon.MiroWindowsManager:bindHotkeys({
-- 	up = { { "ctrl", "shift" }, "up" },
-- 	right = { { "ctrl", "shift" }, "right" },
-- 	down = { { "ctrl", "shift" }, "down" },
-- 	left = { { "ctrl", "shift" }, "left" },
-- 	fullscreen = { hyper, "f" },
-- 	nextscreen = { hyper, "n" } -- n conficts with Dvorak n -- add PR!
-- })

spoon.MiroWindowsManager:bindHotkeys({
    up = { { "ctrl", "shift" }, "h" },
    right = { { "ctrl", "shift" }, "w" },
    down = { { "ctrl", "shift" }, "t" },
    left = { { "ctrl", "shift" }, "m" },
    fullscreen = { hyper, "f" },
    nextscreen = { hyper, "n" } -- n conficts with Dvorak n -- add PR!
})

-- hs.hotkey.bind(
--     {"ctrl", "shift", "alt"},
--     "m",
-- 	function() mwmLeft() end
-- )

spoon.MiroWindowsManager.fullScreenSizes = { 1, 4 / 3, 3 / 2 }

spoon.MiroWindowsManager:bindHotkeys2({
    up = { { "ctrl", "shift", "alt" }, "h" },
    right = { { "ctrl", "shift", "alt" }, "w" },
    down = { { "ctrl", "shift", "alt" }, "t" },
    left = { { "ctrl", "shift", "alt" }, "m" },
})

spoon.MiroWindowsManager:bindHotkeys2({
    left = { { "ctrl", "shift" }, "m" },
    up = { { "ctrl", "shift" }, "k" },
    right = { { "ctrl", "shift" }, "," },
    down = { { "ctrl", "shift" }, "j" },
})

-- vim windows: ctrl+alt+1,2,3
-- vim tabs: ctrl+1,2,3

function indexOf(table, value)
    print("tableble", table)
    print("value", value)
    for i, v in ipairs(table) do
        if v == value then
            print("returning")
            return i
        end
    end
end

function moveWindowToSpacePre(space)
    local win = hs.window.focusedWindow() -- current window
    local cur_screen = hs.screen.mainScreen()
    print("cur_screen", cur_screen)
    local cur_screen_id = cur_screen:getUUID()
    print("cur_screen_id", cur_screen_id)
    local all_spaces = hs.spaces.allSpaces()
    local curScreenSpaces = all_spaces[cur_screen_id]
    moveWindowToSpace(win, curScreenSpaces[space])
end

function moveWindowTopace(win, spaceId)
    print("win", win)
    print("spaceId", spaceId)

    hs.spaces.moveWindowToSpace(win, spaceId)
    res = hs.spaces.gotoSpace(spaceId)
    if res then
        hs.spaces.closeMissionControl()
    end
end

local function moveCurrentWindowToSpace(spaceId)
    local win = hs.window.focusedWindow()
    moveWindowToSpace(win, spaceId)
end

local function moveWindowToNeighboringSpace(action)
    -- old:
    -- local win = hs.window.focusedWindow()
    -- print(win)
    -- local screen = win:screen()
    -- print(screen)
    -- res = hs.spaces.moveWindowToSpace(win, index)
    -- print(res)
    -- res = hs.spaces.gotoSpace(index)
    -- print(res)
    -- print(hs.spaces.allSpaces())
    -- if res then
    -- 	hs.spaces.closeMissionControl()
    -- end
    -- from https://stackoverflow.com/a/72378669/4204961
    local win = hs.window.focusedWindow() -- current window
    local cur_screen = hs.screen.mainScreen()
    print("cur_screen", cur_screen)
    local cur_screen_id = cur_screen:getUUID()
    print("cur_screen_id", cur_screen_id)
    local all_spaces = hs.spaces.allSpaces()
    local curScreenSpaces = all_spaces[cur_screen_id]
    print("all_spaces", all_spaces)
    indexOfCurrentSpace = indexOf(curScreenSpaces, hs.spaces.activeSpaceOnScreen(cur_screen))
    print("indexOfCurrentSpace", indexOfCurrentSpace)
    indexOfNewSpace = nil
    if action == "left" then
        indexOfNewSpace = indexOfCurrentSpace - 1
        print(indexOfNewSpace)
    elseif action == "right" then
        indexOfNewSpace = indexOfCurrentSpace + 1
        print(indexOfNewSpace)
    end
    moveWindowToSpace(win, curScreenSpaces[indexOfNewSpace])

    -- 	local next_space = all_spaces[1]
    -- 	print("next_space", next_space)
    -- 	local next_screen = hs.screen.allScreens()[1]
    -- 	print("next_screen", next_screen)
    -- 	local next_screen_id = next_screen:getUUID()
    -- 	print("next_screen_id", next_screen_id)
    -- 	hs.spaces.moveWindowToSpace(win, next_space)
    -- 	hs.spaces.changeToSpace(next_space)
    -- 	hs.spaces.closeMissionControl()
    -- 	hs.window.focusedWindow():moveToScreen(next_screen)
    -- local spaceID = all_spaces[cur_screen_id][action]
    -- print("spaceID", spaceID)
    -- hs.spaces.moveWindowToSpace(win, spaceID)
    -- res = hs.spaces.gotoSpace(spaceID)
    -- if res then
    -- 	hs.spaces.closeMissionControl()
    -- end
end

for i = 1, 9 do
    hs.hotkey.bind({ "ctrl", "cmd", "shift" }, tostring(i - 1),
        function()
            moveWindowToSpacePre(i)
        end
    )
end

hs.hotkey.bind({ "ctrl", "shift" }, "left",
    function()
        moveWindowToNeighboringSpace("left")
    end
)

hs.hotkey.bind({ "ctrl", "shift" }, "right",
    function()
        moveWindowToNeighboringSpace("right")
    end
)

hs.hotkey.bind({ "ctrl" }, "left", function() k({ "ctrl", "alt" }, "m") end)
hs.hotkey.bind({ "ctrl" }, "down", function() k({ "ctrl", "alt" }, "t") end)
hs.hotkey.bind({ "ctrl" }, "up", function() k({ "ctrl", "alt" }, "h") end)
hs.hotkey.bind({ "ctrl" }, "right", function() k({ "ctrl", "alt" }, "w") end)
hs.hotkey.bind({ "ctrl" }, "right", function() k({ "ctrl", "alt" }, "w") end)

hs.hotkey.bind({ "alt" }, "e", function() k({ "cmd" }, "down") end)
hs.hotkey.bind({ "alt" }, "d", function() k({ "cmd" }, "down") end)
hs.hotkey.bind({ "alt", "shift" }, "e", function() k({ "cmd" }, "up") end)
hs.hotkey.bind({ "alt", "shift" }, "d", function() k({ "cmd" }, "up") end)

hs.hotkey.bind({ "ctrl", "shift", "cmd" }, "left",
    function()
        local win = hs.window.focusedWindow()
        win:moveOneScreenWest()
    end)

hs.hotkey.bind({ "ctrl", "shift", "cmd" }, "down",
    function()
        local win = hs.window.focusedWindow()
        win:moveOneScreenSouth()
    end)

hs.hotkey.bind({ "ctrl", "shift", "cmd" }, "up",
    function()
        local win = hs.window.focusedWindow()
        win:moveOneScreenNorth()
    end)

hs.hotkey.bind({ "ctrl", "shift", "cmd" }, "right",
    function()
        local win = hs.window.focusedWindow()
        win:moveOneScreenEast()
    end)

-- Tiling

hs.hotkey.bind({ "ctrl", "alt", "shift" }, "j",
    function()
        print(hs.windows.orderedWwindows())
    end
)
