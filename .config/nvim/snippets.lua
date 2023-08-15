local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node
local s = ls.snippet
-- ls.add_snippets("all", {
-- 	s("ternary", {
-- 		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
-- 		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
-- 	})
-- })
-- print('hi')

ls.add_snippets("toml", {
  s("item", {
    t("["), i(1, "section"), t("]"),
    t("name = "), i(2, "name"),
    t("description = "), i(3, "description"),
    t("date = "), i(4, "date"),
  })
})

ls.add_snippets("python", {
  s("woke", {
    t({
      "from woke.testing import *",
      "",
      "from pytypes. import ",
      "from pytypes.src import ",
      "from pytypes.contracts import ",
      "",
      "@default_chain.connect()",
      "def test():",
      "    default_chain.set_default_accounts(default_chain.accounts[0])",
      "",
    }),
  }),
  s("pdbr", {
    t({
      "import sys",
      "import pdbr",
      "",
      "def custom_excepthook(exc_type, exc_value, exc_traceback):",
      "    pdbr.post_mortem(exc_traceback, exc_value)",
      "",
      "    # [Optional] call the original excepthook as well",
      "    sys.__excepthook__(exc_type, exc_value, exc_traceback)",
      "",
      "sys.excepthook = custom_excepthook",
    }),
  }),
})
