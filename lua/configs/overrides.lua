local M = {}

M.nvimproject = {
  -- scope_chdir = 'tab'
  last_session_on_startup = false,
  dashboard_mode = true,
  projects = {
    "~/.phoenix",
    "~/.phoenix/config/*",
    "~/dev/*dev/*",
    "~/dev/*",
    "~/dev/builds/*",
  },
  session_manager_opts = {
    autosave_ignore_dirs = {
      vim.fn.expand "~", -- don't create a session for $HOME/
      "/tmp",
    },
    autosave_ignore_filetypes = {
      "ccc-ui",
      "gitcommit",
      "gitrebase",
      "qf",
      "toggleterm",
      "NvimTree",
    },
  },
}

return M
