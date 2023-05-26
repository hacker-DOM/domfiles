local local_choices = require("dom-which-key-local").choices
local choices = {
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
	table.unpack(local_choices),
	-- template
	-- {
	-- 	['text'] = '',
	-- 	['subText'] = '',
	-- },
}

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

local chooser_demo = hs.chooser.new(act_on_item)
chooser_demo:choices(choices.choices_demo)
chooser_demo:searchSubText(true)

local handle_toplevel = function(item)
	if item["folder"] ~= nil then
		chooser_demo:show()
	else
		act_on_item(item)
		-- end
		-- if item['callback'] then
		--     item['callback']()
	end
end

local chooser_toplevel = hs.chooser.new(handle_toplevel)
chooser_toplevel:choices(choices)
chooser_toplevel:searchSubText(true)

hs.hotkey.bind(CM, "A", function()
	chooser_toplevel:show()
end)
