return {
  { -- collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- better around/inside textobjects
      -- examples:
      --  - va)  - [v]isually select [a]round [)]paren
      --  - yinq - [y]ank [i]nside [n]ext [']quote
      --  - ci'  - [c]hange [i]nside [']quote
      require("mini.ai").setup { n_lines = 500 }
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- examples:
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup {
        mappings = {
          add = "ra", -- Add surrounding in Normal and Visual modes
          delete = "rd", -- Delete surrounding
          find = "rf", -- Find surrounding (to the right)
          find_left = "rF", -- Find surrounding (to the left)
          highlight = "rh", -- Highlight surrounding
          replace = "rr", -- Replace surrounding
          update_n_lines = "", -- Update `n_lines`

          suffix_last = "l", -- Suffix to search with "prev" method
          suffix_next = "n", -- Suffix to search with "next" method
        },
      }

      local statusline = require "mini.statusline"
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
}
