local overrides = require 'configs.overrides'

return {
  {
    'NvChad/NvChad',
    lazy = false,
    branch = 'v2.5',
    import = 'nvchad.plugins',
    config = function()
      require 'options'
    end,
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require('configs.alpha').setup,
  },
  {
    'max397574/better-escape.nvim',
    -- event = 'InsertEnter',
    lazy = false,
    config = function()
      require('better_escape').setup()
    end,
  },

  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    config = function()
      require 'configs.conform'
    end,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').setup()
      require('telescope').load_extension 'fzf'
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').load_extension 'lazygit'
    end,
  },
  {
    'coffebar/neovim-project',
    opts = overrides.nvimproject,
    -- init = function()
    -- enable saving the state of plugins in the session
    -- vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    -- vim.opt.sessionoptions:remove("tabpages")
    -- end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'Shatur/neovim-session-manager' },
    },
    -- lazy = false,
    -- priority = 100,
  },
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true, -- or `opts = {}`
  },
  -- {
  --   'smoka7/hop.nvim',
  --   version = 'v2.5.1',
  --   cmd = {
  --     'HopWord',
  --   },
  --   config = function()
  --     require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
  --   end,
  -- },

  -- {
  --   'williamboman/mason.nvim',
  --   opts = overrides.mason,
  -- },

  -- {
  -- 	"williamboman/mason-lspconfig.nvim",
  -- },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('configs.lspconfig').defaults()
      require 'configs.lspconfig'
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = {
      'NvimTreeFocus',
    },
    opts = overrides.nvimtree,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
  },

  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').load_extension 'lazygit'
    end,
  },
  {
    'lervag/vimtex',
    init = function()
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_syntax_enabled = 0
      vim.g.vimtex_format_enabled = 1
      vim.g.vimtex_compiler_method = 'tectonic'
      -- vim.g.vimtex_compiler_method = 'generic'
      -- vim.g.vimtex_compiler_generic = {
      -- command = 'ls *.tex | entr -c nextonic build --keep-logs',
      -- }
      vim.g.vimtex_compiler_tectonic = {
        out_dir = '../build',
        -- hooks = [],
        options = {
          '-X',
          'compile',
          '-k',
          '--keep-logs',
          '--synctex',
        },
      }
    end,
    ft = 'tex',
  },
  {
    'L3MON4D3/LuaSnip',
    opts = {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
      -- store_selection_keys = "<Tab>",
    },
  },

  -- Don't judge me I don't know how to set this up yet
  -- {
  -- 	"ThePrimeagen/harpoon",
  -- 	branch = "harpoon2",
  -- 	-- init = function()
  -- 	--   require("core.utils").load_mappings "harpoon"
  -- 	-- end,
  -- 	opts = overrides.harpoon,
  -- 	-- dependencies = { "nvim-lua/plenary.nvim" },
  -- },
}

-- To make a plugin not be loaded
-- {
--   "NvChad/nvim-colorizer.lua",
--   enabled = false
-- },

-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
-- {
--   "mg979/vim-visual-multi",
--   lazy = false,
-- }
