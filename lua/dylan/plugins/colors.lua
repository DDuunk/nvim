local function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  local highlights = {
    { group = "Normal", opts = { bg = "none" } },
    { group = "NormalFloat", opts = { bg = "none" } },
    { group = "CursorLine", opts = { bg = "#333333" } },
    { group = "ColorColumn", opts = { bg = "#333333" } },
    { group = "NotifyBackground", opts = { bg = "#333333" } },
    { group = "troublenormal", opts = { bg = "none" } },
    { group = "treesittercontext", opts = { bg = "none", underline = true } },
    { group = "treesittercontextlinenumber", opts = { bg = "none", underline = true } },
    { group = "FidgetTitle", opts = { link = "NormalFloat" } },
    { group = "FidgetTask", opts = { link = "NormalFloat" } },
    { group = "Visual", opts = { bg = "#333333" } },
    { group = "VisualNonText", opts = { fg = "#5D5F71", bg = "#333333" } },

    { group = "SnacksIndent1", opts = { fg = "#ea6962" } },
    { group = "SnacksIndent2", opts = { fg = "#d8a657" } },
    { group = "SnacksIndent3", opts = { fg = "#458588" } },
    { group = "SnacksIndent4", opts = { fg = "#8ec07c" } },
    { group = "SnacksIndent5", opts = { fg = "#d3869b" } },
    { group = "SnacksIndent6", opts = { fg = "#e78a4e" } },
    { group = "SnacksIndent7", opts = { fg = "#83a598" } },
  }

  for _, hl in ipairs(highlights) do
    vim.api.nvim_set_hl(0, hl.group, hl.opts)
  end
end

return {
  -- {
  --   "folke/tokyonight.nvim",
  --   config = function()
  --     require("tokyonight").setup({
  --       style = "storm",
  --       transparent = true,
  --       terminal_colors = true,
  --       styles = {
  --         comments = { italic = false },
  --         keywords = { italic = false },
  --         sidebars = "transparent",
  --         floats = "transparent",
  --       },
  --     })
  --   end,
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = { transparency = true },
      })

      ColorMyPencils()
    end,
  },

  -- "vague2k/vague.nvim",
  -- config = function()
  --   require("vague").setup({ transparent = true })
  --   vim.cmd("colorscheme vague")
  --   vim.cmd(":hi statusline guibg=NONE")
  -- end,
}
