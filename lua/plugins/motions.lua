local overrides = require "configs.overrides"
return {
  -- --------------------
  -- motions
  -- --------------------

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    -- lazy = false,
    config = function()
      require("better_escape").setup()
    end,
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
      -- add/delete/replace surroundings (brackets, quotes, etc.)
      -- examples:
      -- - saiw) - [s]urround [a]dd [i]nner [w]ord [)]paren
      -- - sd'   - [s]urround [d]elete [']quotes
      -- - sr)'  - [s]urround [r]eplace [)] [']
      require("mini.surround").setup()
    end,
  },

  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    lazy = false,
    config = function()
      -- require('leap').create_default_mappings()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
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
