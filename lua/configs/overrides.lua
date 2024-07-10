local M = {}

M.nvimproject = {
  -- scope_chdir = 'tab'
  last_session_on_startup = false,
  dashboard_mode = true,
  projects = {
    "~/.phoenix",
    "~/.phoenix/config/*",
    "~/dev/*dev/*",
  },
}

M.harpoon_keys = {
  {
    "<leader>h",
    function()
      require("harpoon"):list():add()
    end,
    desc = "harpoon file",
  },
  {
    "<leader>H",
    function()
      local harpoon = require "harpoon"
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "harpoon quick menu",
  },
  {
    "<leader>1",
    function()
      require("harpoon"):list():select(1)
    end,
    desc = "harpoon to file 1",
  },
  {
    "<leader>2",
    function()
      require("harpoon"):list():select(2)
    end,
    desc = "harpoon to file 2",
  },
  {
    "<leader>3",
    function()
      require("harpoon"):list():select(3)
    end,
    desc = "harpoon to file 3",
  },
  {
    "<leader>4",
    function()
      require("harpoon"):list():select(4)
    end,
    desc = "harpoon to file 4",
  },
  {
    "<leader>5",
    function()
      require("harpoon"):list():select(5)
    end,
    desc = "harpoon to file 5",
  },
}

return M
