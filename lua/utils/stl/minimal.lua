local utils = require "utils.stl.utils"

--
--
--

local M = {}

M.mode = function()
  if not utils.is_activewin() then
    return ""
  end

  local modes = utils.modes
  local m = vim.api.nvim_get_mode().mode
  return "%#Stl_" .. modes[m][2] .. "mode#" .. "  " .. modes[m][1] .. " "
end

M.file = function()
  local x = utils.file()
  local name = " " .. x[2] .. " "
  return "%#Stl_file# " .. x[1] .. name
end

M.git = function()
  return "%#Stl_gitIcons#" .. utils.git()
end

M.diagnostics = utils.diagnostics

M.lsp = function()
  return "%#Stl_Lsp#" .. utils.lsp()
end
M.lsp_msg = function()
  return "%#St_LspMsg#" .. utils.lsp_msg()
end

M.cursor = "%#Stl_PosText# %l:%c "
M["%="] = "%="

M.cwd = function()
  local name = vim.uv.cwd()
  name = "%#Stl_Cwd# 󰉖 " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
  return (vim.o.columns > 85 and name) or ""
end

return function()
  return utils.generate("vscode", M)
end
