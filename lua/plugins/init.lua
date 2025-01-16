return {
  "nvim-lua/plenary.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    dependencies = { { "nushell/tree-sitter-nu" } },
    opts = {

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

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
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
        markdown = { "deno_fmt" },
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
        asm = { "asmfmt" },
        -- vhdl = { "vsg" },
        -- TODO: cleanup
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format", "ruff_fix", "ruff_organize_imports" }
          else
            return { "isort", "black" }
          end
        end,
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
    },
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    -- TODO: cleanup
    opts = {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
      },
      constrain_cursor = "editable", -- "name"
      watch_for_changes = true,
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              require("oil").set_columns { "icon", "permissions", "size", "mtime" }
            else
              require("oil").set_columns { "icon" }
            end
          end,
        },
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          local m = name:match "^%."
          return m ~= nil
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        natural_order = "fast",
        case_insensitive = false,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      preview_win = {
        update_on_cursor_moved = true,
        preview_method = "fast_scratch",
        disable_preview = function(filename)
          return false
        end,
        win_options = {},
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "open parent directory" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function opts(desc)
          return { buffer = bufnr, desc = desc }
        end
        local map = vim.keymap.set
        map("n", "<leader>ghr", gs.reset_hunk, opts "[r]eset [h]unk")
        map("n", "<leader>ghp", gs.preview_hunk, opts "[p]review [h]unk")
        map("n", "<leader>gbl", gs.blame_line, opts "[b]lame [l]ine")
      end,
    },
  },

  "tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      mappings = {
        t = { j = { false } }, --lazygit navigation fix
        v = { j = { k = false } },
      },
    },
  },

  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    lazy = false,
    config = function()
      vim.keymap.set("n", "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
      vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
    end,
  },
}
