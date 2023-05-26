-- Modal window manager

-- Activate with Cmd+M
local wm = hs.hotkey.modal.new(M, "m")

-- Deactivate with <esc>
wm:bind({}, "escape", function()
	wm:exit()
end)

-- Also deactivate with Cmd+M
wm:bind(M, "m", function()
	wm:exit()
end)

-- hs.window.setFrameCorrectness = true

-- changeFrame
local function chFr(field, delta, win, app)
	print(win)
	if app then
		win = hs.application.get(app):mainWindow()
		print(hs.application.get(app))
		print(win)
	else
		win = win or hs.window.focusedWindow()
	end
	local fr = win:frame()
	fr[field] = fr[field] + delta
	win:setFrame(fr)
end

local function chFrs(fields, deltas, win, app)
	for i, field in ipairs(fields) do
		chFr(field, deltas[i], win, app)
	end
end

local function setFr(field, val, win, app)
	print(app)
	if app then
		win = hs.application.get(app):mainWindow()
		print(win)
	else
		win = win or hs.window.focusedWindow()
	end
	local fr = win:frame()
	if field == "x" or field == "y" then
		fr[field] = val
	elseif field == "-x" then
		local scr = hs.screen.mainScreen()
		local scrFr = scr:frame()
		fr["x"] = scrFr["w"] - fr["w"]
	elseif field == "-y" then
		local scr = hs.screen.mainScreen()
		local scrFr = scr:frame()
		fr["y"] = scrFr["h"] - fr["h"]
	end
	win:setFrame(fr)
end

local function extFr(field, win, app)
	if app then
		win = hs.application.get(app):mainWindow()
	else
		win = win or hs.window.focusedWindow()
	end
	local fr = win:frame()
	local scrFr = hs.screen.mainScreen():frame()
	if field == "x" then
		print("extending left")
		-- extend to left
		-- width is extended by x
		fr["w"] = fr["w"] + fr["x"]
		fr["x"] = 0
	elseif field == "y" then
		print("extending up")
		-- extend up
		-- height is extended by y
		fr["h"] = fr["h"] + fr["y"]
		fr["y"] = 0
	elseif field == "w" then
		print("extending right")
		-- extend to right
		-- width is extended by (scrFr[w] - fr[x] - fr[w])
		-- scr['w'] = scr['w'] + (scrFr['w'] - fr['x'] - fr['w']), so
		fr["w"] = fr["w"] + scrFr["w"] - fr["x"] - fr["w"]
	elseif field == "h" then
		print("extending down")
		-- extend down
		-- height is extended by (scrFr[h] - fr[y] - fr[h])
		fr["h"] = fr["h"] + scrFr["h"] - fr["y"] - fr["h"]
	end
	win:setFrame(fr)
end

-- examples:
-- -- screen of focused window
-- hs.spaces.activeSpaces()
-- { ["19440EC3-57A8-E480-0857-D6964E3302DB"] = 114 }
--
-- hs.spaces.allSpaces()
-- { ["19440EC3-57A8-E480-0857-D6964E3302DB"] = { 3, 114, 1, 4 } }
--
-- -- current screen
-- hs.screen.mainScreen()
-- hs.screen: LG TV SSCR2 (0x6000020af378)
--
-- hs.screen.mainScreen():id()
-- 2
--
-- hs.screen.mainScreen():getUUID()
-- 19440EC3-57A8-E480-0857-D6964E3302DB

-- a simple wrapper
local function moveWindowToSpace(win, spId)
	hs.spaces.moveWindowToSpace(win, spId)
	local goToSpace = hs.spaces.gotoSpace(spId)
	if goToSpace then
		hs.spaces.closeMissionControl()
	end
end

local function moveToSpaceWithOffset(offs, app)
	return function()
		local win
		if app then
			win = hs.application.get(app):mainWindow()
		else
			win = hs.window.focusedWindow()
		end
		local win = hs.window.focusedWindow()
		-- screen focused window is on
		-- local scr = hs.screen.mainScreen()
		local sp = hs.spaces.focusedSpace()
		-- there isn't a focused activeSpaceOnMainScreen(),
		-- so we have to do a workaround :-()
		-- spaces on screen focused window is on
		local sps = hs.spaces.allSpaces()[hs.screen.mainScreen():getUUID()]

		moveWindowToSpace(win, getElWithOffset(sps, sp, offs))
	end
end

local STEP = 25

-- m j k comma
local mthw = { "m", "t", "h", "w" }
local mjkc = { "m", "j", "k", "," }

local lr = { "left", "right" }

local APP = "Notes"

-- todo
-- leave space for stage manager
-- move to halves
-- bigger & alternative smaller

