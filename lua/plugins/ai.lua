return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = "*", -- use false for release version
    opts = {
      provider = "copilot",
      cursor_applying_provider = "copilot",
      auto_suggestions_provider = "copilot",
      providers = {
        copilot = { model = "claude-4-sonnet" },
        ollama = {
          endpoint = "http://127.0.0.1:11434",
          timeout = 30000, -- milliseconds
          extra_request_body = {
            options = {
              temperature = 0.75,
              num_ctx = 20480,
              keep_alive = "5m",
            },
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_suggestions_respect_ignore = false,

        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        jump_result_buffer_on_finish = true,
        support_paste_from_clipboard = true,

        auto_focus_sidebar = true,
        minimize_diff = true,

        enable_cursor_planning_mode = true,
      },
      windows = {
        width = 50,
      },
      mappings = {
        -- suggestion = {
        --   accept = "<C-l>",
        --   next = "<C-]>",
        --   prev = "<C-[>",
        --   dismiss = "<Esc>",
        -- },
      },
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "MunifTanjim/nui.nvim",
      {
        "zbirenbaum/copilot.lua",
        opts = {
          suggestion = {
            -- auto_trigger = true,
            keymap = {
              accept = "<C-l>",
              accept_word = false,
              accept_line = false,
              next = "<C-]>",
              prev = "<C-[>",
              dismiss = "<Esc>",
            },
          },
          -- filetypes = {
          --   yaml = false,
          --   markdown = false,
          --   help = false,
          --   gitcommit = false,
          --   gitrebase = false,
          --   hgcommit = false,
          --   svn = false,
          --   cvs = false,
          --   ["."] = false,
          --   ["*"] = false,
          -- },
        },
      },
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
