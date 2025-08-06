local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local dir = vim.fn.stdpath "state" .. "/sessions/"
local uv = vim.uv or vim.loop
local e = vim.fn.fnameescape

map("n", "<leader>qs", function()
  require("persistence").load()
end)

local function get_branch()
  if uv.fs_stat ".git" then
    local ret = vim.fn.systemlist("git branch --show-current")[1]
    return vim.v.shell_error == 0 and ret or nil
  end
end

local function current(opts)
  opts = opts or {}
  local name = vim.fn.getcwd():gsub("[\\/:]+", "%%")
  local branch = get_branch()
  if branch and branch ~= "main" and branch ~= "master" then
    name = name .. "%%" .. branch:gsub("[\\/:]+", "%%")
  end
  return dir .. name .. ".vim"
end

local function fire(event)
  vim.api.nvim_exec_autocmds("User", {
    pattern = "Persistence" .. event,
  })
end

local file = current()

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
  callback = function()
    if vim.fn.getcwd() ~= vim.env.HOME then
      if vim.fn.filereadable(file) == 0 then
        file = current { branch = false }
      end
      if file and vim.fn.filereadable(file) ~= 0 then
        fire "LoadPre"
        vim.cmd("silent! source " .. e(file))
        fire "LoadPost"
      end
    end
  end,
  nested = true,
})
