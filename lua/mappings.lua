local map = vim.keymap.set

-- NOTE: [[ editor ]]
map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })
map("n", "<leader>ln", "<cmd>set nu!<CR>", { desc = "toggle [l]ine [n]umber" })
map("n", "<leader>rl", "<cmd>set rnu!<CR>", { desc = "toggle [r]e[l]ative number" })
map("n", ";", ":", { desc = "enter command mode" })

-- NOTE: [[ lsp ]]
-- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })
-- map("n", "<Leader>ii", vim.cmd "DiagnosticsToggleVirtualText", { noremap = true, silent = true })
-- map("n", "<Leader>id", vim.cmd "DiagnosticsToggle", { noremap = true, silent = true })

-- NOTE: [[ terminal ]]
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })
-- map({ "n", "t" }, "<C-`>", "<cmd>Fterm<CR>", { desc = "terminal toggle" })

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

-- map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "<tab>", "<cmd>bn<CR>", { desc = "buffer go next" })
map("n", "<S-tab>", "<cmd>bp<CR>", { desc = "buffer go prev" })
-- map("n", "<leader>x", "<cmd>bd<CR>", { desc = "buffer close" })

-- "jj" and "jk" are mapped to <ESC>
-- no need because of using better-escape.neovim
-- map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

map("n", "<left>", '<cmd>echo "use h to move!!"<cr>', { noremap = true })
map("n", "<right>", '<cmd>echo "use l to move!!"<cr>', { noremap = true })
map("n", "<up>", '<cmd>echo "use k to move!!"<cr>', { noremap = true })
map("n", "<down>", '<cmd>echo "use j to move!!"<cr>', { noremap = true })

map("n", "<leader>fme", "<cmd> FormatEnable <CR>", { desc = "[f]or[m]at [e]nable" })
map("n", "<leader>fmd", "<cmd> FormatDisable <CR>", { desc = "[f]or[m]at [d]isable" })

-- lazy
map("n", "<leader>ls", "<cmd> Lazy sync <CR>", { desc = "lazy sync config" })
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

-- comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })
-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers initial_mode=normal<CR>", { desc = "telescope [f]ind [b]uffers" })
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
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
