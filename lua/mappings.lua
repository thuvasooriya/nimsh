local map = vim.keymap.set

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })
map("n", ";", ":", { desc = "enter command mode" })

map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
-- map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })
-- map({ "n", "t" }, "<C-`>", "<cmd>Fterm<CR>", { desc = "terminal toggle" })

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

-- "jj" and "jk" are mapped to <ESC>
-- no need because of using better-escape.neovim
-- map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

map("n", "<left>", '<cmd>echo "use h to move!!"<cr>', { noremap = true })
map("n", "<right>", '<cmd>echo "use l to move!!"<cr>', { noremap = true })
map("n", "<up>", '<cmd>echo "use k to move!!"<cr>', { noremap = true })
map("n", "<down>", '<cmd>echo "use j to move!!"<cr>', { noremap = true })

map("n", "<leader>fme", "<cmd> FormatEnable <CR>", { desc = "[f]or[m]at [e]nable" })
map("n", "<leader>fmd", "<cmd> FormatDisable <CR>", { desc = "[f]or[m]at [d]isable" })

map("n", "<leader>ls", "<cmd> Lazy sync <CR>", { desc = "lazy sync config" })

map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })
