-- inspired by https://github.com/jasonrudolph/keyboard

local log = hs.logger.new('init.lua', 'debug')
hs.ipc.cliInstall()
require 'helpers'
require 'misc'
require 'fn'
require 'dom-wm'
require 'dom-which-key'
--- Load the Seal plugin
hs.loadSpoon("Seal")
require 'close-wins'
require 'scratch'

-- Initialize and start Seal
spoon.Seal:loadPlugins({"apps", "calc", "useractions", "screencapture", "pasteboard"})
spoon.Seal:start()

-- Optional: Set a hotkey to toggle the Seal interface
-- hs.hotkey.bind({"cmd"}, "Space", function()
--     spoon.Seal:toggle()
-- end)
require 'window_switcher'

-- maximize window
-- hs.hotkey.bind({ "ctrl", "shift" }, "i", function()
--     hs.notify.show("Hammespoon", "", "Maximizing window...")
--     local win = hs.window.focusedWindow()
--     win:maximize()
-- end)

-- emoji picker
hs.hotkey.bind({ "alt" }, "space", function()
    hs.eventtap.keyStroke({ "ctrl", "cmd" }, "space")
end)

local hyper2 = { "ctrl", "alt", "shift", "cmd" }

-- hotkey only when chrome is focused
-- hs.hotkey.bind({ "ctrl", "cmd" }, "t", function()
--     local win = hs.window.focusedWindow()
--     if win:application():name() == "Vivaldi" then
--         hs.notify.show("Hammerspoon", "", "Sending hyper2 t")
--         hs.eventtap.keyStroke(hyper2, "t")
--     end
-- end)

-- require 'ctrl-alt'

hs.notify.show("Hammerspoon", "", "~/.hammerspoon/init.lua reloaded")
