local overrides = require "configs.overrides"

return {
  "nvim-lua/plenary.nvim",
  require "plugins.motions",
  require "plugins.git",
  require "plugins.completions",
  require "plugins.telescope",
  require "plugins.lint",
  require "plugins.mini",
  -- --------------------
  -- ui stuff
  -- --------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function()
      return require "configs.catppuccin_config"
    end,
  },

  { -- dashboard
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = require("configs.alpha_config").setup,
  },

  -- { -- scope indent lines
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "User FilePost",
  -- },

  { -- highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = true },
  },

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
      return require "configs.treesitter_config"
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
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
    },
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} }, -- useful status updates for lsp
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("configs.lsp_config").config()
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
      return require "configs.conform_config"
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
      require("which-key").setup(opts)
    end,
  },

  -- --------------------
  -- files n projects stuff
  -- --------------------

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = function()
      return require "configs.oil_config"
    end,
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
}
