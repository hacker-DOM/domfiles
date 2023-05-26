-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function()
    vim.api.nvim_set_keymap("n", "<tab>", ">>", {})
    vim.api.nvim_set_keymap("n", "<s-tab>", "<<", {})
    vim.api.nvim_set_keymap("i", "<tab>", "<c-t>", {})
    vim.api.nvim_set_keymap("i", "<s-tab>", "<c-d>", {})
  end,
})
