return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local trouble = require('trouble')

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
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'branch',
            fmt = function(str)
              if #str > 5 then
                return str:sub(1, 11) .. "..."
              else
                return str
              end
            end
          },
          { 'diff' },
          { 'diagnostics' },
        },
        lualine_c = {
          { 'filename', },
          {
            symbols.get,
            cond = symbols.has,
          }
        },
        lualine_x = {
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          },
          { 'encoding' },
          { "filetype" },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  end,
}
