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
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      {
        dimming = {
          alpha = 0.001, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
          term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
          inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        -- context = 10, -- amount of lines we will try to show around the current line
        context = 1, -- amount of lines we will try to show around the current line
        -- treesitter = true, -- use treesitter when available for the filetype
        treesitter = false, -- use treesitter when available for the filetype
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          -- "function",
          -- "method",
          -- "table",
          -- "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      },
    },
  },
  {
    "junegunn/limelight.vim",
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
  -- {
  --   "ggandor/flit.nvim",
  --   -- keys = function()
  --   --   ---@type LazyKeys[]
  --   --   local ret = {}
  --   --   for _, key in ipairs({ "f", "F" }) do
  --   --     ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
  --   --   end
  --   --   return ret
  --   -- end,
  --   opts = { keys = { f = "f", F = "F", t = 'abciea', T = 'aieaiea' }, labeled_modes = "nx" },
  -- },
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
            ".metadata.json",
          },
        },
        components = {

          name = function(config, node, state)
            local vim = vim
            local highlights = require("neo-tree.ui.highlights")
            local highlight = config.highlight or highlights.FILE_NAME

            -- Fetch node name and path
            local nodeName = node.name
            local nodePath = node.path

            -- Determine the parent directory of the node
            local parentDir = vim.fn.fnamemodify(nodePath, ":h")

            -- Check for .metadata.json in the same directory
            local metadataPath = parentDir .. "/.metadata.json"

            if vim.fn.filereadable(metadataPath) == 1 then
              local metadata = vim.fn.readfile(metadataPath)
              local jsonData = vim.json.decode(table.concat(metadata, "\n"))

              -- If the node name exists in the JSON's `lines` field and 'programmingCode' exists for that node
              -- print(vim.inspect(jsonData))
              -- if jsonData["lines"] and jsonData["lines"][nodeName] and jsonData["lines"][nodeName]["programmingCode"] then
              if jsonData[nodeName] and jsonData[nodeName]["programmingCode"] then
                -- print("success!")
                -- nodeName = nodeName .. "   (" .. jsonData[nodeName]["programmingCode"] .. ")"
                -- nodeName = "(" .. jsonData[nodeName]["programmingCode"] .. " loc)" .. nodeName
                -- ChatGPT: 2023-08-11 13:45:42:
                -- This function works by:
                --
                -- Reversing the string representation of the number.
                -- Using gsub to insert underscores every three digits.
                -- Reversing the string back to its original order.
                -- Removing any leading underscore that might have been added.
                -- You can use this function to format numbers with underscores as thousands separators.
                function formatWithUnderscores(number)
                  local str = tostring(number)
                  local formatted = str:reverse():gsub("(%d%d%d)", "%1_")
                  return formatted:reverse():gsub("^_", "")
                  -- local str = tostring(number)
                  -- local formatted = str:reverse():gsub("(%d%d%d)", "%1_")
                  -- formatted = formatted:reverse()
                  -- return formatted:gsub("^_", "")
                end

                local loc = jsonData[nodeName]["programmingCode"]
                local loc_under = formatWithUnderscores(loc)
                local loc_under_padded = string.format("%9s", loc_under)
                -- nodeName = "(" .. loc .. ") " .. nodeName
                nodeName = loc_under_padded .. "    " .. nodeName
              end
            end

            if node.type == "directory" then
              highlight = highlights.DIRECTORY_NAME
            end
            if node:get_depth() == 1 then
              highlight = highlights.ROOT_NAME
            else
              if config.use_git_status_colors == nil or config.use_git_status_colors then
                local git_status = state.components.git_status({}, node, state)
                if git_status and git_status.highlight then
                  highlight = git_status.highlight
                end
              end
            end

            return {
              text = nodeName,
              highlight = highlight,
            }
          end,
        },
        window = {
          mappings = {
            ["a"] = {
              "add",
              nowait = true,
              config = {
                -- show_path = "none", -- "none", "relative", "absolute"
                show_path = "relative", -- "none", "relative", "absolute"
              },
            },
            ["A"] = {
              "add_directory",
              nowait = true,
              config = {
                -- show_path = "none", -- "none", "relative", "absolute"
                show_path = "relative", -- "none", "relative", "absolute"
              },
            },
            ["c"] = {
              "copy",
              nowait = true,
              config = {
                -- show_path = "none", -- "none", "relative", "absolute"
                show_path = "relative", -- "none", "relative", "absolute"
              },
            },
            ["m"] = {
              "move",
              nowait = true,
              config = {
                -- show_path = "none", -- "none", "relative", "absolute"
                show_path = "relative", -- "none", "relative", "absolute"
              },
            },
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
            ["<C-x>"] = "open_split",
            ["<C-v>"] = "open_vsplit",
            ["<esc>"] = function()
              vim.cmd([[Neotree close]])
            end,
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
  {
    "norcalli/nvim-terminal.lua",
    opts = {},
  },
  {
    "m00qek/baleia.nvim",
    tag = "v1.3.0",
    opts = {},
  },
  {
    "tpope/vim-unimpaired",
  },
  {
    "tpope/vim-abolish",
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      -- for DAP support
      -- "mfussenegger/nvim-dap-python",
    },
    config = true,
    keys = {
      {
        "<leader>vs",
        "<cmd>:VenvSelect<cr>",
        -- optional if you use a autocmd (see #🤖-Automate)
        "<leader>vc",
        "<cmd>:VenvSelectCached<cr>",
      },
    },
    opts = {

      -- auto_refresh (default: false). Will automatically start a new search every time VenvSelect is opened.
      -- When its set to false, you can refresh the search manually by pressing ctrl-r. For most users this
      -- is probably the best default setting since it takes time to search and you usually work within the same
      -- directory structure all the time.
      auto_refresh = false,

      -- search_venv_managers (default: true). Will search for Poetry/Pipenv/Anaconda virtual environments in their
      -- default location. If you dont use the default location, you can
      search_venv_managers = true,

      -- search_workspace (default: true). Your lsp has the concept of "workspaces" (project folders), and
      -- with this setting, the plugin will look in those folders for venvs. If you only use venvs located in
      -- project folders, you can set search = false and search_workspace = true.
      search_workspace = true,

      -- path (optional, default not set). Absolute path on the file system where the plugin will look for venvs.
      -- Only set this if your venvs are far away from the code you are working on for some reason. Otherwise its
      -- probably better to let the VenvSelect search for venvs in parent folders (relative to your code). VenvSelect
      -- searchs for your venvs in parent folders relative to what file is open in the current buffer, so you get
      -- different results when searching depending on what file you are looking at.
      -- path = "/home/username/your_venvs",

      -- search (default: true). Search your computer for virtual environments outside of Poetry and Pipenv.
      -- Used in combination with parents setting to decide how it searches.
      -- You can set this to false to speed up the plugin if your virtual envs are in your workspace, or in Poetry
      -- or Pipenv locations. No need to search if you know where they will be.
      search = true,

      -- dap_enabled (default: false). When true, uses the selected virtual environment with the debugger.
      -- require nvim-dap-python from https://github.com/mfussenegger/nvim-dap-python
      -- require debugpy from https://github.com/microsoft/debugpy
      -- require nvim-dap from https://github.com/mfussenegger/nvim-dap
      dap_enabled = false,

      -- parents (default: 2) - Used when search = true only. How many parent directories the plugin will go up
      -- (relative to where your open file is on the file system when you run VenvSelect). Once the parent directory
      -- is found, the plugin will traverse down into all children directories to look for venvs. The higher
      -- you set this number, the slower the plugin will usually be since there is more to search.
      -- You may want to set this to to 0 if you specify a path in the path setting to avoid searching parent
      -- directories.
      parents = 2,

      -- name (default: venv) - The name of the venv directories to look for.
      -- name = "venv", -- NOTE: You can also use a lua table here for multiple names: {"venv", ".venv"}`
      name = { "venv", ".venv", ".env", "env" }, -- NOTE: You can also use a lua table here for multiple names: {"venv", ".venv"}`

      -- fd_binary_name (default: fd) - The name of the fd binary on your system.
      fd_binary_name = "fd",

      -- notify_user_on_activate (default: true) - Prints a message that the venv has been activated
      notify_user_on_activate = true,
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },
  {
    "HampusHauffman/block.nvim",
    opts = {},
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- default
    -- opts = function()
    --   local nls = require("null-ls")
    --   return {
    --     root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
    --     sources = {
    --       nls.builtins.formatting.fish_indent,
    --       nls.builtins.diagnostics.fish,
    --       nls.builtins.formatting.stylua,
    --       nls.builtins.formatting.shfmt,
    --       -- nls.builtins.diagnostics.flake8,
    --     },
    --   }
    -- end,
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- region diagnostics
          -- nls.builtins.diagnostics.cspell, -- need a binary for this one
          -- nls.builtins.diagnostics.ruff,
          nls.builtins.diagnostics.zsh,
          -- nls.builtins.diagnostics.black,
          -- blackd is a small HTTP server that exposes Black’s functionality over a simple protocol. The main benefit of using it is to avoid the cost of starting up a new Black process every time you want to blacken a file. The only way to configure the formatter is by using the provided config options, it will not pick up on config files.
          -- nls.builtins.diagnostics.blackd,
          -- region formatting
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.forge_fmt,
          nls.builtins.formatting.gofmt,
          nls.builtins.formatting.isort,
          nls.builtins.formatting.just,
          -- nls.builtins.formatting.prettier,
          nls.builtins.formatting.rustfmt,
          nls.builtins.formatting.treefmt.with({
            -- treefmt requires a config file
            condition = function(utils)
              return utils.root_has_file("treefmt.toml")
            end,
          }),
          nls.builtins.formatting.dprint,
          -- region hover
          nls.builtins.hover.dictionary,
          -- region code actions
          -- nls.builtins.code_actions.cspell,
        },
      }
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {
      api_key_cmd = (function()
        local home = vim.fn.expand("$HOME")
        return "gpg --quiet -d " .. home .. "/.secrets/openai.gpg"
      end)(),
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    -- keys = {
    --   { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    --   { "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
    --   { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    --   { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
    --   -- find
    --   { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    --   { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
    --   { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    --   { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    --   { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
    --   -- git
    --   { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    --   { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    --   -- search
    --   { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    --   { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    --   { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    --   { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    --   { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    --   { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    --   { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    --   { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
    --   { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    --   { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    --   { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    --   { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    --   { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    --   { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    --   { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    --   { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    --   { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
    --   { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
    --   { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
    --   { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
    --   { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    --   {
    --     "<leader>ss",
    --     Util.telescope("lsp_document_symbols", {
    --       symbols = {
    --         "Class",
    --         "Function",
    --         "Method",
    --         "Constructor",
    --         "Interface",
    --         "Module",
    --         "Struct",
    --         "Trait",
    --         "Field",
    --         "Property",
    --       },
    --     }),
    --     desc = "Goto Symbol",
    --   },
    --   {
    --     "<leader>sS",
    --     Util.telescope("lsp_dynamic_workspace_symbols", {
    --       symbols = {
    --         "Class",
    --         "Function",
    --         "Method",
    --         "Constructor",
    --         "Interface",
    --         "Module",
    --         "Struct",
    --         "Trait",
    --         "Field",
    --         "Property",
    --       },
    --     }),
    --     desc = "Goto Symbol (Workspace)",
    --   },
    -- },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            -- ["<c-t>"] = function(...)
            --   return require("trouble.providers.telescope").open_with_trouble(...)
            -- end,
            ["<a-t>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            -- ["<a-i>"] = function()
            --   local action_state = require("telescope.actions.state")
            --   local line = action_state.get_current_line()
            --   Util.telescope("find_files", { no_ignore = true, default_text = line })()
            -- end,
            -- ["<a-h>"] = function()
            --   local action_state = require("telescope.actions.state")
            --   local line = action_state.get_current_line()
            --   Util.telescope("find_files", { hidden = true, default_text = line })()
            -- end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },
  -- local SymbolKind = vim.lsp.protocol.SymbolKind
  --
  -- ---@type UserOpts
  -- local default_opts = {
  --   ---@type table<string, any> `nvim_set_hl`-like options for highlight virtual text
  --   hl = { link = 'Comment' },
  --   ---@type lsp.SymbolKind[] Symbol kinds what need to be count (see `lsp.SymbolKind`)
  --   kinds = { SymbolKind.Function, SymbolKind.Method },
  --   ---@type 'above'|'end_of_line'|'textwidth'
  --   vt_position = 'above',
  --   ---@type function(symbol: Symbol): string
  --   text_format = function(symbol)
  --     local fragments = {}
  --
  --     if symbol.references then
  --       local usage = symbol.references <= 1 and 'usage' or 'usages'
  --       local num = symbol.references == 0 and 'no' or symbol.references
  --       table.insert(fragments, ('%s %s'):format(num, usage))
  --     end
  --
  --     if symbol.definition then
  --       table.insert(fragments, symbol.definition .. ' defs')
  --     end
  --
  --     if symbol.implementation then
  --       table.insert(fragments, symbol.implementation .. ' impls')
  --     end
  --
  --     return table.concat(fragments, ', ')
  --   end,
  --   references = { enabled = true, include_declaration = false },
  --   definition = { enabled = false },
  --   implementation = { enabled = false },
  --   ---@type UserOpts[]
  --   filetypes = {},
  -- }
  -- SymbolKind = { File = 1, Module = 2, Namespace = 3, Package = 4, Class = 5, Method = 6, Property = 7, Field = 8, Constructor = 9, Enum = 10, Interface = 11, Function = 12, Variable = 13, Constant = 14, String = 15, Number = 16, Boolean = 17, Array = 18, Object = 19, Key = 20, Null = 21, EnumMember = 22, Struct = 23, Event = 24, Operator = 25, TypeParameter = 26, }
  {
    "Wansmer/symbol-usage.nvim",
    event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      local SymbolKind = vim.lsp.protocol.SymbolKind
      local opts = {
        -- kinds = { SymbolKind.Function, SymbolKind.Method },
        kinds = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 },
        definitions = { enabled = true },
        implementations = { enabled = true },
      }
      require("symbol-usage").setup(opts)
    end,
    -- opts = {
    --
    -- }
  },
  {
    "itchyny/vim-qfedit"
  }
}
