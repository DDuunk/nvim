return {
	-- "nvimtools/none-ls.nvim",
	-- dependencies = { "nvim-lua/plenary.nvim" },
	-- config = function()
	-- 	local null_ls = require("null-ls")
	--
	-- 	null_ls.setup({
	-- 		sources = {
	-- 			null_ls.builtins.diagnostics.editorconfig_checker,
	-- 			null_ls.builtins.formatting.stylua,
	-- 			null_ls.builtins.formatting.prettier.with({
	-- 				extra_filetypes = { "mdx" },
	-- 			}),
	-- 			null_ls.builtins.completion.spell,
	-- 		},
	-- 	})
	-- end,
	--
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		require("mason-null-ls").setup({
			ensure_installed = {
				-- Opt to list sources here, when available in mason.
				"editorconfig_checker",
				"stylua",
				"prettier",
			},
			automatic_installation = false,
			handlers = {},
		})

		null_ls.setup({
			sources = {
				-- Anything not supported by mason.
				null_ls.builtins.completion.spell,
			},
		})
	end,
}