local MARGIN_LEFT = 60
local MARGIN_DOWN = 0 -- around 25 offset
local MARGIN_UP = 50 -- around 25 offset
local MARGIN_RIGHT = 25
local MARGIN_BETWEEN = 15

local MARGINS_MAX = {
	left = MARGIN_LEFT,
	down = MARGIN_DOWN,
	up = MARGIN_UP,
	right = MARGIN_RIGHT,
}

local MARGINS_HOR_UP = {
	left = MARGIN_LEFT,
	down = MARGIN_BETWEEN / 2,
	up = MARGIN_UP,
	right = MARGIN_RIGHT,
}

local MARGINS_HOR_DOWN = {
	left = MARGIN_LEFT,
	down = MARGIN_DOWN,
	up = MARGIN_BETWEEN / 2,
	right = MARGIN_RIGHT,
}

local MARGINS_VERT_LEFT = {
	left = MARGIN_LEFT,
	down = MARGIN_DOWN,
	up = MARGIN_UP,
	right = MARGIN_BETWEEN / 2,
}

local MARGINS_VERT_RIGHT = {
	left = MARGIN_BETWEEN / 2,
	down = MARGIN_DOWN,
	up = MARGIN_UP,
	right = MARGIN_RIGHT,
}

local shs = {
	center = "a",
	hor = "s",
	vert = "d",
	max = "f",
}

local maps = {
	move = { {}, mthw },
	moveToSides = { S, mthw },
	-- extendToSides = { { nil }, mjkc },
	bigger = { M, mjkc },
	smaller = { SM, mjkc },
	moveApp = { C, mjkc },
	moveAppToSides = { CS, mjkc },
	moveToSpace = { {}, lr },
	biggerSmaller = { CM, mjkc },
	smallerBigger = { CSM, mjkc },
	shortcuts = { {}, shs },
}

function print_mod(mod_arr)
	if #mod_arr > 0 then
		local res = ""
		for i, mod in ipairs(mod_arr) do
			res = res .. mod .. "+"
		end
		return res
	else
		return ""
	end
end

local domwmAlert = nil
function wm:entered()
	-- hs.dialog.alert(100, 100, nil, "foo", "info")
	local help = string.format(
		"Dom Window Manager activated!\nMove: %s%s\nMoveToSides: %s%s\nExtendToSides: %s%s\nBigger: %s%s\nSmaller: %s%s\nMoveApp: %s%s\nMoveAppToSides: %s%s\nMoveToSpace: %s%s\nBiggerSmaller: %s%s\nSmallerBigger: %s%s\nShortcuts: %s%s",
		print_mod(maps.move[1]),
		table.concat(maps.move[2]),
		print_mod(maps.moveToSides[1]),
		table.concat(maps.moveToSides[2]),
		-- print_mod(maps.extendToSides[1]),
		'a','b',
		-- table.concat(maps.extendToSides[2]),
		print_mod(maps.bigger[1]),
		table.concat(maps.bigger[2]),
		print_mod(maps.smaller[1]),
		table.concat(maps.smaller[2]),
		print_mod(maps.moveApp[1]),
		table.concat(maps.moveApp[2]),
		print_mod(maps.moveAppToSides[1]),
		table.concat(maps.moveAppToSides[2]),
		print_mod(maps.moveToSpace[1]),
		table.concat(maps.moveToSpace[2]),
		print_mod(maps.biggerSmaller[1]),
		table.concat(maps.biggerSmaller[2]),
		print_mod(maps.smallerBigger[1]),
		table.concat(maps.smallerBigger[2]),
		print_mod(maps.shortcuts[1]),
		table.concat(maps.shortcuts[2])
	)
	domwmAlert = hs.alert.show(help, "info")
end
function wm:exited()
	hs.alert.closeSpecific(domwmAlert)
end

local function moveL(win, app)
	return function()
		chFr("x", -STEP, win, app)
	end
end
local function moveD(win, app)
	return function()
		chFr("y", STEP, win, app)
	end
end
local function moveU(win, app)
	return function()
		chFr("y", -STEP, win, app)
	end
end
local function moveR(win, app)
	return function()
		chFr("x", STEP, win, app)
	end
end

local function moveToSidesL(win, app)
	return function()
		setFr("x", 0, win, app)
	end
end
local function moveToSidesD(win, app)
	return function()
		setFr("-y", 0, win, app)
	end
end
local function moveToSidesU(win, app)
	return function()
		setFr("y", 0, win, app)
	end
end
local function moveToSidesR(win, app)
	return function()
		setFr("-x", 1, win, app)
	end
end

