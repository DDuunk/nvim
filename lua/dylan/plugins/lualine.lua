return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local trouble = require("trouble")

    local symbols = trouble.statusline({
      mode = "symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      hl_group = "lualine_c_normal",
    })

    -- local noice = require("noice").api.status.lsp_progress
    local dap = require("dap")

    return {
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "branch",
            fmt = function(str)
              return #str > 11 and str:sub(1, 11) .. "..." or str
            end,
          },
          "diff",
          "diagnostics",
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, padding = { left = 0, right = 1 } },
          { symbols.get, cond = symbols.has },
        },
        lualine_x = {
          -- {
          --   -- function()
          --   --   return noice.get()
          --   -- end,
          --   -- cond = function()
          --   --   return package.loaded["noice"] and noice.has()
          --   -- end,
          -- },
          {
            function()
              return "  " .. dap.status()
            end,
            cond = function()
              return package.loaded["dap"] and dap.status() ~= ""
            end,
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}
