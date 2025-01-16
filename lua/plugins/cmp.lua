return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "saghen/blink.compat", lazy = true, config = true },
      -- FIX: proper blink.cmp sources
      -- "saadparwaiz1/cmp_luasnip",
      -- "hrsh7th/cmp-nvim-lua",
      -- "hrsh7th/cmp-nvim-lsp",
      -- "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-path",
    },
    version = "*",
    opts = {
      keymap = { preset = "default" }, -- super-tab // enter
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
          winhighlight = "Normal:NormalFloat,CursorLine:BlinkCmpMenuSelection,Search:None,FloatBorder:CmpBorder",
          border = "rounded",
          scrollbar = false,
          -- draw = {},
        },
        documentation = {
          auto_show = true,
          treesitter_highlighting = true,
          window = { border = "rounded" },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "avante_commands",
          "avante_mentions",
          "avante_files",
        },
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90,
            opts = {},
          },
          avante_files = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 100,
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000,
            opts = {},
          },
        },
      },
      signature = { enabled = true, window = { border = "rounded" } },
    },
    opts_extend = { "sources.default" },
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      fast_wrap = {},
      disable_filetype = { "vim" },
    },
  },
}
