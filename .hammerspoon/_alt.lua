local log = hs.logger.new(getCurrentFileName(), 'debug')

local k = function(mods, key)
	log.d('Sending keystroke:', hs.inspect(mods), key)
	hs.eventtap.keyStroke(mods, key, 0)
end

local mappingsQwerty = {
	j = "down",
	k = "up",
	m = "left",
	[","] = "right",
	u = "delete",
	i = "return",
	l = "forwarddelete",
}

local mappingsDvorak = {
	t = "down",
	h = "up",
	m = "left",
	w = "right",
	g = "delete",
	c = "return",
	n = "forwarddelete",
}

mappings = hs.fnutils.concat(mappingsDvorak, mappingsQwerty)
modifiersAltAndCmd = {
	{},
	{ "ctrl" },
	{ "shift" },
	{ "ctrl", "shift" }
}

for key, val in pairs(mappings) do
	print(key)
	print(val)
end

for key, val in pairs(mappings) do
	for _, mods in ipairs(modifiersAltAndCmd) do
		-- Qwerty
		-- hs.hotkey.bind(
		-- 	{"cmd", table.unpack(mods)}, -- mods
		-- 	key, -- key
		-- 	-- "", -- message
		-- 	function() kQ(mods, val) end,
		-- 	nil,
		-- 	function() kQ(mods, val) end
		-- )
		-- Dvorak
		hs.hotkey.bind(
			{ "alt", table.unpack(mods) }, -- mods
			key, -- key
			-- "", -- message
			-- function() kD(mods, val) end,
			function() k(mods, val) end,
			nil,
			-- function() kD(mods, val) end,
			function() k(mods, val) end
		)
		-- Dvorak and Qwerty
		hs.hotkey.bind(
			{ "alt", "cmd", table.unpack(mods) }, -- mods
			key, -- key
			-- "", -- message
			function() kDQ(mods, val) end,
			nil,
			function() kDQ(mods, val) end
		)
	end
end

-- for key, val in pairs(mappings) do
-- 	for _, mods in ipairs(modifiersNoAlt) do
-- 		hs.hotkey.bind(
-- 			{"alt", table.unpack(mods)}, -- mods
-- 			key, -- key
-- 			-- "", -- message
-- 			function() kD(mods, val) end,
-- 			nil,
-- 			function() kD(mods, val) end
-- 		)
-- 	end
-- end

-- hs.hotkey.bind({ "ctrl", "alt" }, "m", function()
-- 	hs.eventtap.keyStroke({ "ctrl" }, "m")
-- end)