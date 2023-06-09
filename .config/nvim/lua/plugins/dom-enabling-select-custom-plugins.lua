if true then return {} end

return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Dropbox/notes/neorg",
            },
            default_workspace = "notes",
          },
        },
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
}
