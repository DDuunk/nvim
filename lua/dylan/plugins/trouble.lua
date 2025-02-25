return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = { focus = true },
  keys = {
    { "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", desc = "Trouble workspace diagnostics toggle" },
    { "<leader>tl", "<cmd>Trouble lsp toggle<CR>", desc = "Trouble lsp toggle" },
    { "<leader>tL", "<cmd>Trouble loclist toggle<CR>", desc = "Trouble loclist toggle" },
    { "<leader>td", "<cmd>TodoTrouble<CR>", desc = "Open TODOs in trouble" },
  },
}
