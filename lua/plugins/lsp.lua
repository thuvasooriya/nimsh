return {

  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
    },
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} }, -- useful status updates for lsp
      { "saghen/blink.cmp" },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  vim.fn.expand "$VIMRUNTIME/lua",
                  vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                  vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                },
              },
            },
          },
        },
        ruff = {},
        html = {},
        cssls = {},
        biome = {},
        clangd = {},
        zls = {},
        astro = {},
        veridian = {
          cmd = { "veridian" },
          filetypes = { "verilog", "systemverilog" },
          root_dir = function(fname)
            local lspconfutil = require "lspconfig/util"
            local root_pattern = lspconfutil.root_pattern("veridian.yml", ".git")
            local filename = vim.fn.filereadable(fname) == 1 and fname or vim.fn.expand(fname)
            return root_pattern(filename) or vim.fs.dirname(filename)
          end,
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require "lspconfig"
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}
