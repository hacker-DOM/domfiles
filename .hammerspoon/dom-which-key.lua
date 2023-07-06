-- choices I don't want to share in git & screen sharing
local choices_private = require("dom-which-key-private").choices
-- choices that _aren't_ sensitive
local choices_public = {
	{
		["text"] = "Email",
		["subText"] = "dteiml@gmail.com",
	},
	{
		["text"] = "Yellow Paper Course",
		["subText"] = "https://www.youtube.com/watch?v=e84V1MxRlYs",
	},
	{
		["text"] = "Yellow Paper",
		["subText"] = "https://ethereum.github.io/yellowpaper/paper.pdf",
	},
	{
		["text"] = "Woke",
		["subText"] = "https://github.com/Ackee-Blockchain/woke",
	},

	{
		["text"] = "RareSkills",
		["subText"] = "https://www.rareskills.io",
	},
	{
		["text"] = "Github",
		["subText"] = "https://www.github.com/",
	},
	{
		["text"] = "Abch",
		["subText"] = "Ackee Blockchain",
	},
	{
		["text"] = "Wikipedia",
		["subText"] = "https://en.wikipedia.org/wiki/",
	},
	-- template
	-- {
	-- 	['text'] = '',
	-- 	['subText'] = '',
	-- },
}

local choices_all = hs.fnutils.concat(choices_public, choices_private)

local log = hs.logger.new(getCurrentFileName(), "debug")

local act_on_item = function(item)
	-- log.d(hs.inspect(item))
	-- local cmd = 'open ' .. item["url"]
	-- log.d('Running... ' .. cmd)
	-- hs.execute(cmd)
	-- if item['paste_text'] ~= nil then
	local text = item["subText"]
	log.d("Pasting text:", text)
	hs.eventtap.keyStrokes(text)
	-- end
end

-- local chooser_demo = hs.chooser.new(act_on_item)
-- chooser_demo:choices(choices.choices_demo)
-- chooser_demo:searchSubText(true)

-- local handle = function(item)
-- 	if item["folder"] ~= nil then
-- 		chooser_demo:show()
-- 	else
-- 		act_on_item(item)
-- 		-- end
-- 		-- if item['callback'] then
-- 		--     item['callback']()
-- 	end
-- end

local chooser_public = hs.chooser.new(act_on_item)
chooser_public:choices(choices_public)
chooser_public:searchSubText(true)

local chooser_all = hs.chooser.new(act_on_item)
chooser_all:choices(choices_all)
chooser_all:searchSubText(true)

hs.hotkey.bind(CM, "A", function()
	chooser_public:show()
end)

hs.hotkey.bind(CSM, "A", function ()
	chooser_all:show()
end)
