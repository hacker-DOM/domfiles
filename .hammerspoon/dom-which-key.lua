-- I don't want to share in git & screen sharing
local choices_private = require("dom-which-key-private").choices
-- choices that _aren't_ sensitive
local choices_public = {
{["text"] = "Yellow Paper", [ "subText"] = "https://ethereum.github.io/yellowpaper/paper.pdf"},
{["text"] = "Yellow Paper Course", [ "subText"] = "https://www.youtube.com/watch?v=e84V1MxRlYs"},
{["text"] = "Woke", [ "subText"] = "https://github.com/Ackee-Blockchain/woke"},
{["text"] = "RareSkills", [ "subText"] = "https://www.rareskills.io"},
{["text"] = "Github", [ "subText"] = "https://www.github.com/"},
{["text"] = "Abch", [ "subText"] = "Ackee Blockchain"},
{["text"] = "Wikipedia", [ "subText"] = "https://en.wikipedia.org/wiki/"},
{["text"] = "Unicode Arrow down", [ "subText"] = "󱞣"},
{["text"] = "Unicode Equivalent", [ "subText"] = "≡"},
{["text"] = "Unicode less than or equal to (leq)", [ "subText"] = "≤"},
{["text"] = "Unicode greater than or equal to (geq)", [ "subText"] = "≥"},
{["text"] = "Unicode not equal to", [ "subText"] = "≠"},
{["text"] = "Unicode multiplication", [ "subText"] = "×"},
{["text"] = "Unicode division", [ "subText"] = "÷"},
{["text"] = "Unicode middle star", [ "subText"] = "✻"},
{["text"] = "Unicode middle dot", [ "subText"] = "·"},
{["text"] = "Unicode middle bullet", [ "subText"] = "•"},
{["text"] = "Unicode en-dash", [ "subText"] = "–"},
{["text"] = "Unicode em-dash", [ "subText"] = "—"},
{["text"] = "Unicode right arrow", [ "subText"] = "→"},
{["text"] = "Unicode left arrow", [ "subText"] = "←"},
{["text"] = "Unicode double arrow", [ "subText"] = "↔"},
{["text"] = "Unicode therefore (implies)", [ "subText"] = "⇒"},
{["text"] = "Unicode logical equivalence (iff)", [ "subText"] = "⟺"},
{["text"] = "Unicode QED", [ "subText"] = "∎"},
{["text"] = "Unicode is an element of (belongs to set)", [ "subText"] = "∈"},
{["text"] = "Unicode is not an element of (doesn't belong to set)", [ "subText"] = "∉"},
{["text"] = "Unicode subset of", [ "subText"] = "⊂"},
{["text"] = "Unicode proper subset of", [ "subText"] = "⊆"},
{["text"] = "Unicode superset of", [ "subText"] = "⊃"},
{["text"] = "Unicode proper superset of", [ "subText"] = "⊇"},
{["text"] = "Greek letter pi", [ "subText"] = "π"},
{["text"] = "Greek letter Pi", [ "subText"] = "Π"},
{["text"] = "Greek letter delta", [ "subText"] = "δ"},
{["text"] = "Greek letter Delta", [ "subText"] = "Δ"},
{["text"] = "Greek letter sigma", [ "subText"] = "σ"},
{["text"] = "Greek letter Sigma", [ "subText"] = "Σ"},
{["text"] = "Greek letter theta", [ "subText"] = "θ"},
{["text"] = "Greek letter Theta", [ "subText"] = "Θ"},
{["text"] = "Unicode infinity", [ "subText"] = "∞"},
{["text"] = "Unicode square root", [ "subText"] = "√"},
{["text"] = "Unicode integral", [ "subText"] = "∫"},
{["text"] = "Unicode partial derivative", [ "subText"] = "∂"},
{["text"] = "Unicode sum", [ "subText"] = "∑"},
{["text"] = "Unicode product", [ "subText"] = "∏"},
{["text"] = "", [ "subText"] = ""},
{["text"] = "", [ "subText"] = ""},
{["text"] = "", [ "subText"] = ""},
{["text"] = "", [ "subText"] = ""},
	-- end mathematical symbols
{["text"] = "Unicode ellipsis", [ "subText"] = "..."},
{["text"] = "Unicode apple cmd", [ "subText"] = "󰘳"},
{["text"] = "Unicode apple option", [ "subText"] = "󰘵"},
{["text"] = "Unicode apple control", [ "subText"] = "󰘴"},
{["text"] = "Unicode apple shift", [ "subText"] = "󰘶"},
{["text"] = "Unicode Bitcoin (BTC)", [ "subText"] = "₿"},
{["text"] = "Unicode Bitcoin (BTC)", [ "subText"] = ""},
{["text"] = "Unicode Bitcoin (BTC)", [ "subText"] = "󰠓"},
{["text"] = "Unicode Ethereum (ETH)", [ "subText"] = ""},
{["text"] = "Unicode Euro", [ "subText"] = "€"},
{["text"] = "", [ "subText"] = ""},
	-- from https://github.com/makerdao/sai:
	-- # sai deployment on ethlive from c2031c0f9f3a186e90b6a3c1905282f7cc58b9f5
	-- # Mon 18 Dec 03:12:57 GMT 2017
	-- # SAI_ADM updated 2019-06-11
	--
	-- export SAI_GEM=0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
	-- export SAI_GOV=0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2
	-- export SAI_PIP=0x729D19f657BD0614b4985Cf1D82531c67569197B
	-- export SAI_PEP=0x99041F808D598B782D5a3e498681C2452A31da08
	-- export SAI_PIT=0x69076e44a9c70a67d5b79d95795aba299083c275
	-- export SAI_ADM=0x9eF05f7F6deB616fd37aC3c959a2dDD25A54E4F5
	-- export SAI_SAI=0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359
	-- export SAI_SIN=0x79f6d0f646706e1261acf0b93dcb864f357d4680
	-- export SAI_SKR=0xf53ad2c6851052a81b42133467480961b2321c09
	-- export SAI_DAD=0x315cbb88168396d12e1a255f9cb935408fe80710
	-- export SAI_MOM=0xf2c5369cffb8ea6284452b0326e326dbfdcb867c
	-- export SAI_VOX=0x9b0f70df76165442ca6092939132bbaea77f2d7a
	-- export SAI_TUB=0x448a5065aebb8e423f0896e6c5d525c040f59af3
	-- export SAI_TAP=0xbda109309f9fafa6dd6a9cb9f1df4085b27ee8ef
	-- export SAI_TOP=0x9b0ccf7c8994e19f39b2b4cf708e0a7df65fa8a3
{["text"] = "Sai Gem Mainnet", [ "subText"] = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2"},
{["text"] = "Sai Gov Mainnet", [ "subText"] = "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2"},
{["text"] = "Sai Pip Mainnet", [ "subText"] = "0x729D19f657BD0614b4985Cf1D82531c67569197B"},
{["text"] = "Sai Pep Mainnet", [ "subText"] = "0x99041F808D598B782D5a3e498681C2452A31da08"},
{["text"] = "Sai Pit Mainnet", [ "subText"] = "0x69076e44a9c70a67d5b79d95795aba299083c275"},
{["text"] = "Sai Adm Mainnet", [ "subText"] = "0x9eF05f7F6deB616fd37aC3c959a2dDD25A54E4F5"},
{["text"] = "Sai Sai Mainnet", [ "subText"] = "0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359"},
{["text"] = "Sai Sin Mainnet", [ "subText"] = "0x79f6d0f646706e1261acf0b93dcb864f357d4680"},
{["text"] = "Sai Skr Mainnet", [ "subText"] = "0xf53ad2c6851052a81b42133467480961b2321c09"},
{["text"] = "Sai Dad Mainnet", [ "subText"] = "0x315cbb88168396d12e1a255f9cb935408fe80710"},
{["text"] = "Sai Mom Mainnet", [ "subText"] = "0xf2c5369cffb8ea6284452b0326e326dbfdcb867c"},
{["text"] = "Sai Vox Mainnet", [ "subText"] = "0x9b0f70df76165442ca6092939132bbaea77f2d7a"},
{["text"] = "Sai Tub Mainnet", [ "subText"] = "0x448a5065aebb8e423f0896e6c5d525c040f59af3"},
{["text"] = "Sai Tap Mainnet", [ "subText"] = "0xbda109309f9fafa6dd6a9cb9f1df4085b27ee8ef"},
{["text"] = "Sai Top Mainnet", [ "subText"] = "0x9b0ccf7c8994e19f39b2b4cf708e0a7df65fa8a3"},
{["text"] = "Sai Mainnet", [ "subText"] = ""},
{["text"] = "Uniswap V2 Factory Mainnet", [ "subText"] = "0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f"},
{["text"] = "Uniswap V2 Pool: USDC/WETH Mainnet", [ "subText"] = "0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc"},
{["text"] = "USDC Mainnet", [ "subText"] = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"},
{["text"] = "WETH Mainnet", [ "subText"] = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"},

-- czech diacritic:
-- Í Ě É Ď Č Á Ž Ý Ů Ú Ť Š Ř Ó Ň
-- í ň ó ř š ť ú ů ý ž á č ď é ě

-- Í Ě É Ď Č Á Ž Ý Ů Ú Ť Š Ř Ó Ň
-- í ň ó ř š ť ú ů ý ž á č ď é ě
{["text"] = "Czech Long Capital I (Í)", [ "subText"] = "Í"},
{["text"] = "Czech Hard Capital E (Ě)", [ "subText"] = "Ě"},
{["text"] = "Czech Long Capital E (É)", [ "subText"] = "É"},
{["text"] = "Czech Hard Capital D (Ď)", [ "subText"] = "Ď"},
{["text"] = "Czech Hard Capital C (Č)", [ "subText"] = "Č"},
{["text"] = "Czech Long Capital A (Á)", [ "subText"] = "Á"},
{["text"] = "Czech Hard Capital Z (Ž)", [ "subText"] = "Ž"},
{["text"] = "Czech Long Capital Y (Ý)", [ "subText"] = "Ý"},
{["text"] = "Czech Long Capital U (Ů)", [ "subText"] = "Ů"},
{["text"] = "Czech Long Capital U (Ú)", [ "subText"] = "Ú"},
{["text"] = "Czech Hard Capital T (Ť)", [ "subText"] = "Ť"},
{["text"] = "Czech Hard Capital S (Š)", [ "subText"] = "Š"},
{["text"] = "Czech Hard Capital R (Ř)", [ "subText"] = "Ř"},
{["text"] = "Czech Long Capital O (Ó)", [ "subText"] = "Ó"},
{["text"] = "Czech Hard Capital N (Ň)", [ "subText"] = "Ň"},

{["text"] = "Czech Long Lowercase i (í)", [ "subText"] = "í"},
{["text"] = "Czech Hard Lowercase e (ě)", [ "subText"] = "ě"},
{["text"] = "Czech Long Lowercase e (é)", [ "subText"] = "é"},
{["text"] = "Czech Hard Lowercase d (ď)", [ "subText"] = "ď"},
{["text"] = "Czech Hard Lowercase c (č)", [ "subText"] = "č"},
{["text"] = "Czech Long Lowercase a (á)", [ "subText"] = "á"},
{["text"] = "Czech Hard Lowercase z (ž)", [ "subText"] = "ž"},
{["text"] = "Czech Long Lowercase y (ý)", [ "subText"] = "ý"},
{["text"] = "Czech Long Lowercase u (ů)", [ "subText"] = "ů"},
{["text"] = "Czech Long Lowercase u (ú)", [ "subText"] = "ú"},
{["text"] = "Czech Hard Lowercase t (ť)", [ "subText"] = "ť"},
{["text"] = "Czech Hard Lowercase s (š)", [ "subText"] = "š"},
{["text"] = "Czech Hard Lowercase r (ř)", [ "subText"] = "ř"},
{["text"] = "Czech Long Lowercase o (ó)", [ "subText"] = "ó"},
{["text"] = "Czech Hard Lowercase n (ň)", [ "subText"] = "ň"},

{["text"] = "Czech Capital ", [ "subText"] = ""},
{["text"] = "Czech Capital ", [ "subText"] = ""},

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
	log.d("Copying to clipboald:", text)
	hs.pasteboard.setContents(text)
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
-- 		-- item['callback']()
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

hs.hotkey.bind(CSM, "A", function()
	chooser_all:show()
end)
