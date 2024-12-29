local M = {}
local on_init = M.on_init
local capabilities = M.capabilities
local on_attach = M.on_attach
local lspconfig = require "lspconfig"
local map = vim.keymap.set

M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "lsp " .. desc }
  end

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "[g]o to [d]efinition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>re", function()
    require "nvchad.lsp.renamer"()
  end, opts "NvRenamer")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
  map("n", "K", vim.lsp.buf.hover, opts "hover do[K]umentation")

  -- vim.api.nvim_create_autocmd("LspAttach", {
  --   group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  --   callback = function(event)
  --     -- When you move your cursor, the highlights will be cleared (the second autocommand).
  --     local client = vim.lsp.get_client_by_id(event.data.client_id)
  --     if client and client.server_capabilities.documentHighlightProvider then
  --       local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
  --       vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  --         buffer = event.buf,
  --         group = highlight_augroup,
  --         callback = vim.lsp.buf.document_highlight,
  --       })
  --
  --       vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  --         buffer = event.buf,
  --         group = highlight_augroup,
  --         callback = vim.lsp.buf.clear_references,
  --       })
  --
  --       vim.api.nvim_create_autocmd("LspDetach", {
  --         group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
  --         callback = function(event2)
  --           vim.lsp.buf.clear_references()
  --           vim.api.nvim_clear_autocmds {
  --             group = "kickstart-lsp-highlight",
  --             buffer = event2.buf,
  --           }
  --         end,
  --       })
  --     end
  --   end,
  -- })

  -- The following autocommand is used to enable inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  -- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
  --   map("<leader>th", function()
  --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  --   end, "[t]oggle inlay [h]ints")
  -- end
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
--
M.defaults = function()
  require("lspconfig").lua_ls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }
end

local servers = { "ruff", "html", "cssls", "biome", "clangd", "zls", "astro" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.verible.setup {
  on_attach = on_attach,
  root_dir = function()
    return vim.loop.cwd() -- fixes git problem with verible
  end,
  cmd = { "verible-verilog-ls", "--rules_config_search" },
  filetypes = { "verilog", "systemverilog" },
  format_on_save = true,
}

return M
