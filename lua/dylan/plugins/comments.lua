return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10.0") == 1,
  config = function()
    vim.keymap.set({ "n", "v" }, "<C-_>", "gcc", { remap = true })
  end
}
