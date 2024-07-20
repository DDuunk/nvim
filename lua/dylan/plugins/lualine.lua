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

    return {
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          -- stylua: ignore
          { "branch", fmt = function(str) if #str > 5 then return str:sub(1, 11) .. "..." else return str end end, },
          { "diff" },
          { "diagnostics" },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, padding = { left = 0, right = 1 } },
          { symbols.get, cond = symbols.has },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.lsp_progress.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.lsp_progress.has() end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}
