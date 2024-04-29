local overrides = require 'configs.overrides'

return {
  {
    'smoka7/hop.nvim',
    version = 'v2.5.1',
    cmd = {
      'HopWord',
    },
    config = function()
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
    end,
  },
  -- {
  --   'L3MON4D3/LuaSnip',
  --   opts = {
  --     history = true,
  --     updateevents = 'TextChanged,TextChangedI',
  --     enable_autosnippets = true,
  --     -- store_selection_keys = "<Tab>",
  --   },
  -- },
}
