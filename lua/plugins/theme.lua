return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = function(colors)
      return {
        -- General highlights
        St_Mode = { fg = colors.peach, bg = colors.mantle },
        St_ModeSep = { fg = colors.mantle, bg = colors.mantle },
        St_file = { fg = colors.lavender, bg = colors.mantle },
        St_file_sep = { fg = colors.surface0, bg = colors.mantle },
        St_gitIcons = { fg = colors.teal, bg = colors.mantle },
        St_LspMsg = { fg = colors.yellow, bg = colors.mantle },
        St_Lsp = { fg = colors.green, bg = colors.mantle },
        St_cwd_icon = { fg = colors.sapphire, bg = colors.mantle },
        St_cwd_text = { fg = colors.text, bg = colors.mantle },
        St_cwd_sep = { fg = colors.surface0, bg = colors.mantle },
        St_pos_sep = { fg = colors.surface0, bg = colors.mantle },
        St_pos_icon = { fg = colors.pink, bg = colors.mantle },
        St_pos_text = { fg = colors.text, bg = colors.mantle },
        St_EmptySpace = { bg = colors.mantle },

        -- Mode highlight groups
        St_normalmode = { fg = colors.green, bg = colors.surface0 },
        St_insertmode = { fg = colors.blue, bg = colors.surface0 },
        St_visualmode = { fg = colors.mauve, bg = colors.surface0 },
        St_commandmode = { fg = colors.peach, bg = colors.surface0 },

        -- Additional highlights
        StText = { fg = colors.text, bg = colors.mantle },
        St_cwd = { fg = colors.lavender, bg = colors.mantle },
        St_git = { fg = colors.teal, bg = colors.mantle },
      }
    end,
    default_integrations = true,
    integrations = {
      -- cmp = true,
      blink_cmp = true,
      gitsigns = true,
      treesitter = true,
      -- mini = {
      --   enabled = true,
      --   indentscope_color = "",
      -- },
    },
  },
}
