return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufRead", "BufNewFile" },
  config = function()
    require("nvim-highlight-colors").setup({})
  end,
}
