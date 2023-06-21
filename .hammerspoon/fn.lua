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
	local app = hs.application.find(app_name)
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


hs.hotkey.bind({}, "f2", function()
	focus_last_window_or_launch("brave browser")
end)
hs.hotkey.bind({}, "f3", function()
	focus_last_window_or_launch("Kitty")
end)
hs.hotkey.bind({}, "f1", function()
	focus_last_window_or_launch("vivaldi")
end)
hs.hotkey.bind({}, "f4", function()
	focus_last_window_or_launch("slack")
end)
hs.hotkey.bind({}, "f5", function()
	focus_last_window_or_launch("Hammerspoon")
end)
hs.hotkey.bind({}, "f6", function()
	focus_last_window_or_launch("spotify")
end)
hs.hotkey.bind({}, "f7", function()
	focus_last_window_or_launch("telegram desktop")
end)
hs.hotkey.bind({}, "f8", function()
	focus_last_window_or_launch("twitter")
end)
hs.hotkey.bind({}, "f9", function()
	focus_last_window_or_launch("discord")
end)
hs.hotkey.bind({}, "f10", function()
	focus_last_window_or_launch("logseq")
end)

hs.hotkey.bind({ "cmd" }, "f2", function()
	focus_last_window_or_launch("logseq")
end)

hs.hotkey.bind({ "cmd" }, "f3", openKittyWindow)

hs.hotkey.bind({ "cmd" }, "f1", openVivaldiTab)

hs.hotkey.bind({ "cmd" }, "f5", function()
	hs.reload()
end)
hs.hotkey.bind({ "cmd" }, "f6", function()
	focus_last_window_or_launch("mail")
end)
hs.hotkey.bind({ "cmd" }, "f7", function()
	focus_last_window_or_launch("visual studio code")
end)
hs.hotkey.bind({ "cmd" }, "f8", function()
	focus_last_window_or_launch("calendar")
end)
hs.hotkey.bind({ "cmd" }, "f9", function()
	focus_last_window_or_launch("notion")
end)
hs.hotkey.bind({ "cmd" }, "f10", function()
	focus_last_window_or_launch("dash")
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
