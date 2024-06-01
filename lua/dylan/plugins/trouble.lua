return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  config = function()
    local trouble = require("trouble")

    trouble.setup()

    local keymap = vim.keymap

    keymap.set("n", "<leader>tt", function()
      trouble.toggle("diagnostics")
    end)
    keymap.set("n", "<leader>tl", function()
      trouble.toggle("lsp")
    end)
    keymap.set("n", "<leader>tL", function()
      trouble.toggle("loclist")
    end)
    keymap.set("n", "<leader>td", "<cmd>TodoTrouble<CR>", { desc = "Open TODOs in trouble" })
    -- keymap.set("n", "[t", function()
    --   trouble.next('diagnostics', { skip_groups = true, jump = true })
    -- end)
    -- keymap.set("n", "]t", function()
    --   trouble.previous({ skip_groups = true, jump = true })
    -- end)
  end,
}
