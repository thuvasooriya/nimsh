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
        basedpyright = {},
        html = {},
        cssls = {},
        biome = {},
        clangd = {},
        zls = {},
        rust_analyzer = {},
        glsl_analyzer = {},
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
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "lsp: " .. desc })
          end
          map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction", { "n", "x" })

          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has "nvim-0.11" == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}
