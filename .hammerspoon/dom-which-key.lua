-- I don't want to share in git & screen sharing
local choices_private = require("dom-which-key-private").choices
-- choices that _aren't_ sensitive
local function open_seated_yoga()
	hs.execute('open -a "VLC" "/Users/dteiml/Movies/dl/yt-dlp/yoga/15 minute Seated Yoga Stretches for Headaches, Anxiety & Tension [FjFFasD3kr0].webm"')
end

local resolvers = {
	["15 min Seated Yoga"] = open_seated_yoga
}

local choices_public = {
	-- https://www.youtube.com/watch?v=FjFFasD3kr0
	{ ["text"] = "15 min Seated Yoga", ["subText"] = "" },
	{ ["text"] = "Yellow Paper", ["subText"] = "https://ethereum.github.io/yellowpaper/paper.pdf" },

	{ ["text"] = "Yellow Paper", ["subText"] = "https://ethereum.github.io/yellowpaper/paper.pdf" },
	{ ["text"] = "Yellow Paper Course", ["subText"] = "https://www.youtube.com/watch?v=e84V1MxRlYs" },
	{ ["text"] = "Woke", ["subText"] = "https://github.com/Ackee-Blockchain/woke" },
	{ ["text"] = "RareSkills", ["subText"] = "https://www.rareskills.io" },
	{ ["text"] = "Github", ["subText"] = "https://www.github.com/" },
	{ ["text"] = "Abch", ["subText"] = "Ackee Blockchain" },
	{ ["text"] = "Wikipedia", ["subText"] = "https://en.wikipedia.org/wiki/" },
	{ ["text"] = "Unicode Arrow down", ["subText"] = "󱞣" },
	{ ["text"] = "Unicode Equivalent", ["subText"] = "≡" },
	{ ["text"] = "Unicode less than or equal to (leq)", ["subText"] = "≤" },
	{ ["text"] = "Unicode greater than or equal to (geq)", ["subText"] = "≥" },
	{ ["text"] = "Unicode not equal to", ["subText"] = "≠" },
	{ ["text"] = "Unicode multiplication", ["subText"] = "×" },
	{ ["text"] = "Unicode division", ["subText"] = "÷" },
	{ ["text"] = "Unicode middle star", ["subText"] = "✻" },
	{ ["text"] = "Unicode middle dot", ["subText"] = "·" },
	{ ["text"] = "Unicode middle bullet", ["subText"] = "•" },
	{ ["text"] = "Unicode en-dash", ["subText"] = "–" },
	{ ["text"] = "Unicode em-dash", ["subText"] = "—" },
	{ ["text"] = "Unicode right arrow", ["subText"] = "→" },
	{ ["text"] = "Unicode left arrow", ["subText"] = "←" },
	{ ["text"] = "Unicode double arrow", ["subText"] = "↔" },
	{ ["text"] = "Unicode therefore (implies)", ["subText"] = "⇒" },
	{ ["text"] = "Unicode logical equivalence (iff)", ["subText"] = "⟺" },
	{ ["text"] = "Unicode QED", ["subText"] = "∎" },
	{ ["text"] = "Unicode is an element of (belongs to set)", ["subText"] = "∈" },
	{ ["text"] = "Unicode is not an element of (doesn't belong to set)", ["subText"] = "∉" },
	{ ["text"] = "Unicode subset of", ["subText"] = "⊂" },
	{ ["text"] = "Unicode proper subset of", ["subText"] = "⊆" },
	{ ["text"] = "Unicode superset of", ["subText"] = "⊃" },
	{ ["text"] = "Unicode proper superset of", ["subText"] = "⊇" },
	{ ["text"] = "Greek letter pi", ["subText"] = "π" },
	{ ["text"] = "Greek letter Pi", ["subText"] = "Π" },
	{ ["text"] = "Greek letter delta", ["subText"] = "δ" },
	{ ["text"] = "Greek letter Delta", ["subText"] = "Δ" },
	{ ["text"] = "Greek letter sigma", ["subText"] = "σ" },
	{ ["text"] = "Greek letter Sigma", ["subText"] = "Σ" },
	{ ["text"] = "Greek letter theta", ["subText"] = "θ" },
	{ ["text"] = "Greek letter Theta", ["subText"] = "Θ" },
	{ ["text"] = "Unicode infinity", ["subText"] = "∞" },
	{ ["text"] = "Unicode square root", ["subText"] = "√" },
	{ ["text"] = "Unicode integral", ["subText"] = "∫" },
	{ ["text"] = "Unicode partial derivative", ["subText"] = "∂" },
	{ ["text"] = "Unicode sum", ["subText"] = "∑" },
	{ ["text"] = "Unicode product", ["subText"] = "∏" },
	{ ["text"] = "Unicode superscript lower-case a", ["subText"] = "ᵃ" },
	{ ["text"] = "Unicode superscript lower-case b", ["subText"] = "ᵇ" },
	{ ["text"] = "Unicode superscript lower-case ", ["subText"] = "ᵈ" },
	{ ["text"] = "Unicode superscript lower-case e", ["subText"] = "ᵉ" },
	{ ["text"] = "Unicode superscript lower-case f", ["subText"] = "ᶠ" },
	{ ["text"] = "Unicode superscript lower-case g", ["subText"] = "ᵍ" },
	{ ["text"] = "Unicode superscript lower-case h", ["subText"] = "ʰ" },
	{ ["text"] = "Unicode superscript lower-case i", ["subText"] = "ⁱ" },
	{ ["text"] = "Unicode superscript lower-case j", ["subText"] = "ʲ" },
	{ ["text"] = "Unicode superscript lower-case k", ["subText"] = "ᵏ" },
	{ ["text"] = "Unicode superscript lower-case m", ["subText"] = "ᵐ" },
	{ ["text"] = "Unicode superscript lower-case n", ["subText"] = "ⁿ" },
	{ ["text"] = "Unicode superscript lower-case o", ["subText"] = "ᵒ" },
	{ ["text"] = "Unicode superscript lower-case p", ["subText"] = "ᵖ" },
	{ ["text"] = "Unicode superscript lower-case r", ["subText"] = "ʳ" },
	{ ["text"] = "Unicode superscript lower-case s", ["subText"] = "ˢ" },
	{ ["text"] = "Unicode superscript lower-case t", ["subText"] = "ᵗ" },
	{ ["text"] = "Unicode superscript lower-case u", ["subText"] = "ᵘ" },
	{ ["text"] = "Unicode superscript lower-case v", ["subText"] = "ᵛ" },
	{ ["text"] = "Unicode superscript lower-case w", ["subText"] = "ʷ" },
	{ ["text"] = "Unicode superscript lower-case x", ["subText"] = "ˣ" },
	{ ["text"] = "Unicode superscript lower-case y", ["subText"] = "ʸ" },
	{ ["text"] = "Unicode superscript lower-case z", ["subText"] = "ᶻ" },
	{ ["text"] = "Unicode subscript lower-case a", ["subText"] = "ₐ" },
	{ ["text"] = "Unicode subscript lower-case e", ["subText"] = "ₑ" },
	{ ["text"] = "Unicode subscript lower-case h", ["subText"] = "ₕ" },
	{ ["text"] = "Unicode subscript lower-case i", ["subText"] = "ᵢ" },
	{ ["text"] = "Unicode subscript lower-case j", ["subText"] = "ⱼ" },
	{ ["text"] = "Unicode subscript lower-case k", ["subText"] = "ₖ" },
	{ ["text"] = "Unicode subscript lower-case l", ["subText"] = "ₗ" },
	{ ["text"] = "Unicode subscript lower-case m", ["subText"] = "ₘ" },
	{ ["text"] = "Unicode subscript lower-case n", ["subText"] = "ₙ" },
	{ ["text"] = "Unicode subscript lower-case o", ["subText"] = "ₒ" },
	{ ["text"] = "Unicode subscript lower-case p", ["subText"] = "ₚ" },
	{ ["text"] = "Unicode subscript lower-case r", ["subText"] = "ᵣ" },
	{ ["text"] = "Unicode subscript lower-case s", ["subText"] = "ₛ" },
	{ ["text"] = "Unicode subscript lower-case t", ["subText"] = "ₜ" },
	{ ["text"] = "Unicode subscript lower-case u", ["subText"] = "ᵤ" },
	{ ["text"] = "Unicode subscript lower-case v", ["subText"] = "ᵥ" },
	{ ["text"] = "Unicode subscript lower-case x", ["subText"] = "ₓ" },
	{ ["text"] = "", ["subText"] = "" },
	-- end mathematical symbols
	{ ["text"] = "Unicode ellipsis", ["subText"] = "..." },
	{ ["text"] = "Unicode apple cmd", ["subText"] = "󰘳" },
	{ ["text"] = "Unicode apple option", ["subText"] = "󰘵" },
	{ ["text"] = "Unicode apple control", ["subText"] = "󰘴" },
	{ ["text"] = "Unicode apple shift", ["subText"] = "󰘶" },
	{ ["text"] = "Unicode Bitcoin (BTC)", ["subText"] = "₿" },
	{ ["text"] = "Unicode Bitcoin (BTC)", ["subText"] = "" },
	{ ["text"] = "Unicode Bitcoin (BTC)", ["subText"] = "󰠓" },
	{ ["text"] = "Unicode Ethereum (ETH)", ["subText"] = "" },
	{ ["text"] = "Unicode Euro", ["subText"] = "€" },
	{ ["text"] = "", ["subText"] = "" },
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
	{ ["text"] = "Sai Gem Mainnet", ["subText"] = "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2" },
	{ ["text"] = "Sai Gov Mainnet", ["subText"] = "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2" },
	{ ["text"] = "Sai Pip Mainnet", ["subText"] = "0x729D19f657BD0614b4985Cf1D82531c67569197B" },
	{ ["text"] = "Sai Pep Mainnet", ["subText"] = "0x99041F808D598B782D5a3e498681C2452A31da08" },
	{ ["text"] = "Sai Pit Mainnet", ["subText"] = "0x69076e44a9c70a67d5b79d95795aba299083c275" },
	{ ["text"] = "Sai Adm Mainnet", ["subText"] = "0x9eF05f7F6deB616fd37aC3c959a2dDD25A54E4F5" },
	{ ["text"] = "Sai Sai Mainnet", ["subText"] = "0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359" },
	{ ["text"] = "Sai Sin Mainnet", ["subText"] = "0x79f6d0f646706e1261acf0b93dcb864f357d4680" },
	{ ["text"] = "Sai Skr Mainnet", ["subText"] = "0xf53ad2c6851052a81b42133467480961b2321c09" },
	{ ["text"] = "Sai Dad Mainnet", ["subText"] = "0x315cbb88168396d12e1a255f9cb935408fe80710" },
	{ ["text"] = "Sai Mom Mainnet", ["subText"] = "0xf2c5369cffb8ea6284452b0326e326dbfdcb867c" },
	{ ["text"] = "Sai Vox Mainnet", ["subText"] = "0x9b0f70df76165442ca6092939132bbaea77f2d7a" },
	{ ["text"] = "Sai Tub Mainnet", ["subText"] = "0x448a5065aebb8e423f0896e6c5d525c040f59af3" },
	{ ["text"] = "Sai Tap Mainnet", ["subText"] = "0xbda109309f9fafa6dd6a9cb9f1df4085b27ee8ef" },
	{ ["text"] = "Sai Top Mainnet", ["subText"] = "0x9b0ccf7c8994e19f39b2b4cf708e0a7df65fa8a3" },
	{ ["text"] = "Sai Mainnet", ["subText"] = "" },
	{ ["text"] = "Uniswap V2 Factory Mainnet", ["subText"] = "0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f" },
	{ ["text"] = "Uniswap V2 Pool: USDC/WETH Mainnet", ["subText"] = "0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc" },
	{ ["text"] = "USDC Mainnet", ["subText"] = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48" },
	{ ["text"] = "WETH Mainnet", ["subText"] = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2" },

	-- czech diacritic:
	-- Í Ě É Ď Č Á Ž Ý Ů Ú Ť Š Ř Ó Ň
	-- í ň ó ř š ť ú ů ý ž á č ď é ě

	-- Í Ě É Ď Č Á Ž Ý Ů Ú Ť Š Ř Ó Ň
	-- í ň ó ř š ť ú ů ý ž á č ď é ě
	{ ["text"] = "Czech Long Capital I (Í)", ["subText"] = "Í" },
	{ ["text"] = "Czech Hard Capital E (Ě)", ["subText"] = "Ě" },
	{ ["text"] = "Czech Long Capital E (É)", ["subText"] = "É" },
	{ ["text"] = "Czech Hard Capital D (Ď)", ["subText"] = "Ď" },
	{ ["text"] = "Czech Hard Capital C (Č)", ["subText"] = "Č" },
	{ ["text"] = "Czech Long Capital A (Á)", ["subText"] = "Á" },
	{ ["text"] = "Czech Hard Capital Z (Ž)", ["subText"] = "Ž" },
	{ ["text"] = "Czech Long Capital Y (Ý)", ["subText"] = "Ý" },
	{ ["text"] = "Czech Long Capital U (Ů)", ["subText"] = "Ů" },
	{ ["text"] = "Czech Long Capital U (Ú)", ["subText"] = "Ú" },
	{ ["text"] = "Czech Hard Capital T (Ť)", ["subText"] = "Ť" },
	{ ["text"] = "Czech Hard Capital S (Š)", ["subText"] = "Š" },
	{ ["text"] = "Czech Hard Capital R (Ř)", ["subText"] = "Ř" },
	{ ["text"] = "Czech Long Capital O (Ó)", ["subText"] = "Ó" },
	{ ["text"] = "Czech Hard Capital N (Ň)", ["subText"] = "Ň" },

	{ ["text"] = "Czech Long Lowercase i (í)", ["subText"] = "í" },
	{ ["text"] = "Czech Hard Lowercase e (ě)", ["subText"] = "ě" },
	{ ["text"] = "Czech Long Lowercase e (é)", ["subText"] = "é" },
	{ ["text"] = "Czech Hard Lowercase d (ď)", ["subText"] = "ď" },
	{ ["text"] = "Czech Hard Lowercase c (č)", ["subText"] = "č" },
	{ ["text"] = "Czech Long Lowercase a (á)", ["subText"] = "á" },
	{ ["text"] = "Czech Hard Lowercase z (ž)", ["subText"] = "ž" },
	{ ["text"] = "Czech Long Lowercase y (ý)", ["subText"] = "ý" },
	{ ["text"] = "Czech Long Lowercase u (ů)", ["subText"] = "ů" },
	{ ["text"] = "Czech Long Lowercase u (ú)", ["subText"] = "ú" },
	{ ["text"] = "Czech Hard Lowercase t (ť)", ["subText"] = "ť" },
	{ ["text"] = "Czech Hard Lowercase s (š)", ["subText"] = "š" },
	{ ["text"] = "Czech Hard Lowercase r (ř)", ["subText"] = "ř" },
	{ ["text"] = "Czech Long Lowercase o (ó)", ["subText"] = "ó" },
	{ ["text"] = "Czech Hard Lowercase n (ň)", ["subText"] = "ň" },

	{ ["text"] = "Czech Capital ", ["subText"] = "" },
	{ ["text"] = "Czech Capital ", ["subText"] = "" },

	{ ["text"] = "ipa [a, o, hot] open back unrounded", ["subText"] = "ɑ" }, -- eg 'hot'
	-- {["text"] = "ipa open-mid schwa", [ "subText" ] = "ɐ"},
	{ ["text"] = "ipa [a, o, thought] open back rounded", ["subText"] = "ɒ" }, -- eg 'thought'
	{ ["text"] = "ipa [ae, e, cat] raised open front unrounded", ["subText"] = "æ" }, -- eg 'cat'
	-- {["text"] = "ipa vd bilabial implosive", [ "subText" ] = "ɓ"},
	-- {["text"] = "ipa vd bilabial trill", [ "subText" ] = "ʙ"},
	-- {["text"] = "ipa vd bilabial fricative", [ "subText" ] = "β"},
	-- {["text"] = "ipa open-mid back rounded", [ "subText" ] = "ɔ"},
	-- {["text"] = "ipa vl alveolopalatal fricative", [ "subText" ] = "ɕ"},
	-- {["text"] = "ipa vl palatal fricative", [ "subText" ] = "ç"},
	-- {["text"] = "ipa vd alveolar implosive", [ "subText" ] = "ɗ"},
	-- {["text"] = "ipa vd retroflex plosive", [ "subText" ] = "ɖ"},
	{ ["text"] = "ipa [o, hard th, this] vd dental fricative", ["subText"] = "ð" }, -- eg 'this'
	{ ["text"] = "ipa [dzh, j, jeans] vd postalveolar affricate", ["subText"] = "ʤ" }, -- eg 'jeans'
	{ ["text"] = "ipa [e, a, about] schwa (mid central vowel)", ["subText"] = "ə" }, -- eg 'about', 'vision'
	-- {["text"] = "ipa close-mid schwa", [ "subText" ] = "ɘ"},
	-- {["text"] = "ipa rhotacized schwa", [ "subText" ] = "ɚ"},
	{ ["text"] = "ipa [e, e, bed] open-mid front unrounded", ["subText"] = "ɛ" }, -- eg 'bed'
	-- {["text"] = "ipa open-mid central", [ "subText" ] = "ɜ"},
	-- {["text"] = "ipa rhotacized open-mid central", [ "subText" ] = "ɝ"},
	-- {["text"] = "ipa open-mid central rounded", [ "subText" ] = "ɞ"},
	{ ["text"] = "ipa [t, ď, děda] vd palatal plosive", ["subText"] = "ɟ" }, -- eg 'děda', 'dew' (uk)
	-- {["text"] = "ipa vd palatal implosive", [ "subText" ] = "ʄ"},
	{ ["text"] = "ipa [g, g, grain] vd velar plosive", ["subText"] = "ɡ" }, -- eg 'grain'
	-- {["text"] = "ipa vd velar implosive", [ "subText" ] = "ɠ"},
	-- {["text"] = "ipa vd uvular plosive", [ "subText" ] = "ɢ"},
	-- {["text"] = "ipa vd uvular implosive", [ "subText" ] = "ʛ"},
	{ ["text"] = "ipa [h, h, hořet] vd glottal fricative", ["subText"] = "ɦ" }, -- eg 'hořet'
	-- {["text"] = "ipa vl multiple-place fricative", [ "subText" ] = "ɧ"},
	-- {["text"] = "ipa vl pharyngeal fricative", [ "subText" ] = "ħ"},
	-- {["text"] = "ipa labial-palatal approximant", [ "subText" ] = "ɥ"},
	-- {["text"] = "ipa vl epiglottal fricative", [ "subText" ] = "ʜ"},
	-- {["text"] = "ipa close central unrounded", [ "subText" ] = "ɨ"},
	{ ["text"] = "ipa [i, i, bit] lax close front unrounded", ["subText"] = "ɪ" }, -- eg 'bit'
	-- {["text"] = "ipa vd palatal fricative", [ "subText" ] = "ʝ"},
	-- {["text"] = "ipa vd retroflex lateral", [ "subText" ] = "ɭ"},
	-- {["text"] = "ipa vl alveolar lateral fricative", [ "subText" ] = "ɬ"},
	-- {["text"] = "ipa velarized vd alveolar lateral", [ "subText" ] = "ɫ"},
	-- {["text"] = "ipa vd alveolar lateral fricative", [ "subText" ] = "ɮ"}, -- not used in GenAm
	-- {["text"] = "ipa vd velar lateral", [ "subText" ] = "ʟ"}, -- not used in GenAm
	{ ["text"] = "ipa [m, mf, symphony] vd labiodental nasal", ["subText"] = "ɱ" }, -- m before 'f' or 'v', eg 'symphony'
	-- {["text"] = "ipa close back unrounded", [ "subText" ] = "ɯ"}, -- not used in GenAm
	-- {["text"] = "ipa velar approximant", [ "subText" ] = "ɰ"}, -- not used in GenAm
	{ ["text"] = "ipa [n, ng, sing] vd velar nasal", ["subText"] = "ŋ" }, -- eg 'sing'
	-- {["text"] = "ipa vd retroflex nasal", [ "subText" ] = "ɳ"}, -- not used in GenAm
	{ ["text"] = "ipa [n, ň, canyon] vd palatal nasal", ["subText"] = "ɲ" }, -- eg 'kůň', 'canyon'
	-- {["text"] = "ipa vd uvular nasal", [ "subText" ] = "ɴ"}, -- not used in GenAm
	-- {["text"] = "ipa front close-mid rounded", [ "subText" ] = "ø"}, -- not used in GenAm
	-- {["text"] = "ipa rounded schwa", [ "subText" ] = "ɵ"}, -- not used in GenAm
	-- {["text"] = "ipa vl bilabial fricative", [ "subText" ] = "ɸ"}, -- not used in GenAm
	{ ["text"] = "ipa [theta/o, soft th, thing] vl dental fricative", ["subText"] = "θ" }, -- eg 'thing'
	-- {["text"] = "ipa front open-mid rounded", [ "subText" ] = "œ"}, -- not used in GenAm
	-- {["text"] = "ipa front open rounded", [ "subText" ] = "ɶ"}, -- not used in GenAm
	-- {["text"] = "ipa bilabial click", [ "subText" ] = "ʘ"},
	{ ["text"] = "ipa [r, r, red] vd (post)alveolar approximant", ["subText"] = "ɹ" }, -- 'red'
	-- {["text"] = "ipa vd alveolar lateral flap", [ "subText" ] = "ɺ"}, -- not used in GenAm
	-- {["text"] = "ipa vd alveolar tap", [ "subText" ] = "ɾ"}, -- not used in GenAm
	-- {["text"] = "ipa vd retroflex approximant", [ "subText" ] = "ɻ"}, -- not used in GenAm
	-- {["text"] = "ipa vd uvular trill", [ "subText" ] = "ʀ"}, -- not used in GenAm
	-- {["text"] = "ipa vd uvular fricative", [ "subText" ] = "ʁ"}, -- not used in GenAm
	-- {["text"] = "ipa vd retroflex flap", [ "subText" ] = "ɽ"}, -- not used in GenAm
	-- {["text"] = "ipa vl retroflex fricative", [ "subText" ] = "ʂ"}, -- not used in GenAm
	{ ["text"] = "ipa [s, sh, ship] vl postalveolar fricative", ["subText"] = "ʃ" }, -- eg 'ship'
	{ ["text"] = "ipa [t, t, time] vl retroflex plosive", ["subText"] = "ʈ" }, -- eg 'time'
	{ ["text"] = "ipa [tsh, ch, beach] vl postalveolar affricate", ["subText"] = "ʧ" }, -- eg 'beach'
	{ ["text"] = "ipa [u, oo, goose] close central rounded", ["subText"] = "ʉ" }, -- eg 'goose'
	{ ["text"] = "ipa [u, u, hook] lax close back rounded", ["subText"] = "ʊ" }, -- eg 'hook'
	-- {["text"] = "ipa vd labiodental approximant", [ "subText" ] = "ʋ"}, -- not used in GenAm
	-- {["text"] = "ipa voiced labiodental flap", [ "subText" ] = "ⱱ"}, -- not used in GenAm
	{ ["text"] = "ipa [lambda/A, uh, gut] open-mid back unrounded", ["subText"] = "ʌ" }, -- eg 'gut'
	-- {["text"] = "ipa vd velar fricative", [ "subText" ] = "ɣ"}, -- not used in GenAm
	-- {["text"] = "ipa close-mid back unrounded", [ "subText" ] = "ɤ"}, -- not used in GenAm
	-- {["text"] = "ipa vl labial-velar fricative", [ "subText" ] = "ʍ"},
	-- {["text"] = "ipa vl uvular fricative", [ "subText" ] = "χ"},
	-- {["text"] = "ipa vd palatal lateral", [ "subText" ] = "ʎ"},
	-- {["text"] = "ipa lax close front rounded", [ "subText" ] = "ʏ"},
	-- {["text"] = "ipa vd alveolopalatal fricative", [ "subText" ] = "ʑ"},
	-- {["text"] = "ipa vd retroflex fricative", [ "subText" ] = "ʐ"},
	{ ["text"] = "ipa [z, zh, vision] vd postalveolar fricative", ["subText"] = "ʒ" }, -- eg 'vision'
	-- {["text"] = "ipa glottal plosive", [ "subText" ] = "ʔ"},
	-- {["text"] = "ipa vd epiglottal plosive", [ "subText" ] = "ʡ"},
	-- {["text"] = "ipa vd pharyngeal fricative", [ "subText" ] = "ʕ"},
	-- {["text"] = "ipa vd epiglottal fricative", [ "subText" ] = "ʢ"},
	-- {["text"] = "ipa dental click", [ "subText" ] = "ǀ"},
	-- {["text"] = "ipa alveolar lateral click", [ "subText" ] = "ǁ"},
	-- {["text"] = "ipa alveolar click", [ "subText" ] = "ǂ"},
	-- {["text"] = "ipa retroflex click", [ "subText" ] = "ǃ"},
}
local choices_all = hs.fnutils.concat(choices_public, choices_private)

local log = hs.logger.new(getCurrentFileName(), "debug")

local act_on_item = function(item)
	-- log.d(hs.inspect(item))
	-- local cmd = 'open ' .. item["url"]
	-- log.d('Running... ' .. cmd)
	-- hs.execute(cmd)
	-- if item['paste_text'] ~= nil then
	-- if item["function"] ~= nil then
	-- 	log.d("running function")
	-- 	item["function"]()
	if resolvers[item["text"]] ~= nil then
		resolvers[item["text"]]()
else
	local text = item["subText"]
	log.d("Copying to clipboald:", text)
	hs.pasteboard.setContents(text)
	log.d("Pasting text:", text)
	hs.eventtap.keyStrokes(text)
	end
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
