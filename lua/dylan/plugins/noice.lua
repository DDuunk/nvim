return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    --     "rcarriga/nvim-notify",
    --     -- "hrsh7th/nvim-cmp",
  },
  config = function()
    --     require("notify").setup({
    --       minimum_width = 50,
    --       max_width = 50,
    --       timeout = 3000,
    --       render = "wrapped-compact",
    --     })

    require("noice").setup({
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      lsp = {
        signature = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      status = {
        lsp_progress = { event = "lsp", kind = "progress" },
      },
      routes = {
        -- Ignore the typical vim change messages.
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d fewer lines" },
              { find = "%d more lines" },
            },
          },
          opts = { skip = true },
        },
        -- Don't show these in the default view.
        {
          filter = {
            event = "lsp",
            kind = "progress",
          },
          opts = { skip = true },
        },
      },
      cmdline = {
        view = "cmdline",
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
    })
  end,
}
