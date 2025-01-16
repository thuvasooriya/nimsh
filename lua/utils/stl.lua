-- minimal statusline for neovim
-- yoinked from nvchad and modified to my liking

local M = {}

local spinners = { "", "", "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
local autocmd = vim.api.nvim_create_autocmd
autocmd("LspProgress", {
  pattern = { "begin", "end" },
  callback = function(args)
    local data = args.data.params.value
    local progress = ""

    if data.percentage then
      local idx = math.max(1, math.floor(data.percentage / 10))
      local icon = spinners[idx]
      progress = icon .. " " .. data.percentage .. "%% "
    end

    local str = progress .. (data.message or "") .. " " .. (data.title or "")
    M.lsp_msg = data.kind == "end" and "" or str
    vim.cmd.redrawstatus()
  end,
})

M.stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.is_activewin = function()
  return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

M.modes = {
  ["n"] = { "NORMAL", "Normal" },
  ["no"] = { "NORMAL (no)", "Normal" },
  ["nov"] = { "NORMAL (nov)", "Normal" },
  ["noV"] = { "NORMAL (noV)", "Normal" },
  ["noCTRL-V"] = { "NORMAL", "Normal" },
  ["niI"] = { "NORMAL i", "Normal" },
  ["niR"] = { "NORMAL r", "Normal" },
  ["niV"] = { "NORMAL v", "Normal" },
  ["nt"] = { "NTERMINAL", "NTerminal" },
  ["ntT"] = { "NTERMINAL (ntT)", "NTerminal" },

  ["v"] = { "VISUAL", "Visual" },
  ["vs"] = { "V-CHAR (Ctrl O)", "Visual" },
  ["V"] = { "V-LINE", "Visual" },
  ["Vs"] = { "V-LINE", "Visual" },
  [""] = { "V-BLOCK", "Visual" },

  ["i"] = { "INSERT", "Insert" },
  ["ic"] = { "INSERT (completion)", "Insert" },
  ["ix"] = { "INSERT completion", "Insert" },

  ["t"] = { "TERMINAL", "Terminal" },

  ["R"] = { "REPLACE", "Replace" },
  ["Rc"] = { "REPLACE (Rc)", "Replace" },
  ["Rx"] = { "REPLACEa (Rx)", "Replace" },
  ["Rv"] = { "V-REPLACE", "Replace" },
  ["Rvc"] = { "V-REPLACE (Rvc)", "Replace" },
  ["Rvx"] = { "V-REPLACE (Rvx)", "Replace" },

  ["s"] = { "SELECT", "Select" },
  ["S"] = { "S-LINE", "Select" },
  [""] = { "S-BLOCK", "Select" },
  ["c"] = { "COMMAND", "Command" },
  ["cv"] = { "COMMAND", "Command" },
  ["ce"] = { "COMMAND", "Command" },
  ["cr"] = { "COMMAND", "Command" },
  ["r"] = { "PROMPT", "Confirm" },
  ["rm"] = { "MORE", "Confirm" },
  ["r?"] = { "CONFIRM", "Confirm" },
  ["x"] = { "CONFIRM", "Confirm" },
  ["!"] = { "SHELL", "Terminal" },
}

M.mode = function()
  if not M.is_activewin() then
    return ""
  end
  local mode = vim.api.nvim_get_mode().mode
  local mode_data = M.modes[mode] or M.modes["n"]
  return "%#Stl_" .. mode_data[2] .. "mode#" .. "  " .. mode_data[1] .. " "
end

M.file = function()
  local path = vim.api.nvim_buf_get_name(M.stbufnr())
  local name = (path == "" and "Empty") or path:match "([^/\\]+)[/\\]*$"
  local icon = "󰈚"
  local has_devicons, devicons = pcall(require, "nvim-web-devicons")
  if has_devicons and name ~= "Empty" then
    local ft_icon = devicons.get_icon(name)
    icon = ft_icon or icon
  end
  return "%#Stl_file# " .. icon .. " " .. name .. " "
end

M.git = function()
  if not vim.b[M.stbufnr()].gitsigns_head or vim.b[M.stbufnr()].gitsigns_git_status then
    return ""
  end
  local git_status = vim.b[M.stbufnr()].gitsigns_status_dict
  local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
  local branch_name = "%#Stl_gitIcons# " .. git_status.head
  return " "
    .. branch_name
    .. "%#GitSignsAdd#"
    .. added
    .. "%#GitSignsChange#"
    .. changed
    .. "%#GitSignsDelete#"
    .. removed
end

M.diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end
  local err = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.ERROR })
  local warn = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(M.stbufnr(), { severity = vim.diagnostic.severity.INFO })
  err = (err and err > 0) and ("%#LspDiagnosticsError#" .. " " .. err .. " ") or ""
  warn = (warn and warn > 0) and ("%#LspDiagnosticsWarning#" .. " " .. warn .. " ") or ""
  hints = (hints and hints > 0) and ("%#LspDiagnosticsHint#" .. "󰛩 " .. hints .. " ") or ""
  info = (info and info > 0) and ("%#LspDiagnosticsInformation#" .. "󰋼 " .. info .. " ") or ""
  return " " .. err .. warn .. hints .. info
end

M.lsp = function()
  if not rawget(vim, "lsp") then
    return ""
  end

  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.attached_buffers[M.stbufnr()] then
      local lsp_string = (vim.o.columns > 100 and "   LSP ~ " .. client.name .. " ") or "   LSP "
      return "%#Stl_Lsp#" .. lsp_string
    end
  end
  return ""
end

M.lsp_msg = function()
  return "%#St_LspMsg#" .. (vim.o.columns < 120 and "" or M.state.lsp_msg)
end

M.cwd = function()
  local name = vim.uv.cwd()
  name = "%#Stl_Cwd# 󰉖 " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
  return (vim.o.columns > 85 and name) or ""
end

M.position = "%#Stl_PosText# %l:%c "
M.separator = "%="

M.get_statusline = function()
  local stl = {
    M.mode(),
    M.file(),
    M.git(),
    M.separator,
    M.diagnostics(),
    M.lsp(),
    M.position,
    M.cwd(),
  }
  return table.concat(stl)
end

return M
