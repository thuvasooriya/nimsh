-- --------------------
-- motions
-- --------------------
local overrides = require "configs.overrides"
return {
  "tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically
  "tpope/vim-surround",
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mappings = {
          t = { j = { false } }, --lazygit navigation fix
          v = { j = { k = false } },
        },
      }
    end,
  },

  { -- easier comments
    "numToStr/Comment.nvim",
    opts = {},
  },

  { -- collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- better around/inside textobjects
      -- examples:
      --  - va)  - [v]isually select [a]round [)]paren
      --  - yinq - [y]ank [i]nside [n]ext [']quote
      --  - ci'  - [c]hange [i]nside [']quote
      require("mini.ai").setup { n_lines = 500 }
    end,
  },

  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    lazy = false,
    config = function()
      vim.keymap.set("n", "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
      vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
    end,
  },

  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = overrides.harpoon_keys,
  },
}
