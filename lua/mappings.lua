local map = vim.keymap.set

-- NOTE: [[ editor ]]
map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })
map("n", "<leader>ln", "<cmd>set nu!<CR>", { desc = "toggle [l]ine [n]umber" })
map("n", "<leader>rl", "<cmd>set rnu!<CR>", { desc = "toggle [r]e[l]ative number" })
map("n", ";", ":", { desc = "enter command mode" })

-- NOTE: [[ lsp ]]
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- NOTE: [[ terminal ]]
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })

-- map("n", "<leader>h", function()
--   require("nvchad.term").new { pos = "sp" }
-- end, { desc = "terminal new horizontal term" })
--
-- map("n", "<leader>v", function()
--   require("nvchad.term").new { pos = "vsp" }
-- end, { desc = "terminal new vertical window" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- NOTE: [[ navigation ]]
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
-- map("i", "<C-h>", "<Left>", { desc = "move left" })
-- map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
-- "jj" and "jk" are mapped to <ESC>
-- no need because of using better-escape.neovim
-- map("i", "jk", "<ESC>", { desc = "Escape insert mode" })
map("n", "<left>", '<cmd>echo "use h to move!!"<cr>', { noremap = true })
map("n", "<right>", '<cmd>echo "use l to move!!"<cr>', { noremap = true })
map("n", "<up>", '<cmd>echo "use k to move!!"<cr>', { noremap = true })
map("n", "<down>", '<cmd>echo "use j to move!!"<cr>', { noremap = true })
-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })

-- [[ plugin mappings]]
-- conform
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "[f]ormat [f]iles" })
-- lazy
map("n", "<leader>ls", "<cmd> Lazy sync <CR>", { desc = "lazy sync config" })
-- lazygit
map("n", "<leader>gg", "<cmd> LazyGit <CR>", { desc = "lazygit open" })
-- neovim-project
map("n", "<leader>fP", "<cmd> Telescope neovim-project discover <CR>", { desc = "telescope find projects" })
map(
  "n",
  "<leader>fp",
  "<cmd> Telescope neovim-project history initial_mode=normal<cr>",
  { desc = "telescope history projects" }
)
-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- tabufline
-- map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })
-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope [f]ind [b]uffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope [f]ind [h]elp" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find [ma]rks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope [f]ind [o]ldfiles" })
map(
  "n",
  "<leader>fz",
  "<cmd>Telescope current_buffer_fuzzy_find<CR>",
  { desc = "telescope [f]ind in current buffer[z]" }
)
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "telescope [g]it [c]ommits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "telescope [g]it [s]tatus" })
map("n", "<leader>pt", "<cmd>Telescope terms initial_mode=normal<CR>", { desc = "telescope [p]ick hidden [t]erm" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
