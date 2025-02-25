return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "David-Kunz/jester",
    -- Debug adapters
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
    "williamboman/mason.nvim",
    -- "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    local keymap = vim.keymap

    require("dapui").setup()
    require("dap-go").setup()
    require("jester").setup({
      cmd = "npx jest -t '$result' -- $file",
      dap = { console = "externalTerminal" },
    })

    require("nvim-dap-virtual-text").setup({
      -- This just tries to mitigate the chance that I leak tokens here. Probabily won't stop it from happening...
      display_callback = function(variable)
        local name = string.lower(variable.name)
        local value = string.lower(variable.value)
        if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
          return "*****"
        end

        if #variable.value > 15 then
          return " " .. string.sub(variable.value, 1, 15) .. "... "
        end

        return " " .. variable.value
      end,
    })

    keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
    keymap.set("n", "<leader>dc", dap.continue, {})

    -- Eval var under cursor
    keymap.set("n", "<leader>?", function()
      require("dapui").eval(nil, { enter = true })
    end)

    keymap.set("n", "<F1>", dap.continue)
    keymap.set("n", "<F2>", dap.step_into)
    keymap.set("n", "<F3>", dap.step_over)
    keymap.set("n", "<F4>", dap.step_out)
    keymap.set("n", "<F5>", dap.step_back)
    keymap.set("n", "<F13>", dap.restart)

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
