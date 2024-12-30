-- --------------------
-- motions
-- --------------------
local overrides = require "configs.overrides"
return {
  "tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically
  -- "tpope/vim-surround",
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
}
