local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { { "biome", "prettierd" } },
    javascriptreact = { { "biome", "prettierd" } },
    typescript = { { "biome", "prettierd" } },
    typescriptreact = { { "biome", "prettierd" } },
    json = { { "biome", "prettierd" } },
    css = { { "biome", "prettierd" } },
    html = { "prettierd" },
    markdown = { "prettierd" },
    just = { "just" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    zig = { "zigfmt" },
    cpp = { "clang_format" },
    c = { "clang_format" },
    nix = { "alejandra" },
    vhdl = { "vsg" },
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format", "ruff_fix", "ruff_organize_imports" }
      else
        return { "isort", "black" }
      end
    end,
    -- tex = { "latexindent" },
    verilog = { "verible" },
    systemverilog = { "verible" },
  },
  ft_parsers = {
    md = "goldmark",
  },

  format_on_save = function(bufnr)
    local disable_filetypes = { c = false, cpp = false, md = true }
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,

  notify_on_error = true,
}
return options
