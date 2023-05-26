local log = hs.logger.new(getCurrentFileName(), 'debug')

function openLogseqSearch()
    -- hs.application.launchOrFocus('logseq')
    hs.application.launchOrFocus('logseq')
    logseq=hs.application.find('Logseq')
    --hs.timer.doAfter(1, function()
    --    hs.alert.show('hi')
    hs.eventtap.keystroke({'cmd'}, 'k', logseq)
    --end)
end

function openKittyWindow()
    hs.notify.show("Hammerspoon", "", "Launching Kitty")
    for file in hs.fs.dir('/tmp') do
        if startswith(file, 'mykitty') then
            print(file)
            -- helpers.lua:        return file:match("[^/]*.lua$")
            local cmd = '/opt/homebrew/bin/kitty @ --to unix:/tmp/' .. file .. ' launch --type=os-window'
            print(cmd)
            hs.execute(cmd)
        end
    end
    print(res)
end
-- applescript to open new tab in chrome
newTabVivaldi = [[
    tell application "Vivaldi"
        activate
        tell window 1
            set newTab to make new tab
            set active tab index to (index of newTab)
        end tell
    end tell
]]

function openVivaldiTab()
    -- hs.osascript.applescript(newTabVivaldi)
    log.i('hi')
    hs.application.launchOrFocus('vivaldi')
    -- vivaldi=hs.application.find('vivaldi')
    -- hs.eventtap.keyStroke({'cmd'}, 't', vivaldi)
    hs.eventtap.keyStroke({'cmd'}, 't')
end

function openZk()
    print('running')
    hs.application.launchOrFocus'kitty'
    hs.execute("kitty @ focus-window -m 'title:fn.lua'")
    print('run')
    -- apps = {hs.application.find'kitty'}
    -- for _, app in ipairs(apps) do
    --     print(app:name())
    --     if string.find(app:name(), 'fn.lua') then
    --     print('found')
    --     hs.application.launchOrFocus(app)
    --     end
    -- end
end

hs.hotkey.bind({}, 'f2', function() hs.application.launchOrFocus('logseq') end)

hs.hotkey.bind({}, 'f1', function() hs.application.launchOrFocus("Kitty") end)

hs.hotkey.bind({}, 'f3', function() hs.application.launchOrFocus('vivaldi') end)
hs.hotkey.bind({}, 'f4', function() hs.application.launchOrFocus('slack') end)
hs.hotkey.bind({}, 'f5', function() hs.application.launchOrFocus('Hammerspoon') end)
hs.hotkey.bind({}, 'f6', function() hs.application.launchOrFocus('spotify') end)
hs.hotkey.bind({}, 'f7', function() hs.application.launchOrFocus('telegram desktop') end)
hs.hotkey.bind({}, 'f8', function() hs.application.launchOrFocus('twitter') end)
hs.hotkey.bind({}, 'f9', function() hs.application.launchOrFocus('discord') end)
hs.hotkey.bind({}, 'f10', openZk)


hs.hotkey.bind({'cmd'}, 'f2', openLogseqSearch)

hs.hotkey.bind({'cmd'}, "f1", openKittyWindow)

hs.hotkey.bind({'cmd'}, 'f3', openVivaldiTab)

hs.hotkey.bind({'cmd'}, 'f5', function() hs.reload() end)

hs.hotkey.bind({}, 'f17', function() hs.eventtap.keyStrokes('./') end)

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

