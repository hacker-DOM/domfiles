-- bootstrap lazy.nvim, LazyVim and your plugins
vim.env.PATH = "/Users/dteiml/.local/bin:" .. vim.env.PATH
-- vim.lsp.set_log_level('trace')
-- vim.lsp.set_log_level("debug")
-- vim.api.nvim_create_autocmd("VimEnter", {
--     command = "set nornu nonu | Neotree show",
-- })
-- vim.api.nvim_create_autocmd("BufEnter", {
--     command = "set rnu nu",
-- })
require("config.lazy")
-- require("neo-tree.command").execute({ action = "show", toggle = true, dir = vim.loop.cwd() })

require('config.woke')

vim.cmd("source /Users/dteiml/.config/nvim/dom.vim")


-- print text that i really like:
-- this sucks bro there is autocomplete for this
-- print("███████╗██╗░░░██╗████████╗██████╗░░█████╗░██╗░░░██╗  ░█████╗░██╗░░░██╗██╗░░░██╗██████╗░")
-- print("██╔════╝╚██╗░██╔╝╚══██╔══╝██╔══██╗██╔══██╗██║░░░██║  ██╔══██╗██║░░░██║██║░░░██║██╔══██╗")
-- print("█████╗░░░╚████╔╝░░░░██║░░░██████╔╝███████║██║░░░██║  ██║░░██║██║░░░██║██║░░░██║██████╔╝")
-- print("██╔══╝░░░░╚██╔╝░░░░░██║░░░██╔══██╗██╔══██║██║░░░██║  ██║░░██║██║░░░██║██║░░░██║██╔══██╗")
-- print("███████╗░░░██║░░░░░░██║░░░██║░░██║██║░░██║╚██████╔╝  ╚█████╔╝╚██████╔╝╚██████╔╝██║░░██║")
-- print("╚══════╝░░░╚═╝░░░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░  ░╚════╝░░╚═════╝░░╚═════╝░╚═╝░░╚═╝")

-- print("██████╗░███████╗░█████╗░██████╗░███████╗██╗░░░░░██╗░░░░░")
-- print("██
