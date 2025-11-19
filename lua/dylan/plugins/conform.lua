return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>gf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      rust = { "rustfmt" },
      javascript = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
      typescript = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
      graphql = { "prettierd", "prettier", "eslint_d" },
      go = { "gofumpt", "golines", "goimports-reviser" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      haskell = { "ormolu" },
      html = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
      json = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      gleam = { "gleam" },
      sql = { "sqlfmt" },
      asm = { "asmfmt" },
      terraform = { "terragrunt_hclfmt", "terraform_fmt" },
      nix = { "nixfmt" },
      scala = { "scalafmt" },
      -- yaml = { "yamlfix" },
      ["_"] = { "trim_whitespace" }, -- Default formatter for unconfigured filetypes
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
  -- config = function()
  --   require("conform").setup({
  --     formatters = {
  --       yamlfix = {
  --         command = "yamlfix",
  --         args = { "--in-place" },
  --       },
  --     }
  --   })
  -- end
}
