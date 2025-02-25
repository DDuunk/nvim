return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    keymap = {
      preset = "default",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-f>"] = {
        function(cmp)
          cmp.scroll_documentation_up(4)
        end,
      },
      ["<C-b>"] = {
        function(cmp)
          cmp.scroll_documentation_down(4)
        end,
      },
      -- ["<C-Space>"] = { "complete", "fallback" },
      -- ["<C-e>"] = { "abort", "fallback" },
      -- ["<C-l>"] = { "expand_or_jump", "fallback" },
      -- ["<C-h>"] = { "jump", "fallback" },

      -- ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      -- ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
      -- ["<C-f>"] = function(cmp) cmp.scroll_documentation_up(4) end
      -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      -- ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      -- ["<C-Space>"] = cmp.mapping.complete(),
      -- ["<C-e>"] = cmp.mapping.abort(),
      -- ["<C-l>"] = cmp.mapping(function()
      --   if luasnip.expand_or_locally_jumpable() then
      --     luasnip.expand_or_jump()
      --   end
      -- end, { "i", "s" }),
      -- ["<C-h>"] = cmp.mapping(function()
      --   if luasnip.locally_jumpable(-1) then
      --     luasnip.jump(-1)
      --   end
      -- end, { "i", "s" }),
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      -- add lazydev to your completion providers
      -- default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        snippets = {
          opts = {
            extended_filetypes = {
              typescript = { "angular" },
              html = { "angular" },
              htmlangular = { "angular" },
            },
          },
        },
      },
    },
    completion = {
      menu = {
        border = "single",
        draw = {
          treesitter = { "lsp" },
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
        },
      },
      -- Show documentation when selecting a completion item
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "single",
        show_documentation = true,
      },
    },
  },
}
