local log = hs.logger.new(getCurrentFileName(), "debug")
require("helpers")
local timer = require("hs.timer")

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

local function focus_last_window_or_launch(app_bundle_id)
	-- no('frontmost app name ' .. hs.application.frontmostApplication():name())
	-- .find does pattern (or literal if 3rd arg is true) matching on:
	-- 1. application name
	-- 2. window title
	-- 3. bundle id
	-- 4. process id
	-- second arg is whether the full variable must match or just part
	-- (string.find). We want the full one to match.
	-- third arg whether to interpret string literally (true) or as a
	-- pattern (false)
	local app = hs.application.find(app_bundle_id, true, true)
	if type(app) == "table" then
		no("warning: found multiple apps for " .. app_bundle_id .. ", using first")
		app = app[1]
	end
	app:activate()
	-- local win = app:focusedWindow()
	-- win:unminimize()
	-- timer.doAfter(0.001,function()win:focus()end)
	-- win:focus()
	-- app:activate()
	-- hs.timer.doAfter(0.001, function ()
	-- 	win:focus()
	-- end)
	-- win:becomeMain()
	-- win:focus()
	-- app:activate()
	-- return
	-- print('hs.application.runningApplications()', hs.inspect(hs.application.runningApplications()))
	-- print('printing', app_name, hs.inspect(app))
	-- print('app:allWindows()', hs.inspect(app:allWindows()))

	-- local win
	-- if app then
	-- 	no('found app for ' .. app_name)
	-- 	win = app:focusedWindow()
	-- 	if win then
	-- 		no('found focused win for ' .. app_name .. ', focusing')
	-- 		win:focus()
	-- 	else
	-- 		no('didnt find focused win for ' .. app_name ..', will try main win')
	-- 		win = app:mainWindow()
	-- 		if win then
	-- 			no('found main win for ' .. app_name .. ', focusing')
	-- 			win:focus()
	-- 		else
	-- 			no('didnt find win for ' .. app_name .. ', will launch')
	-- 			hs.application.launchOrFocus(app_name)
	-- 		end
	-- 	end
	-- end

	-- else
	-- 	no('didnt find app')
	-- end
	-- for i, v in ipairs(hs.application.find("logseq"):allWindows()) do
	-- 	print(i, v)
	-- end
end

hs.urlevent.bind('escape', function()
	-- no'hel'
	local wf = hs.window.filter.new()
	local wins = wf:getWindows(hs.window.filter.sortByFocusedLast)
	local frontApp = hs.application.frontmostApplication()
	for _, win in ipairs(wins) do
		if win:application() ~= frontApp then
			win:focus()
			return
		end
	end

end)

-- Define the remapping function
-- hs.hotkey.bind({}, "escape", function()
-- 	no'hel'
-- 	local wf = hs.window.filter.new()
-- 	local wins = wf:getWindows(hs.window.filter.sortByFocusedLast)
-- 	local frontApp = hs.application.frontmostApplication()
-- 	for _, win in ipairs(wins) do
-- 		if win:application() ~= frontApp then
-- 			win:focus()
-- 			return
-- 		end
-- 	end
-- end)

local function focus_non_fav_window(idx)
	local wf = hs.window.filter.new()
	local wins = wf:getWindows(hs.window.filter.sortByFocusedLast)
	local excludedApps = {
		["com.ableton.live"] = true,
		["com.apple.finder"] = true,
		["com.apple.iCal"] = true,
		["com.apple.mail"] = true,
		["com.apple.ActivityMonitor"] = true,
		["com.apple.notificationcenterui"] = true,
		["com.atomixproductions.virtualdj"] = true,
		["com.electron.logseq"] = true,
		["com.github.th-ch.youtube-music"] = true,
		["com.google.Chrome"] = true,
		["com.microsoft.VSCode"] = true,
		["com.serato.seratodj"] = true,
		["com.spotify.client"] = true,
		["com.tdesktop.Telegram"] = true,
		["com.tinyspeck.slackmacgap"] = true,
		["com.vivaldi.Vivaldi"] = true,
		["company.thebrowser.Browser"] = true,
		["info.sioyek.sioyek"] = true, 
		["net.kovidgoyal.kitty"] = true,
		["notion.id"] = true,
		["org.hammerspoon.Hammerspoon"] = true,
		["org.videolan.vlc"] = true,
	}
	-- no'running'
	local current_app = hs.application.frontmostApplication():bundleID()
	print('current', current_app)
	-- print('current', current_app)
	excludedApps[current_app] = true

	for _, win in ipairs(wins) do
		local appName = win:application():bundleID()
		if not excludedApps[appName] then
			-- no('window ' .. win:title() .. ' in app ' .. appName .. ' is not excluded, will focus')
			if idx == 1 then
				win:focus()
				return
			else
				idx = idx - 1
			end
		end
	end

	return nil -- Return nil if no matching window is found
