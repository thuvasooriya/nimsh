return {
  "tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically
  -- "tpope/vim-surround",
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      mappings = {
        t = { j = { false } }, --lazygit navigation fix
        v = { j = { k = false } },
      },
    },
    -- config = function()
    --   require("better_escape").setup {}
    -- end,
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
    "echasnovski/mini.ai",
    -- better around/inside textobjects
    -- examples:
    --  - va)  - [v]isually select [a]round [)]paren
    --  - yinq - [y]ank [i]nside [n]ext [']quote
    --  - ci'  - [c]hange [i]nside [']quote
  },
}
