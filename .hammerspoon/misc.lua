-- hs.hotkey.bind({'ctrl'}, 'left', function() hs.eventtap.keyStroke({}, 'f18') end)

-- stickies
-- hs.hotkey.bind({ "cmd", "shift" }, "s", function()
--     hs.alert.show("Setting up Sticky...")
--     local win = hs.window.focusedWindow()
--     local frame = win:frame()
--     local screen = win:screen()
--     local max = screen:frame()
--     local height = 250
--     local width = 300
--     frame.x = max.w - width
--     frame.y = max.h - height
--     frame.w = width
--     frame.h = height
--     win:setFrame(frame)
--     hs.eventtap.keyStroke({ "alt" }, "tab")
--     hs.eventtap.keyStroke({ "cmd" }, "a")
--     hs.eventtap.keyStroke({ "cmd" }, "=")
--     hs.eventtap.keyStroke({ "cmd" }, "=")
--     hs.eventtap.keyStroke({ "cmd" }, "=")
--     hs.eventtap.keyStroke({ "cmd" }, "=")
--     hs.eventtap.keyStroke({ "cmd" }, "=")
--     hs.eventtap.keyStroke({ "cmd" }, "=")
--     hs.eventtap.keyStroke({}, "right")
--     hs.eventtap.keyStroke({}, "left")
-- end)

-- function inputDoubleQuote()
--     hs.eventtap.keyStroke({"shift"}, "'")
-- end

-- function inputSingleQuote()
--     hs.eventtap.keyStroke({}, "'")
-- end

-- hs.hotkey.bind({}, "'", inputDoubleQuote)
-- hs.hotkey.bind({'shift'}, "'", inputSingleQuote)

-- hs.hotkey.bind(C, '`', function()
--     local win = hs.window.focusedWindow()
--     if win:application():name() == "Vivaldi" then
--         hs.alert('viv')
--         hs.eventtap.keyStroke(CS, 'tab')
--     else
--         hs.alert('notviv')
--         hs.eventtap.keyStroke(C, '`')
--     end
-- end)reloadFxFromRubyMine = hs.hotkey.new('⌘', 'r', function()
--       hs.application.launchOrFocus("Firefox.app")
--       reloadFxFromRubyMine:disable() -- does not work without this, even though it should
--       hs.eventtap.keyStroke({"⌘"}, "r")
--   end)

local goLeftTab = hs.hotkey.new(C, '`', function()
    hs.eventtap.keyStroke(CS, 'tab')
end)

hs.window.filter.new('Vivaldi')
    :subscribe(hs.window.filter.windowFocused, function() goLeftTab:enable() end)
    :subscribe(hs.window.filter.windowUnfocused, function() goLeftTab:disable() end)
