local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
require "utils.fterm"
require "utils.mdpreview"

usercmd("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "disable autoformat-on-save",
  bang = true,
})

usercmd("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "re-enable autoformat-on-save",
})

autocmd("TextYankPost", {
  desc = "highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank { higroup = "MatchParen", timeout = 300 }
  end,
})
