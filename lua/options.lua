local opt = vim.opt
local o = vim.o

--  NOTE:
-- :help vim.opt
-- :help option-list

opt.number = true
-- opt.numberwidth = 2
-- opt.ruler = false
-- opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
-- delay for which-key popup sooner
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
-- sets how neovim will display certain whitespace characters in the editor.
--  see `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- preview substitutions live, as you type!
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10
opt.hlsearch = true

opt.incsearch = true
opt.termguicolors = true
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false
-- opt.laststatus = 3
-- opt.pumheight = 10
opt.sidescrolloff = 3

o.laststatus = 3
o.cursorlineopt = "number"
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
--
-- opt.fillchars = { eob = " " }
--
-- disable nvim intro
opt.shortmess:append "sI"
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
vim.wo.wrap = false

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/luasnip"

local ft = require "Comment.ft"

-- ft.javascript = {'//%s', '/*%s*/'},
-- ft.yaml = '#%s',
ft.just = ft.get "make"

-- ft({ "go", "rust" }, ft.get "c")
-- ft({ "toml", "graphql" }, "#%s")
