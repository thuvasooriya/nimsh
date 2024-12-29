local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    json = { "biome" },
    css = { "biome" },
    html = { "prettierd" },
    markdown = { "prettierd" },
    just = { "just" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    zig = { "zigfmt" },
    cpp = { "clang_format" },
    c = { "clang_format" },
    ino = { "clang_format" },
    arduino = { "clang_format" },
    rust = { "rustfmt", lsp_format = "fallback" },
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
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    local disable_filetypes = { c = false, cpp = false, md = true }
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,

  notify_on_error = true,
}

return options
