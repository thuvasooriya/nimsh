return {

  { -- linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        markdown = { "markdownlint" },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}

-- {
--   "mfussenegger/nvim-lint",
--
--   event = {
--     "BufReadPre",
--     "BufNewFile",
--     "BufWritePost",
--     "TextChanged",
--     "InsertLeave",
--   },
--   config = function()
--     local lint = require "lint"
--
--     lint.linters_by_ft = {
--       systemverilog = { "verilator" },
--       verilog = { "verilator" },
--     }
--
--     -- local verilator = lint.linters.verilator
--     -- lint.linters.verilator.args = {
--     --   "-sv",
--     --   "-Wall",
--     --   "--bbox-sys",
--     --   "--bbox-unsup",
--     --   "--lint-only",
--     --   "--relative-includes",
--     --   "-f",
--     --   -- vim.fs.find("verilator.f", { upward = true, stop = vim.env.HOME })[1],
--     -- }
--
--     -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
--     --   group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
--     --   callback = function()
--     --     vim.defer_fn(function()
--     --       lint.try_lint()
--     --     end, 1)
--     --   end,
--     -- })
--   end,
-- },
