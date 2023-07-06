local renderer = require("neo-tree.ui.renderer")

-- Expand a node and load filesystem info if needed.
local function open_dir(state, dir_node)
  local fs = require("neo-tree.sources.filesystem")
  fs.toggle_directory(state, dir_node, nil, true, false)
end

-- Expand a node and all its children, optionally stopping at max_depth.
local function recursive_open(state, node, max_depth)
  local max_depth_reached = 1
  local stack = { node }
  while next(stack) ~= nil do
    node = table.remove(stack)
    if node.type == "directory" and not node:is_expanded() then
      open_dir(state, node)
    end

    local depth = node:get_depth()
    max_depth_reached = math.max(depth, max_depth_reached)

    if not max_depth or depth < max_depth - 1 then
      local children = state.tree:get_nodes(node:get_id())
      for _, v in ipairs(children) do
        table.insert(stack, v)
      end
    end
  end

  return max_depth_reached
end

--- Open the fold under the cursor, recursing if count is given.
local function neotree_zo(state, open_all)
  local node = state.tree:get_node()

  if open_all then
    recursive_open(state, node)
  else
    recursive_open(state, node, node:get_depth() + vim.v.count1)
  end

  renderer.redraw(state)
end

--- Recursively open the current folder and all folders it contains.
local function neotree_zO(state)
  neotree_zo(state, true)
end

-- The nodes inside the root folder are depth 2.
local MIN_DEPTH = 2

--- Close the node and its parents, optionally stopping at max_depth.
local function recursive_close(state, node, max_depth)
  if max_depth == nil or max_depth <= MIN_DEPTH then
    max_depth = MIN_DEPTH
  end

  local last = node
  while node and node:get_depth() >= max_depth do
    if node:has_children() and node:is_expanded() then
      node:collapse()
    end
    last = node
    node = state.tree:get_node(node:get_parent_id())
  end

  return last
end

