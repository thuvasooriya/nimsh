local M = {}

M.dashboard = {}

function M.setup()
  require "alpha.term"

  local plugin = require "alpha"
  -- local fs = require "editor.fs"
  -- local function get_window_height()
  --   return vim.api.nvim_win_get_height(0)
  -- end

  local window_height = vim.api.nvim_win_get_height(0)

  M.dashboard = require "alpha.themes.dashboard"

  local section = {}

  section.padding = function(lines)
    return { type = "padding", val = lines }
  end

  local function reactive_h()
    if window_height > 24 then
      return {
        type = "terminal",
        command = "~/.config/nvim/logo.sh -c",
        width = 70,
        height = 10,
        opts = {
          redraw = true,
          window_config = {
            zindex = 1,
          },
        },
      }
    else
      return {
        type = "text",
        val = {
          [[neovim]],
        },
        opts = {
          hl = "Type",
          position = "center",
        },
      }
    end
  end

  -- terminal-based header
  section.header = reactive_h()
  -- section.project = {
  --   type = "text",
  --   val = fs.root { capitalize = false },
  --   opts = {
  --     hl = "AlphaTitle",
  --     position = "center",
  --   },
  -- }

  section.buttons = {
    type = "group",
    val = {
      M.dashboard.button("fp", "  recent projects", "<leader>fp"),
      M.dashboard.button("fP", "  explore projects", "<leader>fP"),
      M.dashboard.button("ff", "  find files", "<leader>ff"),
      M.dashboard.button(":q", "  quit", "<Cmd>q<CR>"),
    },
    opts = {
      spacing = 1,
    },
  }

  for _, button in ipairs(section.buttons.val) do
    button.opts.hl = "Normal"
    button.opts.hl_shortcut = "AlphaShortcut"
  end

  section.footer = {
    type = "text",
    val = "something awesome",
    opts = {
      hl = "Comment",
      position = "center",
    },
  }

  local function reactive_layout()
    if window_height > 24 then
      return {
        section.padding(8),
        section.header,
        section.padding(2),
        section.project,
        section.padding(1),
        section.buttons,
        section.padding(1),
        section.footer,
      }
    else
      return {
        -- section.padding(8),
        -- section.header,
        section.padding(2),
        section.project,
        section.padding(1),
        section.buttons,
        section.padding(1),
        section.footer,
      }
    end
  end
  M.dashboard.config.layout = reactive_layout()
  M.dashboard.section = section

  plugin.setup(M.dashboard.config)
end

function M.is_active()
  return vim.bo.filetype == "alpha"
end

function M.update_footer()
  local lazy = require "lazy"

  local stats = lazy.stats()
  local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

  M.dashboard.section.footer.val = "  in " .. ms .. "ms"

  pcall(function()
    vim.cmd "AlphaRedraw"
  end)
end

-- function M.on_open()
--   local theme = require "theme.highlights"
--   local lualine = require "plugins.lualine"
--
--   lualine.hide()
--   theme.disable_VertSplit()
-- end
--
-- function M.on_close()
--   local theme = require "theme.highlights"
--   local lualine = require "plugins.lualine"
--
--   lualine.show()
--   theme.enable_VertSplit()
-- end

return M
