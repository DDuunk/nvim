local function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "#333333" })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#333333" })
  vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#333333" })
  vim.api.nvim_set_hl(0, "troublenormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "treesittercontext", { bg = "none", underline = true })
  vim.api.nvim_set_hl(0, "treesittercontextlinenumber", { bg = "none", underline = true })

  vim.api.nvim_set_hl(0, 'FidgetTitle', { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, 'FidgetTask', { link = "NormalFloat" })
end

return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent",   -- style for floating windows
        },
      })
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = true,
        },
      })

      ColorMyPencils()
    end,
  },
}
