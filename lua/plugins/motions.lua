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

  -- {
  --   "ggandor/leap.nvim",
  --   dependencies = { "tpope/vim-repeat" },
  --   lazy = false,
  --   config = function()
  --     -- require('leap').create_default_mappings()
  --     vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
  --     vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
  --     vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
  --   end,
  -- },

  -- {
  --   "theprimeagen/harpoon",
  --   branch = "harpoon2",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("harpoon"):setup()
  --   end,
  --   keys = overrides.harpoon_keys,
  -- },
}