local function biggerL(app)
	return function()
		no("biggerL")
		chFrs({ "w", "x" }, { STEP, -STEP }, app)
	end
end
local function biggerD(app)
	return function()
		chFr("h", STEP, app)
	end
end
local function biggerU(app)
	return function()
		chFrs({ "h", "y" }, { STEP, -STEP }, app)
	end
end
local function biggerR(app)
	return function()
		chFr("w", STEP, app)
	end
end

local function smallerL(app)
	return function()
		chFr("w", -STEP, app)
	end
end
local function smallerD(app)
	return function()
		chFrs({ "h", "y" }, { -STEP, STEP }, app)
	end
end
local function smallerU(app)
	return function()
		chFr("h", -STEP, app)
	end
end
local function smallerR(app)
	return function()
		chFrs({ "w", "x" }, { -STEP, STEP }, app)
	end
end

local function extendToSidesL(app)
	return function()
		extFr("x", app)
	end
end
local function extendToSidesD(app)
	return function()
		extFr("h", app)
	end
end
local function extendToSidesU(app)
	return function()
		extFr("y", app)
	end
end
local function extendToSidesR(app)
	return function()
		extFr("w", app)
	end
end

local function getOther()
	local win = hs.window.focusedWindow()
	local wins = hs.window.orderedWindows()
	local win_ = getElWithOffset(wins, win, 1)
	return win_
end
local function bS(main, other) -- biggerL, smallerL
	return function()
		main()()
		local win_ = getOther()
		other(win_)()
	end
end

local SCALE = 0.75

local HOR_SCALE = SCALE
local VERT_SCALE = SCALE

local function center(horScale, vertScale)
	return function()
		local win = hs.window.focusedWindow()
		local fr = win:frame()
		local scrFr = hs.screen.mainScreen():frame()
		-- x = scrFr[w] / 2 - scale * scrFr[w] / 2
		fr["x"] = (1 - horScale) * (scrFr["w"] / 2)
		fr["w"] = horScale * scrFr["w"]
		fr["y"] = (1 - vertScale) * (scrFr["h"] / 2)
		fr["h"] = vertScale * scrFr["h"]
		win:setFrame(fr)
	end
end

local function hor(marginsUp, marginsDown)
	return function()
		local win = hs.window.focusedWindow()
		local fr = win:frame()
		local win_ = getOther()
		local fr_ = win_:frame()

		win:setFrame(fr)
		win_:setFrame(fr_)
	end
end

local function vert(marginsLeft, marginsRight)
	return function()
		local win = hs.window.focusedWindow()
		local fr = win:frame()
		local win_ = getOther()
		local fr_ = win_:frame()
		local scrFr = hs.screen.mainScreen():frame()
		fr["x"] = marginsLeft.left
		-- sum of both windows' widths
		local totalW = scrFr["w"] - marginsLeft.left - marginsLeft.right - marginsRight.left - marginsRight.right
		print("marginsLeft", hs.inspect(marginsLeft))
		print("marginsRight", hs.inspect(marginsRight))
		print("scrFr", hs.inspect(scrFr))
		print(totalW)
		-- fr['w'] = scrFr['w'] / 2 - marginsLeft.left - marginsLeft.right
		fr["w"] = totalW / 2
		fr["y"] = marginsLeft.up
		fr["h"] = scrFr["h"] - marginsLeft.up - marginsLeft.down
		-- fr_['x'] = scrFr['w'] / 2 + marginsRight.left
		fr_["x"] = scrFr["w"] - marginsRight.right - totalW / 2
		-- fr_['w'] = scrFr['w'] / 2 - marginsRight.left - marginsRight.right
		fr_["w"] = totalW / 2
		fr_["y"] = marginsRight.up
		fr_["h"] = scrFr["h"] - marginsRight.up - marginsRight.down
		print("fr", hs.inspect(fr))
		print("fr_", hs.inspect(fr_))
		win:setFrame(fr)
		win_:setFrame(fr_)
	end
end

local function max(marginsMax)
	return function()
		local win = hs.window.focusedWindow()
		local fr = win:frame()
		local scrFr = hs.screen.mainScreen():frame()
		fr["x"] = marginsMax.left
		fr["w"] = scrFr["w"] - marginsMax.left - marginsMax.right
		fr["y"] = marginsMax.up
		print(fr["y"])
		fr["h"] = scrFr["h"] - marginsMax.up - marginsMax.down
		win:setFrame(fr)
	end
end