--- Close a folder, or a number of folders equal to count.
local function neotree_zc(state, close_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  local max_depth
  if not close_all then
    max_depth = node:get_depth() - vim.v.count1
    if node:has_children() and node:is_expanded() then
      max_depth = max_depth + 1
    end
  end

  local last = recursive_close(state, node, max_depth)
  renderer.redraw(state)
  renderer.focus_node(state, last:get_id())
end

-- Close all containing folders back to the top level.
local function neotree_zC(state)
  neotree_zc(state, true)
end

--- Open a closed folder or close an open one, with an optional count.
local function neotree_za(state, toggle_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  if node.type == "directory" and not node:is_expanded() then
    neotree_zo(state, toggle_all)
  else
    neotree_zc(state, toggle_all)
  end
end

--- Recursively close an open folder or recursively open a closed folder.
local function neotree_zA(state)
  neotree_za(state, true)
end

--- Set depthlevel, analagous to foldlevel, for the neo-tree file tree.
local function set_depthlevel(state, depthlevel)
  if depthlevel < MIN_DEPTH then
    depthlevel = MIN_DEPTH
  end

  local stack = state.tree:get_nodes()
  while next(stack) ~= nil do
    local node = table.remove(stack)

    if node.type == "directory" then
      local should_be_open = depthlevel == nil or node:get_depth() < depthlevel
      if should_be_open and not node:is_expanded() then
        open_dir(state, node)
      elseif not should_be_open and node:is_expanded() then
        node:collapse()
      end
    end

    local children = state.tree:get_nodes(node:get_id())
    for _, v in ipairs(children) do
      table.insert(stack, v)
    end
  end

  vim.b.neotree_depthlevel = depthlevel
end

--- Refresh the tree UI after a change of depthlevel.
-- @bool stay Keep the current node revealed and selected
local function redraw_after_depthlevel_change(state, stay)
  local node = state.tree:get_node()

  if stay then
    require("neo-tree.ui.renderer").expand_to_node(state.tree, node)
  else
    -- Find the closest parent that is still visible.
    local parent = state.tree:get_node(node:get_parent_id())
    while not parent:is_expanded() and parent:get_depth() > 1 do
      node = parent
      parent = state.tree:get_node(node:get_parent_id())
    end
  end

  renderer.redraw(state)
  renderer.focus_node(state, node:get_id())
end

--- Update all open/closed folders by depthlevel, then reveal current node.
local function neotree_zx(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, true)
end

--- Update all open/closed folders by depthlevel.
local function neotree_zX(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse more folders: decrease depthlevel by 1 or count.
local function neotree_zm(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
  set_depthlevel(state, depthlevel - vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse all folders. Set depthlevel to MIN_DEPTH.
local function neotree_zM(state)
  set_depthlevel(state, MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Expand more folders: increase depthlevel by 1 or count.
local function neotree_zr(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH
  set_depthlevel(state, depthlevel + vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Expand all folders. Set depthlevel to the deepest node level.
local function neotree_zR(state)
  local top_level_nodes = state.tree:get_nodes()

  local max_depth = 1
  for _, node in ipairs(top_level_nodes) do
    max_depth = math.max(max_depth, recursive_open(state, node))
  end

  vim.b.neotree_depthlevel = max_depth
  redraw_after_depthlevel_change(state, false)
end

return {
  -- { "bkad/CamelCaseMotion" },
  { "noice.nvim", cond = false },
  { "chaoren/vim-wordmotion" },
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
      default_delay = 5,
      hide_cursor = true,
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
  -- {
  --   "mickael-menu/zk-nvim",
  --   config = function()
  --     require("zk").setup({
  --       -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  --       -- it's recommended to use "telescope" or "fzf"
  --       picker = "telescope",
  --
  --       lsp = {
  --         -- `config` is passed to `vim.lsp.start_client(config)`
  --         config = {
  --           cmd = { "zk", "lsp" },
  --           name = "zk",
  --           -- on_attach = ...
  --           -- etc, see `:h vim.lsp.start_client()`
  --         },
  --
  --         -- automatically attach buffers in a zk notebook that match the given filetypes
  --         auto_attach = {
  --           enabled = true,
  --           filetypes = { "markdown" },
  --         },
  --       },
  --     })
  --   end,
  -- },
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
    keys = function()
      -- keys = {
      -- {
      --   "<tab>",
      --   function()
      --     return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
      --   end,
      --   expr = true,
      --   silent = true,
      --   mode = "i",
      -- },
      return {
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
      }
    end,
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
  {
    "godlygeek/tabular",
  },
  {
    "preservim/vim-markdown",
  },
  {
    "NoahTheDuke/vim-just",
  },
  {
    "ruifm/gitlinker.nvim",
    opts = {},
  },
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {},
        lua_ls = {
          settings = {
            Lua = {
              format = {
                defaultConfig = {
                  indent_style = "space",
                  indent_size = 4,
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "AstroNvim/astrotheme",
    -- opts = {
    --   palette = "astrodark", -- String of the default palette to use when calling `:colorscheme astrotheme`
    --
    --   termguicolors = true, -- Bool value, toggles if termguicolors are set by AstroTheme.
    --
    --   terminal_color = true, -- Bool value, toggles if terminal_colors are set by AstroTheme.
    --
    --   plugin_default = "auto", -- Sets how all plugins will be loaded
    --   -- "auto": Uses lazy / packer enabled plugins to load highlights.
    --   -- true: Enables all plugins highlights.
    --   -- false: Disables all plugins.
    --
    --   plugins = { -- Allows for individual plugin overides using plugin name and value from above.
    --     ["bufferline.nvim"] = false,
    --   },
    --
    --   palettes = {
    --     global = { -- Globaly accessible palettes, theme palettes take priority.
    --       my_grey = "#ebebeb",
    --       my_color = "#ffffff",
    --     },
    --     astrodark = { -- Extend or modify astrodarks palette colors
    --       red = "#800010", -- Overrides astrodarks red color
    --       my_color = "#000000", -- Overrides global.my_color
    --     },
    --   },

    --
    --   highlights = {
    --     global = { -- Add or modify hl groups globaly, theme specific hl groups take priority.
    --       modify_hl_groups = function(hl, c)
    --         hl.PluginColor4 = { fg = c.my_grey, bg = c.none }
    --       end,
    --       ["@String"] = { fg = "#ff00ff", bg = "NONE" },
    --     },
    --     astrodark = {
    --       -- first parameter is the highlight table and the second parameter is the color palette table
    --       modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
    --         hl.Comment.fg = c.my_color
    --         hl.Comment.italic = true
    --       end,
    --       ["@String"] = { fg = "#ff00ff", bg = "NONE" },
    --     },
    --   },
    -- },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "astrotheme",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          -- action "focus" is also the default
          require("neo-tree.command").execute({
            action = "focus",
            position = "float",
            toggle = true,
            reveal = true,
            dir = vim.loop.cwd(),
          })
        end,
        desc = "File explorer [float]",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ position = "left", toggle = true, reveal = true, dir = vim.loop.cwd() })
        end,
        desc = "File explorer [left]",
      },
      { "<leader>e", "<leader>fe", desc = "File explorer [float]", remap = true },
      { "<leader>E", "<leader>fE", desc = "File explorer [left]", remap = true },
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          never_show = {
            "__pycache__",
            ".DS_Store",
          },
        },
        window = {
          mappings = {
            ["z"] = "none",
            ["zo"] = neotree_zo,
            ["zO"] = neotree_zO,
            ["zc"] = neotree_zc,
            ["zC"] = neotree_zC,
            ["za"] = neotree_za,
            ["zA"] = neotree_zA,
            ["zx"] = neotree_zx,
            ["zX"] = neotree_zX,
            ["zm"] = neotree_zm,
            ["zM"] = neotree_zM,
            ["zr"] = neotree_zr,
            ["zR"] = neotree_zR,
          },
        },
      },
    },
  },
  -- {
  --   "lucc/nvimpager",
  --   opts =
  -- }
  {
    "norcalli/nvim-terminal.lua",
    opts = {},
  },
  -- {
  --   "nvim-tree/nvim-web-devicons",
  --   opts = {
  --     txt = {
  --       icon = ""
  --     }
  --   }
  -- }
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        diagnostics = false,
      },
    },
  },
}
