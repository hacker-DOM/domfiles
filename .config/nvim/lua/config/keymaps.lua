-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<c-m>", "<c-w>h", { noremap = true })
vim.keymap.set("n", "<c-,>", "<c-w>l", { noremap = true })

-- vim.keymap.del('n', '<c-j>')
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<c-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<c-j>", function()
  ui.nav_file(1)
end)
vim.keymap.set("n", "<c-k>", function()
  ui.nav_file(2)
end)
vim.keymap.set("n", "<c-l>", function()
  ui.nav_file(3)
end)
vim.keymap.set("n", "<c-;>", function()
  ui.nav_file(4)
end)

-- vim.cmd[[iunmap <tab>]]

-- cinnamon custom
-- vim.cmd([[
-- nunmap h
-- nunmap t
--     ]])

pcall(function ()
  vim.keymap.del("n", "t")
end)

-- vim.keymap.del('n', 'h')
vim.keymap.set({ "n", "x" }, "h", "<Cmd>lua Scroll('<C-u>', 1, 1)<CR>")
vim.keymap.set({ "n", "x" }, "t", "<Cmd>lua Scroll('<C-d>', 1, 1)<CR>")
vim.keymap.set({ "n", "x" }, "k", "<Cmd>lua Scroll('<C-u>', 1, 1)<CR>")
vim.keymap.set({ "n", "x" }, "j", "<Cmd>lua Scroll('<C-d>', 1, 1)<CR>")

-- region from https://github.com/declancm/cinnamon.nvim

-- DEFAULT_KEYMAPS:

-- Half-window movements:
vim.keymap.set({ "n", "x" }, "<C-u>", "<Cmd>lua Scroll('<C-u>', 1, 1)<CR>")
vim.keymap.set({ "n", "x" }, "<C-d>", "<Cmd>lua Scroll('<C-d>', 1, 1)<CR>")

-- Page movements:
vim.keymap.set({ "n", "x" }, "<C-b>", "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>")
vim.keymap.set({ "n", "x" }, "<C-f>", "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>")
vim.keymap.set({ "n", "x" }, "<PageUp>", "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>")
vim.keymap.set({ "n", "x" }, "<PageDown>", "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>")

-- EXTRA_KEYMAPS:

-- Start/end of file and line number movements:
vim.keymap.set({ "n", "x" }, "gg", "<Cmd>lua Scroll('gg')<CR>")
vim.keymap.set({ "n", "x" }, "G", "<Cmd>lua Scroll('G', 0, 1)<CR>")

-- Start/end of line:
vim.keymap.set({ "n", "x" }, "0", "<Cmd>lua Scroll('0')<CR>")
vim.keymap.set({ "n", "x" }, "^", "<Cmd>lua Scroll('^')<CR>")
vim.keymap.set({ "n", "x" }, "$", "<Cmd>lua Scroll('$', 0, 1)<CR>")

-- Paragraph movements:
vim.keymap.set({ "n", "x" }, "{", "<Cmd>lua Scroll('{')<CR>")
vim.keymap.set({ "n", "x" }, "}", "<Cmd>lua Scroll('}')<CR>")

-- Previous/next search result:
vim.keymap.set("n", "n", "<Cmd>lua Scroll('n', 1)<CR>")
vim.keymap.set("n", "N", "<Cmd>lua Scroll('N', 1)<CR>")
vim.keymap.set("n", "*", "<Cmd>lua Scroll('*', 1)<CR>")
vim.keymap.set("n", "#", "<Cmd>lua Scroll('#', 1)<CR>")
vim.keymap.set("n", "g*", "<Cmd>lua Scroll('g*', 1)<CR>")
vim.keymap.set("n", "g#", "<Cmd>lua Scroll('g#', 1)<CR>")

-- Previous/next cursor location:
vim.keymap.set("n", "<C-o>", "<Cmd>lua Scroll('<C-o>', 1)<CR>")
vim.keymap.set("n", "<C-i>", "<Cmd>lua Scroll('1<C-i>', 1)<CR>")

-- Screen scrolling:
vim.keymap.set("n", "zz", "<Cmd>lua Scroll('zz', 0, 1)<CR>")
vim.keymap.set("n", "zt", "<Cmd>lua Scroll('zt', 0, 1)<CR>")
vim.keymap.set("n", "zb", "<Cmd>lua Scroll('zb', 0, 1)<CR>")
vim.keymap.set("n", "z.", "<Cmd>lua Scroll('z.', 0, 1)<CR>")
vim.keymap.set("n", "z<CR>", "<Cmd>lua Scroll('zt^', 0, 1)<CR>")
vim.keymap.set("n", "z-", "<Cmd>lua Scroll('z-', 0, 1)<CR>")
vim.keymap.set("n", "z^", "<Cmd>lua Scroll('z^', 0, 1)<CR>")
vim.keymap.set("n", "z+", "<Cmd>lua Scroll('z+', 0, 1)<CR>")
-- vim.keymap.set('n', '<C-y>', "<Cmd>lua Scroll('<C-y>', 0, 1)<CR>")
-- vim.keymap.set('n', '<C-e>', "<Cmd>lua Scroll('<C-e>', 0, 1)<CR>")

