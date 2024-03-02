-- print('scratch')
-- Function to get a list of visible windows for user applications
function getVisibleWindows()
    local windows = {}
    local allWindows = hs.window.allWindows()
    for _, window in ipairs(allWindows) do
        if window:application():kind() == 1 and window:isVisible() then -- Only list windows of user applications that are visible
            table.insert(windows, {text = window:title(), windowObj = window})
        end
    end
    return windows
end

function getVisibleWindows()
    local windows = {}
    local allWindows = hs.window.allWindows()
    for _, window in ipairs(allWindows) do
        if window:application():kind() == 1 and window:isVisible() then
            local app = window:application()
            local bundleID = app:bundleID()
            local appIcon = nil
            if bundleID then
                appIcon = hs.image.imageFromAppBundle(bundleID)
            end
            -- Convert the icon to a base64-encoded image data URL if it exists
						print(appIcon)
            -- local iconDataUrl = appIcon and appIcon:encodeAsURLString() or nil
            local iconDataUrl = appIcon
						print(iconDataUrl)  -- Add this line for debugging
            table.insert(windows, {
                text = app:name(),
                subText = window:title(),
                image = iconDataUrl, -- The base64-encoded image data URL
                windowObj = window
            })
        end
    end
    return windows
end
-- Function to close the window
function closeWindow(window)
    if window then
        window:close()
    end
end

-- Function to quit the application of the window
function quitAppOfWindow(window)
    if window then
        window:application():kill()
    end
end

-- Create the chooser
-- windowChooser = hs.chooser.new(function(choice)
-- 	print(hs.inspect(choice))
--   choice["windowObj"]:close()
-- end)
--
-- -- Set the choices
-- windowChooser:choices(getVisibleWindows)

-- Handle keydown event for the chooser
-- windowChooser:keydown(function(chooser, event)
--     local choice = chooser:selectedRowContents()
--     if event:getCharacters() == "w" and event:getFlags().cmd then
--         closeWindow(choice.windowObj)
--         chooser:refreshChoicesCallback() -- Refresh the list of windows
--     elseif event:getCharacters() == "q" and event:getFlags().cmd then
--         quitAppOfWindow(choice.windowObj)
--         chooser:refreshChoicesCallback() -- Refresh the list of windows
--     end
-- end)
--
-- -- Show the window chooser
-- hs.hotkey.bind({"cmd"}, "E", function() windowChooser:show() end)
--
-- Function to refresh the chooser's choices and show it again
function refreshAndShowChooser()
    hs.timer.doAfter(0.1, function() -- Add a slight delay
        windowChooser:show()
    end)
end

-- Create the chooser
windowChooser = hs.chooser.new(function(choice)
    -- Check if the cmd key is held down at the time of selection
    local mods = hs.eventtap.checkKeyboardModifiers()
    if mods.alt then
		print'working'
        -- cmd is held, perform an alternative action
				choice["windowObj"]:application():kill()
    end
    
    -- Example of refreshing and showing the chooser again, if needed
  choice["windowObj"]:close()
        windowChooser:show()
    windowChooser:choices(getVisibleWindows()) -- Refresh choices

    -- After performing the action, refresh and show the chooser again
    -- Note: Depending on the action, you might want to add a delay here as well
    -- refreshAndShowChooser()
end):choices(getVisibleWindows())

-- Function to show the window chooser directly, without refreshing
function showWindowChooser()
    windowChooser:choices(getVisibleWindows()) -- Refresh choices
    windowChooser:show()
end

-- Bind the hotkey to show the window chooser
-- hs.hotkey.bind({"cmd"}, "E", showWindowChooser)
