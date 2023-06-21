local lc = require("lspconfig")
-- vim.lsp.set_log_level("debug")
local confs = require("lspconfig/configs")
-- print("woke.lua")
-- if not lc.woke then
-- print('hi')
-- lc.woke={}
confs.woke = {
  default_config = {
    cmd = { "workon scratch-woke-lsp-log && woke lsp --port 6005" },
    -- cmd = { "workon scratch-woke-lsp-log" },
    -- filetypes = { "solidity" },
    root_dir = function(fname)
      return lc.util.find_git_ancestor(fname)
      -- return lc.util.root_pattern()
    end,
    settings = {},
  },
}
-- print(vim.inspect(lc.woke))
-- vim.tbl_deep_extend("keep", lc, {
--   woke = {
--     _setup_buffer = nil,
--     commands = {},
--     document_config = {
--       command = {},
--       default_config = {
--         cmd = { "woke lsp --port 6005" },
--         filetypes = "solidity",
--         root_dir = function(fname)
--           return lc.util.find_git_ancestor(fname)
--         end,
--         settings = {
--           woke = {
--             compiler = {
--               solc = {},
--             },
--           },
--         },
--       },
--       docs = {
--         default_config = {
--           root_dir = [[root_pattern(".git") or os_homedir()]],
--         },
--         description = [[ Woke LSP ]],
--       },
--     },
--     name = "woke",
--   },
-- })
-- print(vim.inspect(lc.woke))
-- lc.woke.default_config =
-- end
-- print("b4")
lc.woke.setup({})
-- print(vim.inspect(confs.woke))
-- print(vim.inspect(lc.woke))
-- print(vim.inspect(lc.woke._setup_buffer))
-- print(vim.inspect(lc.woke.commands))
-- print(vim.inspect(lc.woke.document_config.commands))
-- print(vim.inspect(lc.woke.document_config.default_config.cmd))
-- print(vim.inspect(lc.woke.setup))
-- lc.woke.setup(confs.woke.default_config)
-- print("after")
