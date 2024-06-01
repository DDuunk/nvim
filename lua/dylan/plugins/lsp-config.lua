return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		-- LSP Support
		"neovim/nvim-lspconfig",
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",

		-- Scala LSP
		-- { "scalameta/nvim-metals",   opts = {}, dependencies = { "nvim-lua/plenary.nvim" } },

		-- Debugging
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",

		-- Useful Mason installer
		-- "WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP
		{ "j-hui/fidget.nvim", opts = { notification = { window = { align = "top" } } } },

		-- Additional lua configuration
		{ "folke/neodev.nvim", opts = {} },

		-- Copilot
		-- {
		-- 	"zbirenbaum/copilot.lua",
		-- 	opts = {
		-- 		suggestion = { enabled = false },
		-- 		panel = { enabled = false },
		-- 	},
		-- },
		-- { "zbirenbaum/copilot-cmp", opts = {} },

		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"jcha0713/cmp-tw2css",
	},
	config = function()
		local lsp = require("lsp-zero")
		local builtin = require("telescope.builtin")
		local keymap = vim.keymap

		lsp.on_attach(function(_, bufnr)
			lsp.default_keymaps({ buffer = bufnr })

			keymap.set("n", "gd", builtin.lsp_definitions, { buffer = bufnr })
			keymap.set("n", "gr", builtin.lsp_references, { buffer = bufnr })
			keymap.set("n", "gI", builtin.lsp_implementations, { buffer = bufnr })
			keymap.set("n", "K", vim.lsp.buf.hover, {})
			keymap.set("n", "<leader>D", builtin.lsp_type_definitions, { buffer = bufnr })
			keymap.set("n", "<leader>vds", builtin.lsp_document_symbols, { buffer = bufnr })
			keymap.set("n", "<leader>vws", builtin.lsp_dynamic_workspace_symbols, { buffer = bufnr })
			keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {})
			keymap.set("n", "[d", vim.diagnostic.goto_next, {})
			keymap.set("n", "]d", vim.diagnostic.goto_prev, {})
			keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {})
			keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {})
			keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {})
			keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, {})
			keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end)

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"html",
				"cssls",
				"tsserver",
				"angularls",
				"jsonls",
				"graphql",
				"tailwindcss",
				"rust_analyzer",
				"volar",
				"pyright",
			},
			handlers = {
				lsp.default_setup,
			},
		})

		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "it", "describe", "before_each", "after_each" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		require("lspconfig").tsserver.setup({
			commands = {
				OrganizeImports = {
					function()
						local params = {
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(0) },
							title = "",
						}
						vim.lsp.buf.execute_command(params)
					end,
					description = "Organize Imports",
				},
			},
		})

		-- require("lspconfig").tailwindcss.setup({
		--   capabilities = lsp.capabilities,
		--   on_attach = lsp.on_attach,
		--   autostart = false,
		-- })

		require("lspconfig").stylelint_lsp.setup({
			filetypes = { "css", "scss" },
			root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
			settings = {
				stylelintplus = {
					autoFixOnFormat = true,
					-- see available options in stylelint-lsp documentation
				},
			},
			on_attach = function(client)
				client.server_capabilities.document_formatting = false
			end,
		})

		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snipper = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			mapping = {
				["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			},
			sources = {
				-- { name = "copilot", group_index = 2 },
				{ name = "nvim_lsp", group_index = 2 },
				{ name = "nvim_lua", group_index = 2 },
				{ name = "luasnip", group_index = 2 },
				{ name = "path", group_index = 2 },
				{ name = "tw2css", group_index = 2 },
				{ name = "buffer", keyword_length = 5 },
			},
			formatting = lsp.cmp_format({ details = true }),
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		lsp.setup()

		-- vim.diagnostic.config({
		--   float = {
		--     focusable = false,
		--     style = "minimal",
		--     border = "rounded",
		--     source = "always",
		--     header = "",
		--     prefix = "",
		--   },
		-- })
		--

		local dap, dapui = require("dap"), require("dapui")

		require("neodev").setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
		})

		require("mason-nvim-dap").setup({
			ensure_installed = { "js", "bash" },
			handlers = {},
		})

		require("nvim-dap-virtual-text").setup({ commented = true })

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
		keymap.set("n", "<leader>dc", dap.continue, {})
	end,
}
