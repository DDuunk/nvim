return {
  -- "windwp/nvim-autopairs",
  -- event = "InsertEnter",
  -- dependencies = {
  --   "hrsh7th/nvim-cmp",
  -- },
  -- config = function()
  --   local autopairs = require("nvim-autopairs")
  --   autopairs.setup({
  --     check_ts = true, -- Enable treesitter integration
  --     ts_config = {
  --       lua = { "string" }, -- Exclude pairs in Lua string nodes
  --       javascript = { "template_string" }, -- Exclude pairs in JavaScript template strings
  --       java = false, -- Disable treesitter checks for Java
  --     },
  --   })
  --
  --   -- Integrate nvim-autopairs with nvim-cmp
  --   require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
  -- end,
}
