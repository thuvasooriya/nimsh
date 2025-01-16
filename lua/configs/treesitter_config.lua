local options = {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ensure_installed = {
    -- vim stuff
    "vim",
    "vimdoc",
    "lua",
    "luadoc",
    "diff",
    "printf",
    -- web dev
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "csv",
    "astro",
    "svelte",
    -- utils
    "bash",
    "fish",
    "gitignore",
    "nix",
    "just",
    "nu",
    "make",
    "verilog",
    "toml",
    "yaml",
    "kdl",
    "dockerfile",
    -- lll
    "cpp",
    "c",
    "zig",
    "arduino",
    -- mrk
    "markdown",
    "markdown_inline",
    "python",
  },

  -- sync_install = true,
  auto_install = false,

  -- highlight = {
  --   enable = true,
  --   additional_vim_regex_highlighting = { "ruby" },
  -- },
  -- indent = { enable = true, disable = { "ruby" } },
}

return options
