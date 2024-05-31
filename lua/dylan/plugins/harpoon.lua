return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup({})

    local keymap = vim.keymap

    keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    keymap.set("n", "<C-y>", function() harpoon:list():select(1) end)
    keymap.set("n", "<C-u>", function() harpoon:list():select(2) end)
    keymap.set("n", "<C-i>", function() harpoon:list():select(3) end)
    keymap.set("n", "<C-o>", function() harpoon:list():select(4) end)
  end,
}
