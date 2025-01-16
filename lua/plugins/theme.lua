return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = { "italic" },
      functions = { "bold", "italic" },
      keywords = { "bold" },
      strings = { "italic" },
      variables = {},
      numbers = {},
      booleans = { "bold" },
      properties = {},
      types = { "underline" },
      operators = {},
      -- miscs = {}, -- uncomment to turn off hard-coded styles
    },
    color_overrides = {
      mocha = {
        base = "#11111b",
        mantle = "#11111b",
      },
    },
    custom_highlights = function(colors)
      return {
        Stl_Lsp = { fg = colors.green },
        Stl_normalmode = { fg = colors.blue },
        Stl_insertmode = { fg = colors.green },
        Stl_visualmode = { fg = colors.peach },
        Stl_commandmode = { fg = colors.mauve },
        Stl_Text = { fg = colors.text },
        Stl_Cwd = { fg = colors.flamingo },
        Stl_gitIcons = { fg = colors.mauve },
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
      leap = true,
    },
  },
}
