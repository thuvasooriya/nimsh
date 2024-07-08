vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.base46_cache = vim.fn.stdpath 'data' .. '/nvchad/base46/'

vim.g.have_nerd_font = true
-- vim.keymap.set("", "<Space>", "<Nop>")

--  NOTE:
-- :help vim.opt
-- :help option-list

vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
-- delay for which-key popup sooner
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
-- sets how neovim will display certain whitespace characters in the editor.
--  see `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- preview substitutions live, as you type!
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
-- vim.opt.laststatus = 3
-- vim.opt.pumheight = 10
vim.opt.sidescrolloff = 3
vim.wo.wrap = false

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', lazyrepo, '--branch=stable', lazypath }
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local lazy_config = require 'configs.lazy'
require('lazy').setup({
  -- load plugins
  { import = 'plugins' },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. 'defaults')
dofile(vim.g.base46_cache .. 'statusline')

require 'nimsh.autocmds'

vim.schedule(function()
  require 'mappings'
end)
