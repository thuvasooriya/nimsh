return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function opts(desc)
          return { buffer = bufnr, desc = desc }
        end
        local map = vim.keymap.set
        map("n", "<leader>ghr", gs.reset_hunk, opts "[r]eset [h]unk")
        map("n", "<leader>ghp", gs.preview_hunk, opts "[p]review [h]unk")
        map("n", "<leader>gbl", gs.blame_line, opts "[b]lame [l]ine")
      end,
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  },
}
