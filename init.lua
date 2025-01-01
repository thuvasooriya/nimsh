vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.have_nerd_font = true

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath }
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy_config"
require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

vim.cmd.colorscheme "catppuccin"

require "options"

vim.schedule(function()
  require "cmds"
  require "mappings"
end)

vim.o.statusline = "%!v:lua.require('utils.stl.minimal')()"
require("utils.stl.utils").autocmds()
