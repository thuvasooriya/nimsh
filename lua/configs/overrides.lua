local M = {}

M.treesitter = {
  ensure_installed = {
    -- vim stuff
    'vim',
    'vimdoc',
    'lua',
    -- web dev
    'html',
    'css',
    'javascript',
    'typescript',
    'tsx',
    'json',
    'csv',
    'astro',
    'svelte',
    'dockerfile',
    -- utils
    'fish',
    'gitignore',
    'nix',
    'just',
    'make',
    'verilog',
    'toml',
    'yaml',
    'kdl',
    -- lll
    'cpp',
    'c',
    'zig',
    'arduino',
    -- mrk
    'markdown',
    'markdown_inline',
    'latex',
    'python',
  },
  indent = {
    enable = true,
    disable = {
      'python',
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    'lua-language-server',
    'stylua',
    -- web dev stuff
    'css-lsp',
    'html-lsp',
    'typescript-language-server',
    'prettierd',
    -- c/cpp stuff
    'clangd',
    'clang-format',

    'python-lsp-server',
    -- "zls",
    'texlab',
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.nvimproject = {
  -- scope_chdir = 'tab'
  projects = {
    '~/.phoenix',
    '~/.phoenix/config/*',
    -- mac specific
    '~/arc/pro/code/pydev/*',
    '~/arc/pro/code/hdl/*',
    '~/arc/pro/code/tmp/*',
    '~/arc/pro/code/lll/*dev/*',
    '~/dev/omnix/omnetpp-6.0.3/samples',
    '~/dev/omnix/inet-4.5.2/examples',
    '~/dev/omnix/inet-4.5.2/src/inet',
    -- linux specific
    '~/dev/*',
  },
}
-- M.nvimproject = {
-- 	-- scope_chdir = 'tab'
-- 	projects = {
-- 		function()
-- 			if vim.fn.has("win32") == 1 then
-- 			-- Windows configuration
-- 			-- vim.cmd("source C:/path/to/windows/config.lua")
-- 			elseif vim.fn.has("mac") == 1 then
-- 				-- macOS configuration
-- 				-- vim.cmd("source /path/to/mac/config.lua")
-- 				return {
-- 					"~/arc/pro/code/pydev/*",
-- 					"~/arc/pro/code/hdl/*",
-- 					"~/arc/pro/code/tmp/*",
-- 					"~/arc/pro/code/lll/*dev/*",
-- 					"~/.config/*",
-- 					"~/nix/omnix/omnetpp-6.0.3/samples",
-- 					"~/nix/omnix/inet-4.5.2/examples",
-- 					"~/nix/omnix/inet-4.5.2/src/inet",
-- 				}
-- 			else
-- 				-- Linux configuration
-- 				-- vim.cmd("source /path/to/linux/config.lua")
-- 				return {
-- 					"~/.config/*",
-- 					"~/dev/*",
-- 				}
-- 			end
-- 		end,
-- 	},
-- }

return M
