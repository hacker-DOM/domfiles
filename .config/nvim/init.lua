-- bootstrap lazy.nvim, LazyVim and your plugins
vim.env.PATH = "/Users/dteiml/.local/bin:" .. vim.env.PATH
-- vim.lsp.set_log_level('trace')
vim.lsp.set_log_level("debug")
require("config.lazy")

-- require('config.woke')

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