-- Horizontal screen scrolling:
vim.keymap.set("n", "zH", "<Cmd>lua Scroll('zH')<CR>")
vim.keymap.set("n", "zL", "<Cmd>lua Scroll('zL')<CR>")
vim.keymap.set("n", "zs", "<Cmd>lua Scroll('zs')<CR>")
vim.keymap.set("n", "ze", "<Cmd>lua Scroll('ze')<CR>")
vim.keymap.set("n", "zh", "<Cmd>lua Scroll('zh', 0, 1)<CR>")
vim.keymap.set("n", "zl", "<Cmd>lua Scroll('zl', 0, 1)<CR>")

-- EXTENDED_KEYMAPS:

-- Up/down movements:
-- vim.keymap.set({ 'n', 'x' }, 'k', "<Cmd>lua Scroll('k', 0, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, 'j', "<Cmd>lua Scroll('j', 0, 1)<CR>")
vim.keymap.set({ "n", "x" }, "<Up>", "<Cmd>lua Scroll('k', 0, 1)<CR>")
vim.keymap.set({ "n", "x" }, "<Down>", "<Cmd>lua Scroll('j', 0, 1)<CR>")

-- Left/right movements:
-- vim.keymap.set({ 'n', 'x' }, 'h', "<Cmd>lua Scroll('h', 0, 1)<CR>")
vim.keymap.set({ "n", "x" }, "l", "<Cmd>lua Scroll('l', 0, 1)<CR>")
vim.keymap.set({ "n", "x" }, "<Left>", "<Cmd>lua Scroll('h', 0, 1)<CR>")
vim.keymap.set({ "n", "x" }, "<Right>", "<Cmd>lua Scroll('l', 0, 1)<CR>")

-- SCROLL_WHEEL_KEYMAPS:

vim.keymap.set({ "n", "x" }, "<ScrollWheelUp>", "<Cmd>lua Scroll('<ScrollWheelUp>')<CR>")
vim.keymap.set({ "n", "x" }, "<ScrollWheelDown>", "<Cmd>lua Scroll('<ScrollWheelDown>')<CR>")

-- LSP_KEYMAPS:

-- LSP go-to-definition:
-- vim.keymap.del('n', 'gd')
vim.keymap.set("n", "gd", "<Cmd>lua Scroll('definition')<CR>")

-- LSP go-to-declaration:
vim.keymap.set("n", "gD", "<Cmd>lua Scroll('declaration')<CR>")

-- endregion from cinnamon

-- Syntax Tree Surfer
local opts = { noremap = true, silent = true }

-- Normal Mode Swapping:
-- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
-- vim.keymap.set("n", "vU", function()
--   vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
--   return "g@l"
-- end, { silent = true, expr = true })
-- vim.keymap.set("n", "vD", function()
--   vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
--   return "g@l"
-- end, { silent = true, expr = true })
--
-- -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
-- vim.keymap.set("n", "vd", function()
--   vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
--   return "g@l"
-- end, { silent = true, expr = true })
-- vim.keymap.set("n", "vu", function()
--   vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
--   return "g@l"
-- end, { silent = true, expr = true })
--
-- --> If the mappings above don't work, use these instead (no dot repeatable)
-- -- vim.keymap.set("n", "vd", '<cmd>STSSwapCurrentNodeNextNormal<cr>', opts)
-- -- vim.keymap.set("n", "vu", '<cmd>STSSwapCurrentNodePrevNormal<cr>', opts)
-- -- vim.keymap.set("n", "vD", '<cmd>STSSwapDownNormal<cr>', opts)
-- -- vim.keymap.set("n", "vU", '<cmd>STSSwapUpNormal<cr>', opts)
--
-- -- Visual Selection from Normal Mode
-- vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>", opts)
-- vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>", opts)
--
-- -- Select Nodes in Visual Mode
-- vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<cr>", opts)
-- vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", opts)
-- vim.keymap.set("x", "H", "<cmd>STSSelectParentNode<cr>", opts)
-- vim.keymap.set("x", "L", "<cmd>STSSelectChildNode<cr>", opts)
--
-- -- Swapping Nodes in Visual Mode
-- vim.keymap.set("x", "<A-j>", "<cmd>STSSwapNextVisual<cr>", opts)
-- vim.keymap.set("x", "<A-k>", "<cmd>STSSwapPrevVisual<cr>", opts)
