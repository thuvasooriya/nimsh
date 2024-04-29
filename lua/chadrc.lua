local M = {}

M.ui = {
  theme = 'catppuccin',
  transparency = true,
  tabufline = {
    order = { 'treeOffset', 'buffers', 'tabs' },
    -- sample module example
    -- modules = {
    -- 	abc = function()
    -- 		return "hi"
    -- 	end,
    -- },
  },
  statusline = {
    theme = 'vscode_colored', -- default/vscode/vscode_colored/minimal
  },
  -- nvdash = {
  --   load_on_startup = true,
  --   header = {
  --     '                                                                    ',
  --     '       ███████████           █████      ██                    ',
  --     '      ███████████             █████                            ',
  --     '      ████████████████ ███████████ ███   ███████    ',
  --     '     ████████████████ ████████████ █████ ██████████████  ',
  --     '    ██████████████    █████████████ █████ █████ ████ █████  ',
  --     '  ██████████████████████████████████ █████ █████ ████ █████ ',
  --     ' ██████  ███ █████████████████ ████ █████ █████ ████ ██████',
  --   },
  -- },
}

return M
