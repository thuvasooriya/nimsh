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

-- vim.api.nvim_create_autocmd("LspAttach", {
--   -- group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
--   callback = function(event)
--     --   local map = function(keys, func, desc)
--     --     vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "lsp: " .. desc })
--     --   end
--     -- jump to the definition of the word under your cursor.
--     --  this is where a variable was first declared, or where a function is defined, etc.
--     --  To jump back, press <C-t>.
--     -- map("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")
--
--     -- find references for the word under your cursor.
--     -- map("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
--
--     -- jump to the implementation of the word under your cursor.
--     --  useful when your language has ways of declaring types without an actual implementation.
--     -- map("gI", require("telescope.builtin").lsp_implementations, "[g]oto [I]mplementation")
--
--     -- jump to the type of the word under your cursor.
--     --  useful when you're not sure what type a variable is and you want to see
--     --  the definition of its *type*, not where it was *defined*.
--     -- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "type [D]efinition")
--
--     -- Fuzzy find all the symbols in your current document.
--     --  Symbols are things like variables, functions, types, etc.
--     -- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
--
--     -- Fuzzy find all the symbols in your current workspace.
--     --  Similar to document symbols, except searches over your entire project.
--     -- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
--
--     -- Rename the variable under your cursor.
--     --  Most Language Servers support renaming across files, etc.
--     -- map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
--
--     -- Execute a code action, usually your cursor needs to be on top of an error
--     -- or a suggestion from your LSP for this to activate.
--     -- map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
--
--     -- Opens a popup that displays documentation about the word under your cursor
--     --  See `:help K` for why this keymap.
--     -- map("K", vim.lsp.buf.hover, "hover do[K]umentation")
--
--     -- map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
--
--     -- The following two autocommands are used to highlight references of the
--     -- word under your cursor when your cursor rests there for a little while.
--     --    See `:help CursorHold` for information about when this is executed
--     --
--   end,
-- })

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
  dofile(vim.g.base46_cache .. "lsp")
  require "nvchad.lsp"

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

local servers = { "ruff", "html", "cssls", "tsserver", "clangd", "zls", "astro" }

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