end


hs.hotkey.bind(S, "escape", function()
	focus_non_fav_window(1)
end)

hs.hotkey.bind(C, "escape", function()
	focus_non_fav_window(2)
end)

hs.hotkey.bind(CS, "escape", function()
	focus_non_fav_window(3)
end)

hs.hotkey.bind({"cmd"}, "f1", function()
	focus_last_window_or_launch("com.vivaldi.Vivaldi")
end)
hs.hotkey.bind({"cmd"}, "f2", function()
	focus_last_window_or_launch("com.google.Chrome")
end)
hs.hotkey.bind({}, "f3", function()
	focus_last_window_or_launch("net.kovidgoyal.kitty")
end)
hs.hotkey.bind({}, "f4", function()
	focus_last_window_or_launch("com.tinyspeck.slackmacgap")
end)
-- hs.hotkey.bind({}, "f5", function()
-- 	focus_last_window_or_launch("")
-- end)
hs.hotkey.bind({}, "f5", function()
	focus_last_window_or_launch("com.spotify.client")
end)
hs.hotkey.bind({}, "f6", function()
	focus_last_window_or_launch("com.tdesktop.Telegram")
end)
hs.hotkey.bind({}, "f7", function()
	-- focus_last_window_or_launch("Twitter")
end)
hs.hotkey.bind({}, "f8", function()
	-- focus_last_window_or_launch("Discord")
end)
hs.hotkey.bind({}, "f9", function()
	focus_last_window_or_launch("com.electron.logseq")
end)

hs.hotkey.bind({ }, "f2", function()
	focus_last_window_or_launch("com.electron.logseq")
end)

-- hs.hotkey.bind({ "cmd" }, "f3", openKittyWindow)
hs.hotkey.bind({ "cmd" }, "f3", function()
	focus_last_window_or_launch("com.microsoft.VSCode")
end)

-- hs.hotkey.bind({ "cmd" }, "f1", openVivaldiTab)
-- hs.hotkey.bind({ "cmd" }, "f1", function() 
hs.hotkey.bind({ }, "f1", function()
	focus_last_window_or_launch("company.thebrowser.Browser")
end)

hs.hotkey.bind({ "cmd" }, "f5", function()
	hs.reload()
end)
hs.hotkey.bind({ "cmd" }, "f6", function()
	focus_last_window_or_launch("com.github.th-ch.youtube-music")
end)
hs.hotkey.bind({ "cmd" }, "f7", function()
	focus_last_window_or_launch("Visual Studio Code")
end)
hs.hotkey.bind({ "cmd" }, "f8", function()
	focus_last_window_or_launch("com.apple.iCal")
end)
hs.hotkey.bind({ "cmd" }, "f9", function()
	focus_last_window_or_launch("notion.id")
end)
hs.hotkey.bind({ "shift" }, "f1", function()
	focus_last_window_or_launch("info.sioyek.sioyek")
end)
hs.hotkey.bind({ "shift" }, "f2", function()
	focus_last_window_or_launch("com.atomixproductions.virtualdj")
end)
hs.hotkey.bind({ "shift" }, "f3", function()
	focus_last_window_or_launch("com.ableton.live")
end)
hs.hotkey.bind({ "shift" }, "f4", function()
	focus_last_window_or_launch("com.eltima.Folx3")
end)
hs.hotkey.bind({ "shift" }, "f5", function()
	focus_last_window_or_launch("com.apple.mail")
end)
hs.hotkey.bind({ "shift" }, "f6", function()
	focus_last_window_or_launch("com.apple.iCal")
end)
hs.hotkey.bind({ "ctrl" }, "f1", function()
	focus_last_window_or_launch("org.videolan.vlc")
end)
hs.hotkey.bind({ "shift" }, "f10", function()
	focus_last_window_or_launch("com.kapeli.dashdoc")
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


hs.hotkey.bind({ "cmd" }, "f8", function()
	local app = hs.application.find('YouTube Music')
	app:activate()
	hs.eventtap.event.newKeyEvent('space', true):post()
	hs.eventtap.event.newKeyEvent('space', false):post()
	-- hs.eventtap.event.newSystemKeyEvent('PLAY', true):post()
	-- hs.eventtap.event.newSystemKeyEvent('PLAY', false):post()
end)
