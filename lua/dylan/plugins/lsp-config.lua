return {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    -- LSP Support
    "neovim/nvim-lspconfig",
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",

    -- LSP Endhints
    { "chrisgrieser/nvim-lsp-endhints", opts = {} },

    -- Angular
    "joeveiga/ng.nvim",

    -- Useful status updates for LSP
    { "j-hui/fidget.nvim", opts = { notification = { window = { align = "top" } } } },

    -- Additional lua configuration
    { "folke/neodev.nvim", opts = {} },

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp", dependencies = { "rafamadriz/friendly-snippets" } },
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local lsp = require("lsp-zero")
    local builtin = require("telescope.builtin")
    local ng = require("ng")

    local keymap = vim.keymap

    keymap.set("n", "<leader>at", ng.goto_template_for_component, { noremap = true, silent = true, desc = "[A]ngular goto template" })
    keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, { noremap = true, silent = true, desc = "[A]ngular goto component's file " })
    keymap.set("n", "<leader>aT", ng.get_template_tcb, { noremap = true, silent = true, desc = "[A]ngular display template typecheck block" })

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
          hint = {
            enable = true,
          },
        },
      },
    })

    local inlayHints = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    }

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
      settings = {
        typescript = {
          inlayHints = inlayHints,
        },
        javascript = {
          inlayHints = inlayHints,
        },
      },
    })

    require("lspconfig").angularls.setup({
      cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
      filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
      root_dir = require("lspconfig").util.root_pattern("angular.json", "package.json"),
    })

    require("lspconfig").stylelint_lsp.setup({
      filetypes = { "css", "scss" },
      root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
      settings = {
        stylelintplus = {
          autoFixOnFormat = true,
        },
      },
      on_attach = function(client)
        client.server_capabilities.document_formatting = false
      end,
    })

    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "buffer", keyword_length = 5 },
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
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
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = require("lspkind").cmp_format({
          mode = "text",
          maxwidth = 50, -- prevent the popup from showing more than provided characters
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
        }),
      },

      -- Enable luasnip to handle snippet expansion for nvim-cmp
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
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
  end,
}
