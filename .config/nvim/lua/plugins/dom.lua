return {
  { "bkad/CamelCaseMotion" },
  -- { "folke/twilight.nvim", cond = false },
  "vim-scripts/argtextobj.vim",
  "michaeljsmith/vim-indent-object",
  "svermeulen/vim-cutlass",
  "svermeulen/vim-subversive",
  "fladson/vim-kitty",
  {
    "declancm/cinnamon.nvim",
    -- config = function()
    --   require("cinnamon").setup({
    --     -- default_keymaps = false,
    --   })
    -- end,
    opts = {
      default_keymaps = false,
    },
  },
  {
    "AstroNvim/astrotheme",
    opts = { palette = "astrodark" },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    opts = {
      symbol_blacklist = {
        -- "File",
        -- "Module",
        -- "Namespace",
        -- "Package",
        -- "Class",
        -- "Method",
        "Property",
        "Field",
        -- "Constructor",
        "Enum",
        -- "Interface",
        -- "Function",
        "Variable",
        "Constant",
        "String",
        "Number",
        "Boolean",
        "Array",
        "Object",
        "Key",
        "Null",
        "EnumMember",
        -- "Struct",
        "Event",
        "Operator",
        "TypeParameter",
        "Component",
        "Fragment",
      },
    },
  },
  { "AckslD/muren.nvim", opts = {} },
  -- {
  --   "stevearc/aerial.nvim",
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  -- },
  "neovim/nvim-lspconfig",
  "SmiteshP/nvim-navic",
  "MunifTanjim/nui.nvim",

  {
    "SmiteshP/nvim-navbuddy",
    opts = {
      lsp = { auto_attach = true },
    },
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      -- "numToStr/Comment.nvim",        -- Optional
    },
  },
  {
    "renerocksai/telekasten.nvim",
    opts = {
      home = vim.fn.expand("~/Dropbox/notes/tele"), -- Put the name of your notes directory here
    },
  },
  -- { "preservim/vim-markdown" },
  { "tpope/vim-fugitive" },
  {
    "aaronhallaert/advanced-git-search.nvim",
    config = function()
      -- optional: setup telescope before loading the extension
      require("telescope").setup({
        -- move this to the place where you call the telescope setup function
        extensions = {
          advanced_git_search = {
            -- fugitive or diffview
            diff_plugin = "fugitive",
            -- customize git in previewer
            -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
            git_flags = {},
            -- customize git diff in previewer
            -- e.g. flags such as { "--raw" }
            git_diff_flags = {},
            -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
            show_builtin_git_pickers = false,
          },
        },
      })

      require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- OPTIONAL: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      -- "sindrets/diffview.nvim",
    },
  },
  { "kevinhwang91/promise-async" },
  -- { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" }, opts = {} },
  { "projekt0n/github-nvim-theme" },
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup({
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "telescope",

        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })
    end,
  },
  -- Lua
  -- {
  --   "folke/zen-mode.nvim",
  --   config = function()
  --     require("zen-mode").setup({
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --       {
  --         window = {
  --           backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
  --           -- height and width can be:
  --           -- * an absolute number of cells when > 1
  --           -- * a percentage of the width / height of the editor when <= 1
  --           -- * a function that returns the width or the height
  --           width = 120, -- width of the Zen window
  --           height = 1, -- height of the Zen window
  --           -- by default, no options are changed for the Zen window
  --           -- uncomment any of the options below, or add other vim.wo options you want to apply
  --           options = {
  --             -- signcolumn = "no", -- disable signcolumn
  --             -- number = false, -- disable number column
  --             -- relativenumber = false, -- disable relative numbers
  --             -- cursorline = false, -- disable cursorline
  --             -- cursorcolumn = false, -- disable cursor column
  --             -- foldcolumn = "0", -- disable fold column
  --             -- list = false, -- disable whitespace characters
  --           },
  --         },
  --         plugins = {
  --           -- disable some global vim options (vim.o...)
  --           -- comment the lines to not apply the options
  --           options = {
  --             enabled = true,
  --             ruler = false, -- disables the ruler text in the cmd line area
  --             showcmd = false, -- disables the command in the last line of the screen
  --           },
  --           twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
  --           gitsigns = { enabled = false }, -- disables git signs
  --           tmux = { enabled = false }, -- disables the tmux statusline
  --           -- this will change the font size on kitty when in zen mode
  --           -- to make this work, you need to set the following kitty options:
  --           -- - allow_remote_control socket-only
  --           -- - listen_on unix:/tmp/kitty
  --           kitty = {
  --             enabled = true,
  --             font = "+10", -- font size increment
  --           },
  --           -- this will change the font size on alacritty when in zen mode
  --           -- requires  Alacritty Version 0.10.0 or higher
  --           -- uses `alacritty msg` subcommand to change font size
  --           alacritty = {
  --             enabled = false,
  --             font = "14", -- font size
  --           },
  --           -- this will change the font size on wezterm when in zen mode
  --           -- See alse also the Plugins/Wezterm section in this projects README
  --           wezterm = {
  --             enabled = false,
  --             -- can be either an absolute font size or the number of incremental steps
  --             font = "+4", -- (10% increase per step)
  --           },
  --         },
  --         -- callback where you can add custom code when the Zen window opens
  --         on_open = function(win) end,
  --         -- callback where you can add custom code when the Zen window closes
  --         on_close = function() end,
  --       },
  --     })
  --   end,
  -- },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        {
          dimming = {
            alpha = 0.1, -- amount of dimming
            -- we try to get the foreground from the highlight groups or fallback color
            color = { "Normal", "#ffffff" },
            term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
            inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
          },
          -- context = 10, -- amount of lines we will try to show around the current line
          context = 10, -- amount of lines we will try to show around the current line
          treesitter = true, -- use treesitter when available for the filetype
          -- treesitter is used to automatically expand the visible text,
          -- but you can further control the types of nodes that should always be fully expanded
          expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
            "function",
            "method",
            "table",
            "if_statement",
          },
          exclude = {}, -- exclude these filetypes
        },
      })
    end,
  },
  -- { "ziontee113/syntax-tree-surfer" },
  -- {
  --   "nvim-treesitter",
  --   opts = {
  --     incremental_selection = {
  --       enable = true,
  --       keymaps = {
  --         init_selection = "<CR>",
  --         scope_incremental = "<CR>",
  --         node_incremental = "<TAB>",
  --         node_decremental = "<S-TAB>",
  --       },
  --     },
  --   },
  -- },
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
        -- ["core.itero"] = {
        --   config = {
        --     iterables = {
        --       "unordered_list%d",
        --       "ordered_list%d",
        --       "quote%d",
        --     },
        --   },
        -- },
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  { "phaazon/hop.nvim", opts = {} },
  {
    "mfussenegger/nvim-treehopper",
    config = function() end,
  },
  {
    "RRethy/nvim-treesitter-textsubjects",
    config = function()
      require("nvim-treesitter.configs").setup({
        textsubjects = {
          enable = true,
          prev_selection = ",", -- (Optional) keymap to select the previous selection
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
          },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "gd", "<Cmd>lua Scroll('definition')<CR>" }
      keys[#keys + 1] = { "K", false }
    end,
  },
  { "mbbill/undotree" },
  { "echasnovski/mini.pairs", enabled = false },
  { "windwp/nvim-autopairs", opts = {} },
  {
    "ThePrimeagen/harpoon",
  },
  { "tpope/vim-sleuth" },
  { "folke/noice.nvim", opts = { messages = { enabled = false } } },
  -- overriding this one
  {
    "ggandor/flit.nvim",
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  { "AndrewRadev/bufferize.vim" },
  {
    "zbirenbaum/copilot.lua",
    cond = false,

    -- cmd = "Copilot",
    -- build = ":Copilot auth",
    -- opts = {
    --   suggestion = { enabled = true },
    --   panel = { enabled = true },
    -- },
  },
  {
    "L3MON4D3/LuaSnip",
    keys = {
      -- {
      --   "<tab>",
      --   function()
      --     return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
      --   end,
      --   expr = true,
      --   silent = true,
      --   mode = "i",
      -- },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
  { "github/copilot.vim" },
  -- This plugin is a replacement for the included filetype.vim that is sourced on startup. The purpose of that file is to create a series of autocommands that set the filetype variable depending on the filename. The issue is that creating autocommands have significant overhead, and creating 800+ of them as filetype.vim does is a very inefficient way to get the job done.
  -- {
  --   "nathom/filetype.nvim",
  --   opts = {
  --     overrides = { function_complex = {
  --       ["*"] = function()
  --         vim.opt.formatoptions:remove("o")
  --       end,
  --     } },
  --   },
  -- },
}
