-- bootstrap lazy.nvim, LazyVim and your plugins
vim.cmd[[
set rtp+=/opt/homebrew/opt/fzf
" packadd fzf
so /opt/homebrew/opt/fzf/plugin/fzf.vim
]]
vim.env.PATH = "/Users/dteiml/.local/bin:" .. vim.env.PATH
-- vim.lsp.set_log_level('trace')
-- vim.lsp.set_log_level("debug")
-- vim.api.nvim_create_autocmd("VimEnter", {
--     command = "set nornu nonu | Neotree show",
-- })
-- vim.api.nvim_create_autocmd("BufEnter", {
--     command = "set rnu nu",
-- })
-- disable iw and aw for wordmotion
-- must come before vim-wordmotion is loaded
vim.cmd[[let g:wordmotion_mappings = {"iw": "", "aw": "", "iW": "", "aW": ""}]]
vim.cmd[[
let g:limelight_bop = '^'
let g:limelight_eop = '$'
" let g:limelight_conceal_guifg = '#181a1c'
let g:limelight_conceal_guifg = '#303235'

" Default: 0.5
" let g:limelight_default_coefficient = 0.7
]]
require("config.lazy")
-- require("neo-tree.command").execute({ action = "show", toggle = true, dir = vim.loop.cwd() })

require('config.woke')

-- M.next_source = function(state)
local function foo()
  local sources = require("neo-tree").config.sources
  local sources = require("neo-tree").config.source_selector.sources
  local next_source = sources[1]
  for i, source_info in ipairs(sources) do
    print(i, vim.inspect(source_info))
    -- if source_info.source == state.name then
    --   next_source = sources[i + 1]
    --   if not next_source then
    --     next_source = sources[1]
    --   end
    --   break
    -- end
  end

  -- require("neo-tree.command").execute({
  --   source = next_source.source,
  --   position = state.current_position,
  --   action = "focus",
  -- })
end


-- doesn't work, idk why
-- require("luasnip.loaders.from_snipmate").lazy_load()
vim.cmd("source /Users/dteiml/.config/nvim/dom.vim")

-- vim.keymap.set("n", "J", foo)

-- ChatGPT: 2023-07-20 12:05:31:
-- Please note, Lua's require function works based on the concept of "packages". Lua maintains a list of paths where it looks for the packages. If the file is not found in the same directory, you need to ensure that Lua's package path (package.path) is set up correctly to include the directory of your module.
vim.cmd[[source /Users/dteiml/Dropbox/Mackup/.config/nvim/snippets.lua]]


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
