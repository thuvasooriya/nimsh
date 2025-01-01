local utils = require "utils.stl.utils"

-- local sep_l = separators["left"]
-- local sep_r = separators["right"]
--
-- local M = {}
--
-- M.mode = function()
--   if not utils.is_activewin() then
--     return ""
--   end
--
--   local modes = utils.modes
--
--   local m = vim.api.nvim_get_mode().mode
--
--   local current_mode = "%#St_" .. modes[m][2] .. "Mode#  " .. modes[m][1]
--   local mode_sep1 = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_r
--   return current_mode .. mode_sep1 .. "%#ST_EmptySpace#" .. sep_r
-- end
--
-- M.file = function()
--   local x = utils.file()
--   local name = " " .. x[2] .. (sep_style == "default" and " " or "")
--   return "%#St_file# " .. x[1] .. name .. "%#St_file_sep#" .. sep_r
-- end
--
-- M.git = function()
--   return "%#St_gitIcons#" .. utils.git()
-- end
--
-- M.lsp_msg = function()
--   return "%#St_LspMsg#" .. utils.lsp_msg()
-- end
--
-- M.diagnostics = utils.diagnostics
--
-- M.lsp = function()
--   return "%#St_Lsp#" .. utils.lsp()
-- end
--
-- M.cwd = function()
--   local icon = "%#St_cwd_icon#" .. "󰉋 "
--   local name = vim.uv.cwd()
--   name = "%#St_cwd_text#" .. " " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
--   return (vim.o.columns > 85 and ("%#St_cwd_sep#" .. sep_l .. icon .. name)) or ""
-- end
--
-- M.cursor = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# %p %% "
-- M["%="] = "%="
--
-- return function()
--   return utils.generate("default", M)
-- end
--

local M = {}

M.mode = function()
  if not utils.is_activewin() then
    return ""
  end

  local modes = utils.modes
  local m = vim.api.nvim_get_mode().mode
  return "%#St_" .. modes[m][2] .. "mode#" .. "  " .. modes[m][1] .. " "
end

M.file = function()
  local x = utils.file()
  local name = " " .. x[2] .. " "
  return "%#StText# " .. x[1] .. name
end

M.git = utils.git
M.lsp_msg = utils.lsp_msg
M.diagnostics = utils.diagnostics

M.lsp = function()
  return "%#St_Lsp#" .. utils.lsp()
end

M.cursor = "%#StText# Ln %l, Col %c "
M["%="] = "%="

M.cwd = function()
  local name = vim.uv.cwd()
  name = "%#St_cwd# 󰉖 " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
  return (vim.o.columns > 85 and name) or ""
end

return function()
  return utils.generate("vscode", M)
end
