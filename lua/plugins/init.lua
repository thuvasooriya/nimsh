local overrides = require "configs.overrides"

return {
  "nvim-lua/plenary.nvim",
  require "plugins.motions",
  require "plugins.nvchad",
  require "plugins.git",
  require "plugins.completions",
  require "plugins.telescope",
  require "plugins.lint",
  -- require "plugins.debug",
  -- --------------------
  -- ui stuff
  -- --------------------

  { -- dashboard
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("configs.alpha").setup,
  },

  { -- scope indent lines
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },

  { -- highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = true },
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
    lazy = false,
    priority = 200,
  },

  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {},
  -- },
  -- {
  --   "stevearc/dressing.nvim",
  --   opts = {},
  -- },

  -- --------------------
  -- treesitter n lsp stuff
  -- --------------------
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    dependencies = { { "nushell/tree-sitter-nu" } },
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      -- :help nvim-treesitter
      require("nvim-treesitter.install").prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)
      --    - incremental selection: included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} }, -- useful status updates for lsp
      { "folke/neodev.nvim", opts = {} }, -- configures lua lsp for neovim
    },
    config = function()
      require("configs.lspconfig").defaults()
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "n",
        desc = "[f]or[m]at buffer",
      },
    },
    opts = function()
      return require "configs.conform_conf"
    end,
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  { -- keyboard hint
    "folke/which-key.nvim",
    event = "VimEnter",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },

  -- --------------------
  -- files n projects stuff
  -- --------------------

  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      view_options = {
        show_hidden = true,
      },
      default_file_explorer = true,
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "open parent directory" },
    },
  },

  {
    "coffebar/neovim-project",
    opts = overrides.nvimproject,
    init = function()
      vim.opt.sessionoptions:append "globals" -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
      -- vim.opt.sessionoptions:remove "tabpages"
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },

  -- --------------------
  -- tryin stuff
  -- --------------------
  -- {
  --   'stevearc/overseer.nvim',
  --   opts = {},
  -- },

  -- {
  --   "anurag3301/nvim-platformio.lua",
  --   dependencies = {
  --     { "akinsho/nvim-toggleterm.lua" },
  --     { "nvim-telescope/telescope.nvim" },
  --     { "nvim-lua/plenary.nvim" },
  --   },
  --   cmd = {
  --     "Pioinit",
  --     "Piorun",
  --     "Piocmd",
  --     "Piolib",
  --     "Piomon",
  --     "Piodebug",
  --   },
  -- },
}