if maps.move then
	local m = maps.move

	wm:bind(m[1], m[2][1], moveL(), nil, moveL()) -- left
	wm:bind(m[1], m[2][2], moveD(), nil, moveD()) -- down
	wm:bind(m[1], m[2][3], moveU(), nil, moveU()) -- up
	wm:bind(m[1], m[2][4], moveR(), nil, moveR()) -- right
end

if maps.moveToSides then
	local m = maps.moveToSides

	wm:bind(m[1], m[2][1], moveToSidesL()) -- left
	wm:bind(m[1], m[2][2], moveToSidesD()) -- down
	wm:bind(m[1], m[2][3], moveToSidesU()) -- up
	wm:bind(m[1], m[2][4], moveToSidesR()) -- right
end

if maps.bigger then
	local m = maps.bigger

	wm:bind(m[1], m[2][1], biggerL(), nil, biggerL()) -- left
	wm:bind(m[1], m[2][2], biggerD(), nil, biggerD()) -- down
	wm:bind(m[1], m[2][3], biggerU(), nil, biggerU()) -- up
	wm:bind(m[1], m[2][4], biggerR(), nil, biggerR()) -- right
end

if maps.smaller then
	local m = maps.smaller
	wm:bind(m[1], m[2][1], smallerL(), nil, smallerL()) -- left
	wm:bind(m[1], m[2][2], smallerD(), nil, smallerD()) -- down
	wm:bind(m[1], m[2][3], smallerU(), nil, smallerU()) -- up
	wm:bind(m[1], m[2][4], smallerR(), nil, smallerR()) -- right
end

if maps.extendToSides then
	local m = maps.extendToSides
	wm:bind(m[1], m[2][1], extendToSidesL()) -- left
	wm:bind(m[1], m[2][2], extendToSidesD()) -- down
	wm:bind(m[1], m[2][3], extendToSidesU()) -- up
	wm:bind(m[1], m[2][4], extendToSidesR()) -- right
end

if maps.moveApp then
	local m = maps.moveApp

	wm:bind(m[1], m[2][1], moveL(nil, APP), nil, moveL(nil, APP)) -- left
	wm:bind(m[1], m[2][2], moveD(nil, APP), nil, moveD(nil, APP)) -- down
	wm:bind(m[1], m[2][3], moveU(nil, APP), nil, moveU(nil, APP)) -- up
	wm:bind(m[1], m[2][4], moveR(nil, APP), nil, moveR(nil, APP)) -- right
end

if maps.moveAppToSides then
	local m = maps.moveAppToSides

	wm:bind(m[1], m[2][1], moveToSidesL(nil, APP)) -- left
	wm:bind(m[1], m[2][2], moveToSidesD(nil, APP)) -- down
	wm:bind(m[1], m[2][3], moveToSidesU(nil, APP)) -- up
	wm:bind(m[1], m[2][4], moveToSidesR(nil, APP)) -- right
end

if maps.moveToSpace then
	local m = maps.moveToSpace

	wm:bind(m[1], m[2][1], moveToSpaceWithOffset(-1))
	wm:bind(m[1], m[2][2], moveToSpaceWithOffset(1))
end

if maps.biggerSmaller then
	local m = maps.biggerSmaller

	wm:bind(m[1], m[2][1], bS(biggerL, smallerL), nil, bS(biggerL, smallerL)) -- left
	wm:bind(m[1], m[2][2], bS(biggerD, smallerD), nil, bS(biggerD, smallerD)) -- down
	wm:bind(m[1], m[2][3], bS(biggerU, smallerU), nil, bS(biggerU, smallerU)) -- up
	wm:bind(m[1], m[2][4], bS(biggerR, smallerR), nil, bS(biggerR, smallerR)) -- right
end

if maps.smallerBigger then
	local m = maps.smallerBigger

	wm:bind(m[1], m[2][1], bS(smallerL, biggerL), nil, bS(smallerL, biggerL)) -- left
	wm:bind(m[1], m[2][2], bS(smallerD, biggerD), nil, bS(smallerD, biggerD)) -- down
	wm:bind(m[1], m[2][3], bS(smallerU, biggerU), nil, bS(smallerU, biggerU)) -- up
	wm:bind(m[1], m[2][4], bS(smallerR, biggerR), nil, bS(smallerR, biggerR)) -- right
end

if maps.shortcuts then
	local m = maps.shortcuts
	wm:bind(m[1], m[2].center, center(HOR_SCALE, VERT_SCALE))
	wm:bind(m[1], m[2].hor, hor(MARGINS_HOR_UP, MARGINS_HOR_DOWN))
	wm:bind(m[1], m[2].vert, vert(MARGINS_VERT_LEFT, MARGINS_VERT_RIGHT))
	wm:bind(m[1], m[2].max, max(MARGINS_MAX))
end
