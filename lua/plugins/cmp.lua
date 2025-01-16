return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
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
        -- list = {
        --   selection = function(ctx)
        --     return ctx.mode == "cmdline" and "auto_insert" or "preselect"
        --   end,
        -- },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
        },
      },
      signature = { enabled = true, window = { border = "rounded" } },
    },
    opts_extend = { "sources.default" },
  },
  { -- autopairing of (){}[] etc
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },
  { -- cmp sources plugins
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
}
