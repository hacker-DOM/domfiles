local log = hs.logger.new(getCurrentFileName(), "debug")

local function openLogseqSearch()
	-- hs.application.launchOrFocus('logseq')
	hs.application.launchOrFocus("logseq")
	logseq = hs.application.find("Logseq")
	--hs.timer.doAfter(1, function()
	--    hs.alert.show('hi')
	hs.eventtap.keystroke({ "cmd" }, "k", logseq)
	--end)
end

local function openKittyWindow()
	hs.notify.show("Hammerspoon", "", "Launching Kitty")
	for file in hs.fs.dir("/tmp") do
		if startswith(file, "mykitty") then
			print(file)
			-- helpers.lua:        return file:match("[^/]*.lua$")
			local cmd = "/opt/homebrew/bin/kitty @ --to unix:/tmp/" .. file .. " launch --type=os-window"
			print(cmd)
			hs.execute(cmd)
		end
	end
	print(res)
end
-- applescript to open new tab in chrome
local newTabVivaldi = [[
    tell application "Vivaldi"
        activate
        tell window 1
            set newTab to make new tab
            set active tab index to (index of newTab)
        end tell
    end tell
]]

local function openVivaldiTab()
	-- hs.osascript.applescript(newTabVivaldi)
	log.i("hi")
	hs.application.launchOrFocus("vivaldi")
	-- vivaldi=hs.application.find('vivaldi')
	-- hs.eventtap.keyStroke({'cmd'}, 't', vivaldi)
	hs.eventtap.keyStroke({ "cmd" }, "t")
end

local function openZk()
	print("running")
	hs.application.launchOrFocus("kitty")
	hs.execute("kitty @ focus-window -m 'title:fn.lua'")
	print("run")
	-- apps = {hs.application.find'kitty'}
	-- for _, app in ipairs(apps) do
	--     print(app:name())
	--     if string.find(app:name(), 'fn.lua') then
	--     print('found')
	--     hs.application.launchOrFocus(app)
	--     end
	-- end
end

local function focus_last_window_or_launch(app_name)
	-- .find does pattern (or literal if 3rd arg is true) matching on:
	-- 1. application name
	-- 2. window title
	-- 3. bundle id
	-- 4. process id
	-- second arg is whether the full variable must match or just part
	-- (string.find). We want the full one to match.
	local app = hs.application.find(app_name, true)
	-- print('hs.application.runningApplications()', hs.inspect(hs.application.runningApplications()))
	-- print('printing', app_name, hs.inspect(app))
	-- print('app:allWindows()', hs.inspect(app:allWindows()))
	local win
	if app then
		win = app:focusedWindow() or app:mainWindow()
	end
	if win then
		win:focus()
	else
		hs.application.launchOrFocus(app_name)
	end
	-- for i, v in ipairs(hs.application.find("logseq"):allWindows()) do
	-- 	print(i, v)
	-- end
end

-- Define the remapping function

hs.hotkey.bind({}, "f2", function()
	focus_last_window_or_launch("Brave Browser")
end)
hs.hotkey.bind({}, "f3", function()
	focus_last_window_or_launch("Kitty")
end)
hs.hotkey.bind({}, "f1", function()
	focus_last_window_or_launch("Vivaldi")
end)
hs.hotkey.bind({}, "f4", function()
	focus_last_window_or_launch("Slack")
end)
hs.hotkey.bind({}, "f5", function()
	focus_last_window_or_launch("Hammerspoon")
end)
hs.hotkey.bind({}, "f6", function()
	focus_last_window_or_launch("Spotify")
end)
hs.hotkey.bind({}, "f7", function()
	focus_last_window_or_launch("Telegram Desktop")
end)
hs.hotkey.bind({}, "f8", function()
	focus_last_window_or_launch("Twitter")
end)
hs.hotkey.bind({}, "f9", function()
	focus_last_window_or_launch("Discord")
end)
hs.hotkey.bind({}, "f10", function()
	focus_last_window_or_launch("Logseq")
end)

hs.hotkey.bind({ "cmd" }, "f2", function()
	focus_last_window_or_launch("Logseq")
end)

hs.hotkey.bind({ "cmd" }, "f3", openKittyWindow)

hs.hotkey.bind({ "cmd" }, "f1", openVivaldiTab)

hs.hotkey.bind({ "cmd" }, "f5", function()
	hs.reload()
end)
hs.hotkey.bind({ "cmd" }, "f6", function()
	focus_last_window_or_launch("Mail")
end)
hs.hotkey.bind({ "cmd" }, "f7", function()
	focus_last_window_or_launch("Visual Studio Code")
end)
hs.hotkey.bind({ "cmd" }, "f8", function()
	focus_last_window_or_launch("Calendar")
end)
hs.hotkey.bind({ "cmd" }, "f9", function()
	focus_last_window_or_launch("Notion")
end)
hs.hotkey.bind({ "cmd" }, "f10", function()
	focus_last_window_or_launch("Dash")
end)

-- 11 12 are volume
-- 13... is DomOS

hs.hotkey.bind({}, "f17", function()
	hs.eventtap.keyStrokes("./")
end)

-- local function goToSpaceWithOffset(offs)
--     hs.alert.show('bar')
--     -- screen focused window is on
--     -- local scr = hs.screen.mainScreen()
--     local sp = hs.spaces.focusedSpace()
--     -- there isn't a focused activeSpaceOnMainScreen(),
--     -- so we have to do a workaround :-()
--     -- spaces on screen focused window is on
--     local sps = hs.spaces.allSpaces()[hs.screen.mainScreen():getUUID()]

--     hs.spaces.gotoSpace(getElWithOffset(sps, sp, offs))
-- end

-- hs.hotkey.bind({}, 'f18', function() hs.alert.show('foo'); goToSpaceWithOffset(-1) end)

-- hs.hotkey.bind({}, 'f19', function() hs.eventtap.keyStroke({'ctrl'}, 'right') end)

-- hs.hotkey.bind({}, "f4", function()
--     hs.notify.show("Hammerspoon", "", "Launching Code")
--     res = hs.execute("code --new-window", true)
--     print(res)
-- end)
local function remapAltFxToFx(x)
	print("remapping F" .. x .. " to alt-F" .. x)
	--    hs.hotkey.bind({"alt"}, "F" .. x, function()
	-- hs.notify.show("Hammerspoon", "", "Sending F" .. x)
	--        hs.eventtap.keyStroke({}, "f" .. x)
	--    end)

	hs.hotkey.bind({ "alt" }, "F" .. x, function()
		-- Release the Alt key immediately
		-- hs.eventtap.event.newKeyEvent("alt", false):post()
		-- Introduce a slight delay before sending the Fx keystroke
		-- hs.timer.doAfter(0.01, function()
			hs.notify.show("Hammerspoon", "", "Sending F" .. x)

			hs.eventtap.keyStroke({}, "F" .. x)
		-- end)
	end, nil, nil)
end

-- Loop over the range 1 to 12 and create the hotkey bindings
for i = 1, 12 do
	remapAltFxToFx(i)
end
