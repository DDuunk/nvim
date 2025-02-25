return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- LSP Support
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",

    -- LSP Endhints
    { "chrisgrieser/nvim-lsp-endhints", opts = {} },

    -- Angular
    -- "joeveiga/ng.nvim",

    -- Useful status updates for LSP
    { "j-hui/fidget.nvim", opts = { notification = { window = { align = "top" } } } },

    -- Additional lua configuration
    --     { "folke/neodev.nvim", opts = {} },
    {
      "folke/lazydev.nvim",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },

    -- Autocompletion
    "saghen/blink.cmp",
    --     "hrsh7th/nvim-cmp",
    --     "onsails/lspkind-nvim",
    --     "hrsh7th/cmp-nvim-lsp",
    --     "hrsh7th/cmp-path",
    --     "hrsh7th/cmp-buffer",
    --     "hrsh7th/cmp-cmdline",
    --     { "L3MON4D3/LuaSnip", build = "make install_jsregexp", dependencies = { "rafamadriz/friendly-snippets" } },
    --     "saadparwaiz1/cmp_luasnip",
    --     "rafamadriz/friendly-snippets",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local builtin = require("telescope.builtin")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local keymap = vim.keymap

    lspconfig.lua_ls.setup({ capabilites = capabilities })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "ts_ls",
        "angularls",
        "jsonls",
        "graphql",
        "rust_analyzer",
        "volar",
        "pyright",
        "terraformls",
        "java_language_server",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local opts = { buffer = event.buf }
        keymap.set("n", "gd", builtin.lsp_definitions, opts)
        keymap.set("n", "gr", builtin.lsp_references, opts)
        keymap.set("n", "gI", builtin.lsp_implementations, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, {})
        keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
        keymap.set("n", "<leader>D", builtin.lsp_type_definitions, opts)
        keymap.set("n", "<leader>vds", builtin.lsp_document_symbols, opts)
        keymap.set("n", "<leader>vws", builtin.lsp_dynamic_workspace_symbols, opts)
        keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {})
        keymap.set("n", "[d", vim.diagnostic.goto_next, {})
        keymap.set("n", "]d", vim.diagnostic.goto_prev, {})
        keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {})
        keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {})
        keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {})
        keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, {})

        -- keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        -- keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        -- keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        -- keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        -- keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        -- keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        -- keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        -- keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        -- keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        -- keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      end,
    })
  end,
}
