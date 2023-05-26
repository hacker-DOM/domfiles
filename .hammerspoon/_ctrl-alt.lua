local log = hs.logger.new(getCurrentFileName(), 'debug')

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

local function textShortcut(letter, text, shifted)
	local mods = { "ctrl", "alt" }
	if shifted then
		mods = hs.fnutils.concat(mods, { "shift" })
	end
	hs.hotkey.bind(mods, letter, function()
		log.d('Sending textShortcut:', hs.inspect(mods), letter)
		hs.eventtap.keyStrokes(text)
	end)
end

-- there's this weird bug where the first A doesn't work
textShortcut("a", "aackee-blockchain")
-- there's this weird bug where the first A doesn't work
textShortcut("a", "AAckee Blockchain", true)
-- textShortcut("c", '@@html: <a href="https://github.com/"><img src="https://github-link-card.s3.ap-northeast-1.amazonaws.com/.png" width="500px"></a>@@')
textShortcut("e", "dteiml@gmail.com")
textShortcut("g", "https://www.github.com/")
textShortcut("g", "git@github.com:", true)
textShortcut("h", "hacker-dom")
textShortcut("h", "hacker-DOM", true)
textShortcut("i", "issues?q=is%3Aissue+involves%3Ahacker-dom+")
textShortcut("l", "ATeiml")
textShortcut("n", "Dominik")
textShortcut("u", "dteiml")
textShortcut("w", "https://en.wikipedia.org/wiki/")
textShortcut("w", "https://www.wikiwand.com/en/", true)
