local lc = require("lspconfig")
local confs = require("lspconfig/configs")
-- print("woke.lua")
-- if not lc.woke then
-- print('hi')
confs.woke = {
  default_config = {
    cmd = { "woke lsp" },
    filetypes = { "solidity" },
    root_dir = function(fname)
      return lc.util.find_git_ancestor(fname)
      -- return lc.util.root_pattern()
    end,
    settings = {},
  },
}
-- end
-- print("b4")
lc.woke.setup({})
-- lc.woke.setup(confs.woke.default_config)
-- print("after")
