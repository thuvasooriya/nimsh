local M = {}

M.nvimproject = {
  -- scope_chdir = 'tab'
  projects = {
    "~/.phoenix",
    "~/.phoenix/config/*",
    -- mac specific
    "~/arc/pro/code/pydev/*",
    "~/arc/pro/code/hdl/*",
    "~/arc/pro/code/tmp/*",
    "~/arc/pro/code/lll/*dev/*",
    "~/dev/omnix/omnetpp-6.0.3/samples",
    "~/dev/omnix/inet-4.5.2/examples",
    "~/dev/omnix/inet-4.5.2/src/inet",
    -- linux specific
    "~/dev/*",
  },
}

M.harpoon_keys = {
  {
    "<leader>A",
    function()
      require("harpoon"):list():add()
    end,
    desc = "harpoon file",
  },
  {
    "<leader>a",
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
