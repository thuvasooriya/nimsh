return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = { "italic" },
      functions = { "bold", "italic" },
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = { "italic" },
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {
      mocha = {
        base = "#11111b",
        mantle = "#11111b",
        -- crust = "#11111b",
      },
    },
    custom_highlights = function(colors)
      return {
        -- Statusline highlights
        Stl_Lsp = { fg = colors.green },
        Stl_normalmode = { fg = colors.blue },
        Stl_insertmode = { fg = colors.green },
        Stl_visualmode = { fg = colors.peach },
        Stl_commandmode = { fg = colors.mauve },
        Stl_Text = { fg = colors.text },
        Stl_Cwd = { fg = colors.flamingo },
        Stl_gitIcons = { fg = colors.teal },
        Stl_file = { fg = colors.lavender },
        Stl_LspMsg = { fg = colors.yellow },
        Stl_PosText = { fg = colors.pink },
      }
    end,
    default_integrations = true,
    integrations = {
      blink_cmp = true,
      gitsigns = true,
      treesitter = true,
    },
  },
}
